# Static site server

To do this project I have created a cloud server using Parspack panel. after that with ssh I have connected to server and setup a nginx server to serve some static sites.

project <a href="https://roadmap.sh/projects/static-site-server">link</a>.

### Things I have done:

    1- setup a server
    2- use ssh and config server
    3- setup nginx for server
    4- using iptables to only allow a few ports to be available to outside. (22, 53, 80 etc.)
    5- using scp to transfer a build nuxt app.
    6- running app on port 4000
    7- improving the app with nginx to serve as reverse proxy. (serves static and forwards app related request to nuxt server)
    8- using rsync to sync my static contents.
