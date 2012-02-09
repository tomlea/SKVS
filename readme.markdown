SKVS - Simple Key/Value Store
=============================

A dirt simple HTTP key value store, with a fancy UI.

Usage
-----
1. Install the gem:

   $ gem install skvs

2. Start the server:

   $ skvs

3. Navigate the the UI:

   [http://localhost:7654/](http://localhost:7654/)
  

Example Bash Client
-------------------

    function skvs_pull(){
      echo $(curl -s -o - "http://localhost:7654/$1")
    }

    function skvs_push(){
      local key
      key=$1
      shift
      curl -XPUT --data-binary "$*" -s -o /dev/null "http://localhost:7654/$key"
    }

