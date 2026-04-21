
from argparse import ArgumentParser
from socket import socket
import sys
import signal

def ctrl_c(signal,frame)->None:
    sys.exit(0)
signal.signal(signal.SIGINT,ctrl_c)

def loop(client:socket):
    state = 'running'
    try:
        while state == 'running':
            command = input("_>: ")
            if command == 'exit':
                client.send(command.encode())
                client.close()
                state = 'stopped'
            elif command == "\n":
                continue
            else:
                client.send(command.encode())
                response = client.recv(4096)
                print(response.decode()) 
    except KeyboardInterrupt:
        print(f"\nExit by the user")
        client.send(command.encode())
        client.close()
        state = 'stopped'

def init_conection(target:str)->socket:
    ip, port = target.split(":")
    port = int(port)
    try:
        server_address = (ip,port)
        client_socket = socket()
        client_socket.connect(server_address)
    except Exception as e:
        print(f"Connection failure due to : {e}")
        sys.exit(1)
    return client_socket

def get_target()->str:
    argsParser = ArgumentParser(description="This script should be executed in the guest machine to get a powershell") 
    argsParser.add_argument("--target",type=str,required=True,help="The IP target and the port like: 192.168.1.1:8080")
    args = argsParser.parse_args()
    return args.target
    
if __name__ == '__main__':
    target = get_target()
    client = init_conection(target)
    loop(client)