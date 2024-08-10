import socket
import threading

# Host, port, and buffer size variables
SERVER_HOST = "0.0.0.0"
SERVER_PORT = 8000
BUFFER_SIZE = 1024

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
        print(f"Command received: '{data}'")

        # Handle commands
        response = ""
        if data == "1":
            start_brewing()
            response = "BREWING\n"
        elif data == "2":
            stop_brewing()
            response = "OFF\n"
        elif data == "3":
            response = get_status() + "\n"
        elif data.startswith("4"):
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

if __name__ == "__main__":
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
        server_socket.bind((SERVER_HOST, SERVER_PORT))
        server_socket.listen()
        print(f"Server running on {SERVER_HOST}:{SERVER_PORT}")
        
        try:
            threading.Thread(target=accept_clients, daemon=True).start()
            while True:
                pass
        except KeyboardInterrupt:
            print("Server shutting down...")
        finally:
            server_socket.close()
