import express from "express";
import pgclient from "../db.js";


const router = express.Router();

// ✅ GET all comments for a specific artwork (with user info)
router.get("/:artworkId", async (req, res) => {
  const { artworkId } = req.params;

  try {
    const query = `
      SELECT comments.*, users.username, users.avatar_url
      FROM comments
      JOIN users ON comments.user_id = users.id
      WHERE comments.artwork_id = $1
      ORDER BY comments.created_at ASC;
    `;
    const result = await pgclient.query(query, [artworkId]);
    res.status(200).json(result.rows);
  } catch (error) {
    console.error("Error fetching comments:", error.message);
    res.status(500).json({ error: "Failed to fetch comments" });
  }
});

// ✅ GET comment count for an artwork
router.get("/:artworkId/count", async (req, res) => {
  const { artworkId } = req.params;

  try {
    const query = `SELECT COUNT(*) FROM comments WHERE artwork_id = $1;`;
    const result = await pgclient.query(query, [artworkId]);
    res.status(200).json({ count: parseInt(result.rows[0].count, 10) });
  } catch (error) {
    console.error("Error fetching comment count:", error.message);
    res.status(500).json({ error: "Failed to fetch comment count" });
  }
});

// ✅ POST a new comment (return enriched comment with username/avatar)
router.post("/", async (req, res) => {
  const { artwork_id, user_id, text } = req.body;

  if (!artwork_id || !user_id || !text?.trim()) {
    return res.status(400).json({ error: "Missing required fields" });
  }

  try {
    const insertQuery = `
      INSERT INTO comments (artwork_id, user_id, text, created_at)
      VALUES ($1, $2, $3, NOW())
      RETURNING *;
    `;
    const inserted = await pgclient.query(insertQuery, [artwork_id, user_id, text]);
    const comment = inserted.rows[0];

    const userQuery = `SELECT username, avatar_url FROM users WHERE id = $1`;
    const userResult = await pgclient.query(userQuery, [user_id]);
    const { username, avatar_url } = userResult.rows[0];

    res.status(201).json({
      ...comment,
      username,
      avatar_url,
    });
  } catch (error) {
    console.error("Error posting comment:", error.message);
    res.status(500).json({ error: "Failed to post comment" });
  }
});

export default router;
