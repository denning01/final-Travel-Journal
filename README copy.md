# Flask API Project

This project is a RESTful API built with Flask for managing users, posts, comments, and follow relationships between users. It includes authentication via JSON Web Tokens (JWT), and SQLAlchemy is used as the ORM with support for migrations.

## Features
- **User Management**: Register, login, and manage user profiles.
- **Post Management**: Users can create, view, and delete posts.
- **Commenting**: Users can comment on posts.
- **Follow System**: Users can follow and unfollow each other.
- **JWT Authentication**: Secured endpoints using access tokens.
- **Database Migrations**: Manage database changes through Flask-Migrate.

## Getting Started

### Prerequisites

Ensure that you have the following installed:
- Python 3.8+
- pip (Python package installer)
- Postman (for API testing)

### Project Setup

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/flask-api-project.git
   cd flask-api-project
   ```

2. **Install dependencies:**

Dependencies are stored in the `requirements.txt` file. Install them into a vendor directory inside the project:

   ```bash
   make deps
   ```

3. **Configure environment:**

This is optional for this project. Create a `.env` file in the root directory with the following environment variables:

   ```bash
   FLASK_APP=app.py
   FLASK_ENV=development
   SECRET_KEY=your_secret_key
   JWT_SECRET_KEY=your_jwt_secret_key
   SQLALCHEMY_DATABASE_URI=sqlite:///app.db
   ```

4. **Initialize the database:**

Run the following command to initialize the database and create the tables:

   ```bash
   make db-init       # Initializes the database (if not already done)
   make db-migrate    # Create a new migration
   make db-upgrade    # Apply the migration to the database
   ```

5. **Run the Flask application:**

Start the Flask development server with:

   ```bash
   make run
   ```
