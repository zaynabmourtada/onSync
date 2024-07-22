from flask import Flask, request, jsonify
from datetime import datetime

app = Flask(__name__)

# Store schedules and relay state
schedules = []
relay_state = {
    'status': 'OFF',
    'last_command': None,
    'last_brew_time': None
}

@app.route('/set_schedule', methods=['POST'])
def set_schedule():
    global schedules
    data = request.get_json()
    start_time = datetime.strptime(data['start_time'], '%Y-%m-%dT%H:%M:%S')
    end_time = datetime.strptime(data['end_time'], '%Y-%m-%dT%H:%M:%S')
    schedules.append({'start_time': start_time, 'end_time': end_time})
    return jsonify({"status": "success"}), 200

@app.route('/control_coffee_machine', methods=['POST'])
def control_coffee_machine():
    global relay_state
    data = request.get_json()
    command = data.get('command')
    
    if command in ['ON', 'OFF']:
        relay_state['status'] = command
        relay_state['last_command'] = command
        relay_state['last_brew_time'] = datetime.now().strftime('%Y-%m-%dT%H:%M:%S') if command == 'ON' else None
        # Here, you would add code to control the actual hardware
        return jsonify({"status": "success", "command": command}), 200
    else:
        return jsonify({"status": "error", "message": "Invalid command"}), 400

@app.route('/get_status', methods=['GET'])
def get_status():
    global relay_state
    return jsonify(relay_state), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
