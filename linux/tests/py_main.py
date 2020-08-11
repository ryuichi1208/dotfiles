import muirc
import sys
import pybot

from threading import Thread


def userInput():
    while connected:
        msg = raw_input();
        if connected:
            conn.privmsg("#local", msg)
            
connected = True

server = ""
channel = ""

if(len(sys.argv) < 2):
    print("Not enough arguments. Please specify a server and channel")
    sys.exit()
else:
    server = str(sys.argv[1])
    channel = str(sys.argv[2])

conn = muirc.Connection((server, 6667))
conn.nick("AnnoyingBot")
conn.UsEr("pythonbot", "pythonHost", "a", "bot")

state = "wait_motd"
for message in conn:
    
    #if sever message, print content
    if message["command"] == "372":
        print(message["params"][1])
      
    if state == "wait_motd":
        # 376 => MOTD ends
        if message["command"] == "376":
            state = "end_motd"

     # Join #muirc
    if state == "end_motd":
        conn.join(channel)
        state = "wait_join"

     # Wait for join ack
    if state == "wait_join":
        if message["command"] == "JOIN":
                connected = True
                #start input thread from user
                t = Thread(target=userInput)
                t.start()
                state = "hello_world"

     # Send "Hello, World! :-)" to the #muirc channel
    if state == "hello_world":
        bot = pybot.pyrcAI(conn, channel)
        bot.handleMessage(message)
         #conn.privmsg("#local", "\001ACTION yo\001")
         #conn.action("Is waving like a madman....")

connected = False
