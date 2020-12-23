#!/usr/bin/python

import OpenSSL
import socket
import struct

# Prefer TLS
context = OpenSSL.SSL.Context(OpenSSL.SSL.TLSv1_METHOD)
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.settimeout(5)
connection = OpenSSL.SSL.Connection(context,s)
connection.connect(("example.com",443))

# Put the socket in blocking mode
s.setblocking(1)

# Set the timeout using the setsockopt
#tv = struct.pack('ii', int(6), int(0))
#connection.setsockopt(socket.SOL_SOCKET, socket.SO_RCVTIMEO, tv)

print "[Connected] " , connection.getpeername()
print "[State] " , connection.get_state_string()

try:
    print "Starting Handshake"
    connection.do_handshake()
except OpenSSL.SSL.WantReadError:
    print "Timeout"
    quit()

print "[State] " , connection.get_state_string()

# Send question
print "-------------------------------------------------------"
print "Transmitted %d bytes" %  connection.send("koekoek\r\n")

# Expect result 
try:
    recvstr = connection.recv(1024)
except OpenSSL.SSL.WantReadError:
    print "Timeout"
    quit()

# Print response 
print recvstr
print "-------------------------------------------------------"

