# RL Server

### What is this?

Inspired by one of Dungeon Crawl Stone Soup's ssh servers, `crawl.akrasiac.org`, I wanted to make
a Docker image to containerize a similar service, allowing users to connect and play from any
number of free roguelikes installed on it. Like a portable installation of each, accessible
via the internet and a terminal.

### Getting Started

When this project is complete, you should just be able to ssh to a host and play!

But for now, I've provided some scripts so you can build the image and setup a container locally while I work on getting all of this finished up.

To get started, run the following in your terminal (Windows, fight me):

```sh
./build.bat
```

This will build the image from the Dockerfile. Once that is done, run:

```sh
./start.bat
```

This will spin up a container with this image and run the startup commands. Once that is done, run:

```sh
./test.bat
```

That will connect to the container, and prompt you for a password. `player` is the dev password at time of writing, since we only have one user and no user management so far.

Additionally, if you just need to jump into the container to test things as root, you can run:

```sh
./root.bat
```

I use this to test install scripts and things like that, or checking to see which packages I need or don't need, before I add them to the Dockerfile or elsewhere.

When you're done, run:

```sh
./stop.bat
```
This will stop the container, remove it, and will also remove the image, since I prefer to rebuild images when making large changes and got tired of writing out all the commands...or having a dedicated "cleanup" script... again, fight me.

### Notes

Mostly for me:

- `TODO.txt` contains all the TODOs... duh?
- `etc/` contains things like the MOTD, other static files to copy over
- `scripts/` contains scripts to copy over

Virtually everything else just lives in the Dockerfile.

### Progress

So far I've installed the "big 3" roguelikes: angband, dcss, and cdda.

I'm pretty happy with that for now, and I have basic ssh stuff working. So next up is user management. After that, I'll see about getting this spun up on the internet somewhere before adding more features.