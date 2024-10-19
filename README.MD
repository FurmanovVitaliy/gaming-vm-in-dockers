# Docker Images for Headless GUI Application

This repository contains Docker images designed to run GUI applications in a headless mode. These images can be used to deploy applications that require graphical user interfaces without a physical display.

## Features
- Lightweight Docker images for running GUI applications.
- Support for headless operation, ideal for CI/CD environments or remote servers.
- Easily customizable and extendable for various applications.

## Prerequisites
- Docker installed on your machine.
- Basic knowledge of Docker and command-line operations.

## Getting Started
Clone this repository to your local machine using the following command:
```bash
     git clone https://github.com/FurmanovVitaliy/gaming-vm-in-dockers
     cd gaming-vm-in-dockers
        # Build the base image
     docker build -t arch:base ./base
        # Build the ffmpeg-audio image
     docker build -t arch:ffmpeg-audio ./ffmpeg-audio
        # Build the ffmpeg-video image
     docker build -t arch:ffmpeg-video ./ffmpeg-video
        # Build the portprotone image
     docker build -t arch:portprotone ./portprotone
        # Build the pulseaudio image
     docker build -t arch:pulseaudio ./pulseaudio
```
## Notes
 - Tested on ArchLinux with AMD graphics card (RX7800XT)
 - Docker containers require a created directory that will connect as the HOME directory of the docker user.This directory should have a folder `logs` in which the logs of docker containers will be partially recorded.
 - You can create your own docker containers for the processes you need and embed them into this system, for example.
 - This repository is part of [Pixel Cloud Project](https://github.com/FurmanovVitaliy/self-hosted-cloud-gaming-service)




