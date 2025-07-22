# EC2 instance

Not in amazon but I have ued <a href="https://panel.arvancloud.ir/ecc"> Arvan Cloud EC2</a>.
<br>
Followings are things I usually do for creating a basic worker node, which I mainly use as a lab to flex my devops skills.

### How to do that?

    1- just login and go to cloud server panel.
    2- create a server with your required config
    3- use ssh pair key so you get the private key.
    4- config the server.
        1- add passphrase
        2- remove password login in sshd
        3- in your local use agent to hold passphrase if you need to go back and forth a lot.
        4- update server and terminal.
        5- install your tools (I use zsh (+oh-my-zsh) and vim)
    5- congrats, its done.

### My do these as well

    1- config firewall(iptables) setting, (I only expose using ports like 22, and 80 for nginx)
    2- might config some dns for inner use with bind9.
