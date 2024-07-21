import socket
import ssl
import datetime
import threading

# Host, port, and buffer size variables
SERVER_HOST = "127.0.0.1"
SERVER_PORT = 8000
BUFFER_SIZE = 1024

# Create SSL context
context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)

# Load server certificate and private key
context.load_cert_chain(certfile=r"C:\Users\zayna\Projects\onSync\onsync_backend\server-cert.pem", keyfile=r"C:\Users\zayna\Projects\onSync\onsync_backend\server-key.pem")

# Create and bind TCP socket
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind((SERVER_HOST, SERVER_PORT))

# Put server in listening mode
server_socket.listen(5)
server_socket = context.wrap_socket(server_socket, server_side=True)

# Command handling
is_on = False
is_brewing = False
schedule_date_and_time = ""

def start_brewing():
    global is_on, is_brewing
    is_on = True
    is_brewing = True
    print("Brewing started\n")

def stop_brewing():
    global is_on, is_brewing
    is_on = False
    is_brewing = False
    print("Brewing stopped\n")

def get_status():
    if is_brewing:
        return "BREWING"
    elif is_on:
        return "ON"
    else:
        return "OFF"

def set_date_and_time(datetime_str):
    global schedule_date_and_time
    schedule_date_and_time = datetime_str
    print(f"Scheduled date and time set to {schedule_date_and_time}")

def handle_client(client_socket):
    global is_on, is_brewing
    try:
        # Receive data
        data = client_socket.recv(BUFFER_SIZE).decode('utf-8').strip()
        print(f"Command received: {data}")

        response = ""
        if data == "BREW":
            start_brewing()
            response = "BREWING\n"
        elif data == "STOP":
            stop_brewing()
            response = "OFF\n"
        elif data == "STATUS":
            response = get_status() + "\n"
        elif data.startswith("SET DATE AND TIME"):
            try:
                _, date_time = data.split(" ", 1)
                set_date_and_time(date_time)
                response = "DATE AND TIME SET\n"
            except ValueError:
                response = "INVALID COMMAND\n"
        else:
            response = "INVALID_COMMAND\n"
        
        # Send response
        client_socket.send(response.encode('utf-8'))

    except Exception as e:
        print(f"Error handling client: {e}")
    finally:
        client_socket.close()
        print("Client disconnected")

def accept_clients():
    while True:
        try:
            # Accept a connection
            client_socket, client_address = server_socket.accept()
            print(f"Client connected from: {client_address}")
            threading.Thread(target=handle_client, args=(client_socket,)).start()
        except Exception as e:
            print(f"Error accepting client: {e}")

# Start accepting clients
accept_clients()
