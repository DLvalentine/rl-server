# RL Server

### What is this?
TL;DR I'm thinking about making something akin to crawl.akrasiac.org (the ssh login for dcss) for multiple RLs.

I'm going to start by creating a simple Debian image that updates itself and then installs angband, then runs it. Later on, I'd like to add login systems, expose ssh, have a game selection system, that sort of thing. 

If it all works out on the container, I'll ship that via DigitalOcean or some other chepaer service like Linode.

### Stretch goals?

It'd be sick to use tmux or something to have a chat client open for anyone connected to the server.