import socket

tcp_ip = '127.0.0.1'
tcp_port = 4005
buffer_size = 1024

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((tcp_ip, tcp_port))
s.listen(1)

connection, address = s.accept()
print("Connected address: ", address)
while True:
    data = connection.recv(buffer_size)
    if not data: break
    print("Received data: ",data.decode('ascii'))
    connection.send(data)
connection.close()
