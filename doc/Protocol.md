# The Pi Fight protocol

Pi Fight robots can be written in any language, using any framework. Any
robot which follows this protocol will work.

This document describes version 1 of the protocol.

## Overview

### Don't call us, we'll call you.

To prevent individual robots from spamming the server, robots only
speak when spoken to. Each robot must listen for HTTP requests on
port 80 and respond with JSON.

Any response larger than 1K or longer than 500 millisecnds will be
ignored.

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

event: start | end | position | pong | hit | collision
position: x/y coordinates
health: integer 0-100
object: (only with pong & collision)
  - type: wall|robot
  - direction: in case you forgot
  - distance: distance to object
damage: 0-100, (only with hit & collision)

**Unresolved:** What are the units for speed and direction?
How frequent are clock ticks?

#### Response
One or both of movement and action.
If movement is omitted the bot continues with the
same speed and direction.

Movement consists of both:
  - speed: integer from 0 to 100
  - facing: direction (degrees? radians?)

Action is only one of:
- ping: direction
- shoot: direction, range

### Actions

#### ping
Ping sends a LIDAR ping in a particular direction. The
ping will detect the first robot or wall it encounters.
The pinging robot will receive a `pong` message indicating
the distance, direction, and type of object encountered.
The `pong` will probably but not necessarily be the next
message received. Each `ping` will generate exactly one
`pong` in response.

#### shoot
Shoot fires a shell in a given direction. The shell will
explode at a given distance from the shooter. Robots within
HOWMANY units of the explosion will be damaged. The closer
the explosion the more damage the robot receives.
Explosions can hurt multiple robots and even your own
robot.

### Events

#### start

Start signals the beginning of a new match. The bot will
be told its initial position and health and can begin
acting immediately.

#### end

End indicates the match is over. Bots have 10 seconds to
perform and necessary cleanup or recordkeeping before
the next match may begin.

#### position
In the absence of any other events, on each clock tick
the Arena Server will send each bot its current position
and health.

#### pong
Pong comes in response to a previously sent ping.

#### hit

#### collision