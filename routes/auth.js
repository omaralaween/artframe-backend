import express from "express";
import pgclient from "../db.js";


const router = express.Router();

// 🔐 Signup Route
router.post("/signup", async (req, res) => {
  try {
    const { username, email, password, role } = req.body;

    const query = `
      INSERT INTO users (username, email, password, role)
      VALUES ($1, $2, $3, $4)
      RETURNING id, username, email, role
    `;
    const result = await pgclient.query(query, [username, email, password, role]);

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error("Registration error:", error);
    res.status(500).json({ error: "Registration failed" });
  }
});

// 🔐 Login Route
router.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    const query = `
      SELECT id, username, email, role, avatar_url, banner_url, bio
      FROM users
      WHERE email = $1 AND password = $2
    `;
    const result = await pgclient.query(query, [email, password]);

    if (result.rows.length === 0) {
      return res.status(401).json({ error: "Invalid credentials" });
    }
    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error("Login error:", error);
    res.status(500).json({ error: "Login failed" });
  }
});

export default router;
