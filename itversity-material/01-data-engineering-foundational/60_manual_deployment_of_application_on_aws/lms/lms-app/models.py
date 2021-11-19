from main import db


class User(db.Model):
    __tablename__ = 'users'
    user_id = db.Column(db.Integer, primary_key=True)
    user_first_name = db.Column(db.String(30), nullable=False)
    user_last_name = db.Column(db.String(30), nullable=False)

    def __repr__(self):
        return f'<user_id={self.user_id};user_first_name={self.user_first_name};user_last_name={self.user_last_name}>'