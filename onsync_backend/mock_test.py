import unittest
from unittest.mock import patch, MagicMock
import socket
import ssl

# Import the send_command function from the iot_client.py file
from iot_client import send_command

class TestIoTClient(unittest.TestCase):
    @patch('socket.socket')
    @patch('ssl.SSLContext.wrap_socket')
    def test_send_command_brew(self, mock_wrap_socket, mock_socket):
        # Set up the mock socket and SSL context
        mock_socket_instance = MagicMock()
        mock_socket.return_value = mock_socket_instance
        mock_ssl_socket_instance = MagicMock()
        mock_wrap_socket.return_value = mock_ssl_socket_instance

        # Define the mock response for the "BREW" command
        mock_ssl_socket_instance.recv.return_value = b'BREWING\n'

        # Call the send_command function
        response = send_command("BREW")

        # Assert that the response is as expected
        self.assertEqual(response, "BREWING\n")

        # Assert that the command was sent correctly
        mock_ssl_socket_instance.send.assert_called_with(b'BREW')

    @patch('socket.socket')
    @patch('ssl.SSLContext.wrap_socket')
    def test_send_command_stop(self, mock_wrap_socket, mock_socket):
        # Set up the mock socket and SSL context
        mock_socket_instance = MagicMock()
        mock_socket.return_value = mock_socket_instance
        mock_ssl_socket_instance = MagicMock()
        mock_wrap_socket.return_value = mock_ssl_socket_instance

        # Define the mock response for the "STOP" command
        mock_ssl_socket_instance.recv.return_value = b'OFF\n'

        # Call the send_command function
        response = send_command("STOP")

        # Assert that the response is as expected
        self.assertEqual(response, "OFF\n")

        # Assert that the command was sent correctly
        mock_ssl_socket_instance.send.assert_called_with(b'STOP')

    @patch('socket.socket')
    @patch('ssl.SSLContext.wrap_socket')
    def test_send_command_status(self, mock_wrap_socket, mock_socket):
        # Set up the mock socket and SSL context
        mock_socket_instance = MagicMock()
        mock_socket.return_value = mock_socket_instance
        mock_ssl_socket_instance = MagicMock()
        mock_wrap_socket.return_value = mock_ssl_socket_instance

        # Define the mock response for the "STATUS" command
        mock_ssl_socket_instance.recv.return_value = b'ON\n'

        # Call the send_command function
        response = send_command("STATUS")

        # Assert that the response is as expected
        self.assertEqual(response, "ON\n")

        # Assert that the command was sent correctly
        mock_ssl_socket_instance.send.assert_called_with(b'STATUS')

    @patch('socket.socket')
    @patch('ssl.SSLContext.wrap_socket')
    def test_send_command_set_date_and_time(self, mock_wrap_socket, mock_socket):
        # Set up the mock socket and SSL context
        mock_socket_instance = MagicMock()
        mock_socket.return_value = mock_socket_instance
        mock_ssl_socket_instance = MagicMock()
        mock_wrap_socket.return_value = mock_ssl_socket_instance

        # Define the mock response for the "SET DATE AND TIME" command
        mock_ssl_socket_instance.recv.return_value = b'DATE AND TIME SET\n'

        # Call the send_command function
        response = send_command("SET DATE AND TIME 2023-07-20 14:30 PM")

        # Assert that the response is as expected
        self.assertEqual(response, "DATE AND TIME SET\n")

        # Assert that the command was sent correctly
        mock_ssl_socket_instance.send.assert_called_with(b'SET DATE AND TIME 2023-07-20 14:30 PM')

if __name__ == '__main__':
    unittest.main()
