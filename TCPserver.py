import socket

tcp_ip = '127.0.0.1'
tcp_port = 4006
buffer_size = 1024

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((tcp_ip, tcp_port))
s.listen(1)

s.settimeout(2)
try:
    connection, address = s.accept()
    print("Connected address: ", address)
    while True:
        data = connection.recv(buffer_size)
        if not data: break
        print(data.decode('ascii'))
        connection.send(data)
    connection.close()
except:
    print("[OK] SERVER:Connection not received")
s.close()
