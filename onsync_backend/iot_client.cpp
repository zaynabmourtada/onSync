#include <iostream>
#include <string>
#include <stdexcept>
#include <cstring>
#include <openssl/ssl.h>
#include <openssl/err.h>

using namespace std;

#define SERVER_HOST "127.0.0.1"
#define SERVER_PORT 8000
#define BUFFER_SIZE 1024

// Function to create SSL context
SSL_CTX* create_context() {
    const SSL_METHOD* method = SSLv23_client_method();
    SSL_CTX* ctx = SSL_CTX_new(method);
    if (!ctx) {
        throw runtime_error("Unable to create SSL context");
    }
    return ctx;
}

// Function to load the server's certificate for verification
void load_certificates(SSL_CTX* ctx) {
    if (!SSL_CTX_load_verify_locations(ctx, "C:\\Users\\zayna\\Projects\\onSync\\onsync_backend\\server-cert.pem", nullptr)) {
        throw runtime_error("Error loading server certificate");
    }
}

// Function to send a command and receive a response
string send_command(SSL_CTX* ctx, const string& command) {
    int sockfd;
    struct sockaddr_in server_addr;
    SSL* ssl;
    char buffer[BUFFER_SIZE] = {0};

    try {
        // Create TCP socket
        if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
            throw runtime_error("Socket creation error");
        }

        server_addr.sin_family = AF_INET;
        server_addr.sin_port = htons(SERVER_PORT);

        if (inet_pton(AF_INET, SERVER_HOST, &server_addr.sin_addr) <= 0) {
            throw runtime_error("Invalid address or address not supported");
        }

        // Connect to the server
        if (connect(sockfd, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
            throw runtime_error("Connection failed");
        }

        // Wrap socket with SSL
        ssl = SSL_new(ctx);
        SSL_set_fd(ssl, sockfd);

        if (SSL_connect(ssl) <= 0) {
            throw runtime_error("SSL connection failed");
        }

        // Send command
        if (SSL_write(ssl, command.c_str(), command.length()) <= 0) {
            throw runtime_error("SSL write failed");
        }

        // Receive response
        if (SSL_read(ssl, buffer, BUFFER_SIZE) <= 0) {
            throw runtime_error("SSL read failed");
        }

        string response(buffer);

        // Cleanup
        SSL_free(ssl);
        close(sockfd);

        return response;

    } catch (const exception& e) {
        if (ssl) SSL_free(ssl);
        close(sockfd);
        throw;
    }
}

int main() {
    SSL_CTX* ctx;
    try {
        // Initialize OpenSSL
        SSL_library_init();
        OpenSSL_add_all_algorithms();
        SSL_load_error_strings();

        // Create SSL context and load certificates
        ctx = create_context();
        load_certificates(ctx);

        // Command loop
        while (true) {
            cout << "Choose a command to send:\n";
            cout << "1. BREW\n";
            cout << "2. STOP\n";
            cout << "3. STATUS\n";
            cout << "4. SET DATE AND TIME\n";
            cout << "5. Exit\n";

            string choice;
            cin >> choice;

            string response;

            if (choice == "1") {
                response = send_command(ctx, "BREW");
                cout << "Response: " << response << endl;
            } else if (choice == "2") {
                response = send_command(ctx, "STOP");
                cout << "Response: " << response << endl;
            } else if (choice == "3") {
                response = send_command(ctx, "STATUS");
                cout << "Response: " << response << endl;
            } else if (choice == "4") {
                cin.ignore();
                string date_time;
                cout << "Enter date and time (YYYY-MM-DD HH:MM AM/PM): ";
                getline(cin, date_time);
                response = send_command(ctx, "SET DATE AND TIME " + date_time);
                cout << "Response: " << response << endl;
            } else if (choice == "5") {
                cout << "Exiting...\n";
                break;
            } else {
                cout << "Invalid choice. Please try again.\n";
            }
        }

        // Free SSL context
        SSL_CTX_free(ctx);

    } catch (const exception& e) {
        cerr << "Error: " << e.what() << endl;
        if (ctx) SSL_CTX_free(ctx);
        return 1;
    }

    return 0;
}
