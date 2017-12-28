import socket

tcp_ip = '127.0.0.1'
tcp_port = 4006
buffer_size = 1024
message = "[NOT OK] Connection is working"

s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.settimeout(2)
try:
    s.connect((tcp_ip,tcp_port))
    s.send(message.encode())
    data = s.recv(buffer_size)
    print("Received data: ", data.decode('ascii'))
except:
    print("[OK] CLIENT:Connection not working")
s.close()