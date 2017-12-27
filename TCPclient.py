import socket

tcp_ip = '127.0.0.1'
tcp_port = 4005
buffer_size = 1024
message = "Testing 1,2,3!"

s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect((tcp_ip,tcp_port))
s.send(message.encode())
data = s.recv(buffer_size)
print("Received data: ", data.decode('ascii'))
s.close()