# ArtFrame Backend

ArtFrame is a backend service for a digital art marketplace that supports two types of users: artists and buyers. It is built using **Express.js** for the server and **PostgreSQL** as the database. The backend provides a RESTful API to handle all core functionality such as user accounts, uploading artwork, liking, commenting, following artists, and purchasing artworks.

---

## How to Clone and Run This Backend Locally

### Prerequisites

* PostgreSQL installed
* Node.js and npm installed

### Setup Steps

1. Clone the repository:

    ```bash
    git clone https://github.com/your-username/artframe-backend.git
    cd artframe-backend
    ```

2. Create a PostgreSQL database:

    ```bash
    psql
    CREATE DATABASE artframe;
    \q
    ```

3. Create a `.env` file in the root directory with the following content:

    ```env
    PORT=5000
    DATABASE_URL=postgresql://your-username:your-password@localhost:5432/artframe
    ```

4. Install dependencies:

    ```bash
    npm install
    ```

5. Start the server:

    ```bash
    node server.js
    ```

    The backend will run at `http://localhost:5000`

---

## Project Structure

```
artframe-backend/
├── routes/
│   ├── artworks.js
│   ├── auth.js
│   ├── comments.js
│   ├── follows.js
│   ├── likes.js
│   ├── purchases.js
│   └── users.js
├── middleware/
│   └── roleAuth.js
├── db.js
├── server.js
├── .env.sample
├── .gitignore
└── README.md
```

---

## API Endpoints Overview

### Auth Endpoints

* `POST /api/auth/signup`: Register a new user
* `POST /api/auth/login`: Log in an existing user

Example Request Body for Signup:

```json
{
  "username": "mayar",
  "email": "mayar@example.com",
  "password": "1234",
  "role": "artist"
}
```

### User Endpoints

* `GET /api/users/:id`: Get user by ID
* `PUT /api/users/:id`: Update user info
* `GET /api/users/:id/artworks`: Get artworks uploaded by the user (if artist)
* `GET /api/users/:id/purchases`: Get artworks purchased by the user (if buyer)

### Artwork Endpoints

* `GET /api/artworks`: Get all artworks
* `GET /api/artworks/:id`: Get artwork by ID
* `GET /api/artworks/followed/:userId`: Get artworks from followed artists
* `POST /api/artworks`: Create new artwork (artist only)

### Like Endpoints

* `GET /api/likes/:artworkId`: Get like count for an artwork
* `GET /api/likes/:artworkId/user/:userId`: Check if user liked an artwork
* `GET /api/likes/artist/:artistId`: Get total likes for an artist
* `POST /api/likes`: Like an artwork
* `DELETE /api/likes`: Unlike an artwork

### Comment Endpoints

* `GET /api/comments/:artworkId`: Get all comments for an artwork
* `GET /api/comments/:artworkId/count`: Get comment count for an artwork
* `POST /api/comments`: Add a new comment

### Purchase Endpoints

* `GET /api/purchases/:userId`: Get purchases made by user
* `GET /api/purchases/artist/:artistId`: Get number of sales made by an artist
* `POST /api/purchases`: Record a purchase

### Follow Endpoints

* `GET /api/follows/check`: Check if user follows an artist
* `GET /api/follows/followers/:userId`: Get total followers for an artist
* `GET /api/follows/followed/:userId`: Get total artists followed by a buyer
* `POST /api/follows`: Follow an artist
* `DELETE /api/follows`: Unfollow an artist

---
