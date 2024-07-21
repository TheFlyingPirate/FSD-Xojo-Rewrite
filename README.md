# FSD-Xojo-Rewrite
A rewrite of the FSD Server found on https://github.com/kuroneko/fsd/ using Xojo, the intention
of this rewrite is to provide a more modern but fully compatbile Server as a basis for future development.
## What is a FSD Server
The FSD Server and Protool is a way for flightsimulators, to share data for a multiplayer session between each other with different clients. It also allows for ATC(Air Traffic Control) clients to connect to the Server to simulate Radat coverage for the users.
It also allows for multiple servers to be connected to each other to share the load, they automatically share only relevant information between each other.
## Goals of this project
The goals of this project is to rewrite the FSD Server in Xojo, producing an entirely protocol compatible, drop in replacement,
This should include, client handling, the system (telnet interface), and the server interface, allowing for dynamic routing of the users,
This project will retain the structure of the original code and implement it in Xojo, in the future I am planning on relesasing a updated and modified
FSD Server with new capibilities, and this should be the basis for all new features in the future.
## Current State
At the time being I am still activly working on implementing this solution, hopefully I have a working version soon.