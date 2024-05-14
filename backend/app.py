from flask import Flask, jsonify, request
from custom_gemini import generate_output
from clean_tasks import get_tasks

app = Flask(__name__)

@app.route('/data', methods=['GET', 'POST'])
def handle_request():
    if request.method == 'POST':
        data = request.json
        print('here')
        # Process your data (e.g., perform operations, interact with databases, etc.)
        generated_task = generate_output(data['text'])
        tasks = get_tasks(generated_task)
        return jsonify({'response': 'Data received', 'yourData': tasks}), 200
    else:
        print('here')
        # For GET requests, just send back a simple message
        return jsonify({'message': 'This is a GET request'}), 200

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5001)
