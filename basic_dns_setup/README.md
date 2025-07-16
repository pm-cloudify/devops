# Basic DNS setup

here I have described my solution. since I could not provide a domain name, I needed to register for nic handle :>
I created my own dns server.

### Solution:

    1- I configured bind9 using on my server (read bind9.md guide. it is provided with help of text generator tools)
    2- I added my domain example.com to my dns server so it will point to my server with the nginx server configured on it. and forwarded other dns request to 8.8.8.8
    4- I used this server ip in my local device resolver.
    5- I browsed my example.com in chrome and it resolved it to the server I wanted.

### Tools used:

    ssh -> connect to server
    dig -> test your dns
    iptables -> allow port 53 to be accessible.
    bind9 -> configure so I could use my server as my dns

### Bind9

Here is the link of full docs for bind9: <a href="https://bind9.readthedocs.io/">link</a>
