import socket

from main import app
from models import User


@app.route("/")
def hello_world():
    hostname = socket.gethostname()
    user = User.query.first()
    return f"<p>Hello, World from {user.user_first_name} deployed on {hostname}</p>"