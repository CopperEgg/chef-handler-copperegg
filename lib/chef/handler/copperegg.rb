require 'rubygems'
require 'chef'
require 'chef/handler'

class Chef
  class Handler
    class Copperegg < Chef::Handler

      def initialize(opts = nil)
        opts = opts || {}
        @api_key = opts[:api_key]
        @cuegg = CopperEgg::API.new(@apikey,'handler')
      end

      def report
        hostname = run_status.node.name

        # Send the metrics
        begin
          Chef::Log.debug("CopperEgg Handler: chef.resources.total for host #{hostname} :  #{run_status.all_resources.length}")
          Chef::Log.debug("CopperEgg Handler: chef.resources.updated for host  #{hostname} : #{run_status.updated_resources.length}")
          Chef::Log.debug("CopperEgg Handler: chef.resources.elapsed_time for host  #{hostname} : #{run_status.elapsed_time}")
          Chef::Log.debug("CopperEgg Handler: Submitted chef metrics")
        rescue Errno::ECONNREFUSED, Errno::ETIMEDOUT => e
          Chef::Log.error("Could not send metrics to Copperegg. Connection error:\n" + e)
        end

        event_title = ""
        run_time = pluralize(run_status.elapsed_time, "second")
        if run_status.success?
          Chef::Log.debug("CopperEgg Handler: Chef Run Successful")
          alert_type = "success"
          event_priority = "low"
          event_title << "Chef completed in #{run_time} on #{hostname} "
        else
          event_title << "Chef failed in #{run_time} on #{hostname} "
        end

        event_data = "Chef updated #{run_status.updated_resources.length} resources out of #{run_status.all_resources.length} resources total."

        if run_status.failed?
          Chef::Log.debug("CopperEgg Handler: Chef Run Failed #{run_status.formatted_exception}")

          alert_type = "error"
          event_priority = "normal"
        end

      end

      private

      def pluralize(number, noun)
        begin
          case number
          when 0..1
            "less than 1 #{noun}"
          else
            "#{number.round} #{noun}s"
          end
        rescue
          Chef::Log.warn("Cannot make #{number} more legible")
        end
      end

    end #end class Copperegg
  end #end class Handler
end #end class Chef
