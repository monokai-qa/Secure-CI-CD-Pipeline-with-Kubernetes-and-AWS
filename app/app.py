## Reference: https://medium.com/featurepreneur/deploying-a-flask-app-to-kubernetes-f05c93866aff

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World! This is a simple Flask app in Docker.'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
