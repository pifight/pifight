# The Pi Fight protocol

Pi Fight robots can be written in any language, using any framework. Any
robot which follows this protocol will work.

This document describes version 1 of the protocol.

## Overview

### Don't call us, we'll call you.

To prevent individual robots from spamming the server, robots only
speak when spoken to. Each robot must listen for HTTP requests on
port 80 and respond with JSON.

Any response larger than 1K or longer than 1 second will be ignored.

Robots must respond the the following calls:

### GET /robots.json

Before a match, the Arena Server scans its local network looking
for robots. For each host it finds listening on port 80, the
Arena Server will ask for the robot's basic information.

The response must include:
- name: UTF-8, human-readable name, 25 characters max. All 
whitespace will be removed by the Arena Server
- protocol: A list of protocol versions spoken

The response may optionally include:
- icon: HTTP path to an image residing on the same server. This
image will be used to represent your robot in the arena display.
The icon may be a GIF, JPEG, PNG, or SVG of no more than 100K.
The image will be displayed as 1.5em square and a random color.

### POST update

event: start | position | pong | hit | collision | end
position: x/y coordinates
health: integer 0-100
object: wall|robot, only with pong & collision
damage: 0-100, only with hit & collision

#### Response
speed: [x,y] integers from -100 to 100

ping: direction
shoot: direction, range

