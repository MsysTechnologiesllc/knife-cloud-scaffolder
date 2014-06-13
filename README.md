knife-cloud-scaffolder
======================

Code generator for writing knife-cloud based plugins. Git clone this repo and run the command as below. The current version of the knife-cloud scaffolder assumes the plugin uses Fog. So if you are not using Fog, you will have to make changes accordingly. We plan to add more features to this scaffolder soon!

Command
=======
    ruby knifecloudgen.rb <destination folder> <properties file>

Example
=======

    ruby knifecloudgen.rb ./knife-azure ./properties.json

  Then just setup git repo in destination folder.

= LICENSE:
---------
Author:: Mukta Aphale (<mukta.aphale@clogeny.com>)

Author:: Kaustubh Deorukhkar (<kaustubh@clogeny.com>)

Copyright:: Copyright (c) 2014 Clogeny.

License:: Apache License, Version 2.0


Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
