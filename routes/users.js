import express from "express";
import pgclient from "../db.js";
import { requireArtist, requireBuyer } from "../middleware/roleAuth.js"; // ✅ import middleware

const router = express.Router();

// 🟡 Get artworks uploaded by user (Restricted to artists)
router.get("/:id/artworks", requireArtist, async (req, res) => {
  const userId = req.params.id;
  try {
    const result = await pgclient.query(
      "SELECT * FROM artworks WHERE artist_id = $1 ORDER BY created_at DESC",
      [userId]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error fetching uploaded artworks:", err);
    res.status(500).json({ error: "Failed to fetch artworks" });
  }
});

// 🔵 Get artworks purchased by user (Restricted to buyers)
router.get("/:id/purchases", requireBuyer, async (req, res) => {
  const userId = req.params.id;
  try {
    const result = await pgclient.query(
      `SELECT a.*
       FROM purchases p
       JOIN artworks a ON p.artwork_id = a.id
       WHERE p.user_id = $1
       ORDER BY p.created_at DESC`,
      [userId]
    );
    res.json(result.rows);
  } catch (err) {
    console.error("Error fetching purchased artworks:", err);
    res.status(500).json({ error: "Failed to fetch purchases" });
  }
});

// 🟢 Get user by ID
router.get("/:id", async (req, res) => {
  const { id } = req.params;
  try {
    const result = await pgclient.query(
      "SELECT id, username, email, avatar_url, banner_url, bio, role FROM users WHERE id = $1",
      [id]
    );
    if (result.rows.length === 0) {
      return res.status(404).json({ error: "User not found" });
    }
    res.json(result.rows[0]);
  } catch (error) {
    console.error("Error fetching user by ID:", error);
    res.status(500).json({ error: "Server error" });
  }
});

// 🟣 Update user info
router.put("/:id", async (req, res) => {
  const { username, email, password, bio, avatar_url, banner_url } = req.body;
  const userId = req.params.id;

  try {
    const query = `
      UPDATE users
      SET username = $1,
          email = $2,
          password = $3,
          bio = $4,
          avatar_url = $5,
          banner_url = $6
      WHERE id = $7
      RETURNING *;
    `;
    const values = [username, email, password, bio, avatar_url, banner_url, userId];
    const result = await pgclient.query(query, values);
    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error("Update user error:", error);
    res.status(500).json({ error: "Failed to update user" });
  }
});

export default router;
