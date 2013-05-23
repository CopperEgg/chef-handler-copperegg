require 'rubygems'
require 'chef'
require 'chef/handler'

class Chef
  class Handler
    class Copperegg < Chef::Handler

      def initialize(opts = {})
        @opts = opts 
        @apikey = opts['apikey']
        @annotate_success = opts['annotate_success']
        @annotate_fail = opts['annotate_fail']
        @tags = opts['tags']
        @hostname = opts['hostname']
        @cuegg = CopperEgg::API.new(@apikey,'handler')
      end

      def report
     
        elapsed = run_status.elapsed_time.to_i
        if elapsed < 60                                       # force duration to be >= 1 min for annotations to display
          annot_endtime = run_status.start_time.to_i + 60
        else
          annot_endtime = run_status.end_time.to_i
        end
        elapsed_str = elapsed.to_s + (elapsed <= 1 ? 'second' : 'seconds')

        if run_status.success? && @annotate_success 
          Chef::Log.info("CopperEgg Chef Handler: Chef Run Successful, host:  #{@hostname}")
          note = "Chef Run Completed in #{elapsed_str} on #{@hostname}. Updated #{run_status.updated_resources.length} of #{run_status.all_resources.length} Resources. Tags are #{@tags}"
          label =  'green'       

        elsif run_status.failed? && @annotate_fail
          Chef::Log.info("CopperEgg Chef Handler: Chef Run Failed, host:  #{@hostname}")
          note = "Chef Run FAILED in #{elapsed_str} on #{@hostname}; #{run_status.formatted_exception}.  Tags are #{@tags}"
          label =  'red'

        else
          Chef::Log.debug("CopperEgg Chef Handler: Unknown")
          return
        end

        params = {'note' => note,
                  'starttime' => run_status.start_time.to_i,
                  'endtime' => annot_endtime,
                  'label' => label,
                  'tags' => @tags  }
        @cuegg.create_annotation(@hostname, params)
        
      end

    end #end class Copperegg
  end #end class Handler
end #end class Chef









