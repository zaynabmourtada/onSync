from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt
from datetime import datetime

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

# Set schedule endpoint
@app.route('/set_schedule', methods=['POST'])
def set_schedule():
    data = request.get_json()
    print("Received set schedule request with data:", data)  # Debug print

    start_time = datetime.strptime(data['start_time'], '%Y-%m-%dT%H:%M:%S')
    end_time = datetime.strptime(data['end_time'], '%Y-%m-%dT%H:%M:%S')
    schedules.append({'start_time': start_time, 'end_time': end_time})
    print("Schedule set successfully")  # Debug print
    return jsonify({"status": "success"}), 200

# Control coffee machine endpoint
@app.route('/control_coffee_machine', methods=['POST'])
def control_coffee_machine():
    data = request.get_json()
    print("Received control coffee machine request with data:", data)  # Debug print

    command = data.get('command')

    if command in ['ON', 'OFF']:
        relay_state['status'] = command
        relay_state['last_command'] = command
        relay_state['last_brew_time'] = datetime.now().strftime('%Y-%m-%dT%H:%M:%S') if command == 'ON' else None
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
    app.run(host='0.0.0.0', port=5000)
