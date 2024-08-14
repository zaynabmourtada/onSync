from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from datetime import datetime
import socket

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///users.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)

# User model
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(120), unique=True, nullable=False)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password = db.Column(db.String(120), nullable=False)

# Create the database
with app.app_context():
    db.create_all()

# Register endpoint
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    print("Received registration request with data:", data)  # Debug print

    email = data.get('email')
    username = data.get('username')
    password = data.get('password')

    if User.query.filter_by(username=username).first():
        print("Username already exists")  # Debug print
        return jsonify({"status": "error", "message": "Username already exists"}), 400

    if User.query.filter_by(email=email).first():
        print("Email already exists")  # Debug print
        return jsonify({"status": "error", "message": "Email already exists"}), 400

    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
    new_user = User(email=email, username=username, password=hashed_password)
    db.session.add(new_user)
    db.session.commit()
    print("User registered successfully")  # Debug print
    return jsonify({"status": "success"}), 200

# Login endpoint
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    print("Received login request with data:", data)  # Debug print

    username = data.get('username')
    password = data.get('password')

    user = User.query.filter_by(username=username).first()
    if user and bcrypt.check_password_hash(user.password, password):
        print("Login successful")  # Debug print
        return jsonify({"status": "success"}), 200
    print("Invalid credentials")  # Debug print
    return jsonify({"status": "error", "message": "Invalid credentials"}), 401

# Initialize schedules and relay state
schedules = []
relay_state = {
    'status': 'OFF',
    'last_command': None,
    'last_brew_time': None
}

# Schedule Model
class Schedule(db.Model):
    id = db.Column(db.Integer, primary_key = True)
    username = db.Column(db.String(80), nullable = False)
    start_time = db.Column(db.String(20), nullable = False)
    end_time = db.Column(db.String(20), nullable = False)

# Create Schedule database
with app.app_context():
    db.create_all()

# Set schedule endpoint
@app.route('/set_schedule', methods=['POST'])
def set_schedule():
    data = request.get_json()
    print("Received set schedule request with data:", data)  # Debug print

    username = data ['username']
    start_time = data['start_time']
    end_time = data ['end_time']
    print(f"Username: {username}, Start Time: {start_time}, End Time: {end_time}")  # Debug print

    if not username or not start_time or not end_time:
        print("Missing data in request")  # Debug print
        return jsonify({"status": "error", "message": "Missing data"}), 400

    new_scheddule = Schedule(username=username, start_time= start_time, end_time = end_time)
    db.session.add(new_scheddule)
    db.session.commit()
    print("Schedule set successfully")  # Debug print
    return jsonify({"status": "success"}), 200

# Get schedule endpoint
@app.route('/get_schedule', methods = ['GET'])
def get_schedule():
    username = request.args.get('username')
    schedule = Schedule.query.filter_by(username=username).first()
    if schedule:
        return jsonify({
            'username': schedule.username,
            'start_time': schedule.start_time,
            'end_time': schedule.end_time
        }), 200
    else:
        return jsonify({'message': 'Schedule not found'}), 404
    
# Control coffee machine endpoint
@app.route('/control_coffee_machine', methods=['POST'])
def control_coffee_machine():
    data = request.get_json()
    print("Received control coffee machine request with data:", data)  # Debug print

    command = data.get('command')

    if command in ['ON', 'OFF', 'BREWING']:
        relay_state['status'] = command
        relay_state['last_command'] = command
        if command == 'ON':
            relay_state['last_brew_time'] = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        elif command == 'BREWING':
            relay_state['last_brew_time'] = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
        elif command == 'OFF':
            relay_state['last_brew_time'] = None
        print("Command executed:", command)  # Debug print
        return jsonify({"status": "success", "command": command}), 200
    print("Invalid command")  # Debug print
    return jsonify({"status": "error", "message": "Invalid command"}), 400

# Get status endpoint
@app.route('/get_status', methods=['GET'])
def get_status():
    print("Received get status request")  # Debug print
    return jsonify(relay_state), 200

if __name__ == '__main__':
    # Run the app on all available IP addresses (accessible within the network)
    app.run(host='0.0.0.0', port=5000)
