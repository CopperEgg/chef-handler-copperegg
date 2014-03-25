chef-handler-copperegg

Chef Handler to create annotations at CopperEgg for chef runs.

Recent Changes
Updated to version 0.1.4 on 3/25/14

NOTE: Other that the updated version code (from 0.1.3 to 0.1.4), this code has not been modified since 4/2013. 


====Description====

This is a simple Chef report and exception handler that reports status of a Chef run to your CopperEgg UI.

http://wiki.opscode.com/display/chef/Exception+and+Report+Handlers

To enable this functionality, add the following in your run_list:
* copperegg 
* chef_handler
* coppereg-handler

On your next Chef run, the gem 'chef-handler-copperegg.gem' will be downloaded and installed on the client.

You shouldn't need to do anything else.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

