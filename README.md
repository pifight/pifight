# Pi Fight

Pi Fight allows virtual robots to fight one another. Each robot resides
on its own separate machine. The code here is a central server which 
communicates with each robot, determnes what happens, and displays the
results. If individual robots are players, this server is like the
game master.

(diagram)

The protocol for communicatng with robots is described in doc/Protocol.md.

Individual robots can run on anything but this project was created 
with Raspberry Pi in mind. Raspberry Pi makes a consistent, portable,
affordable robot platform. We can ensure all robots have the same 
computing resources available and nobody has to break the bank.

## Documentation

In addition to this README you can find information in the `doc`
directory including:

- MVP.md List of the minimum features necessary to conduct an
actual robot battle. Work in progress
- TODO.md Other needed work
- Protocol.md Description of the protocol you can use to write your
own robots
- Rules.md Suggested rules for comducting a robot battle

## Installation

Elixir
Sass

## Development

Your pull requests are very welcome! The front end code could especially
use some love from somebody with Javascript and/or CSS chops. Just make
sure the tests all pass.