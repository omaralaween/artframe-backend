import express from "express";
import pgclient from "../db.js";

const router = express.Router();

// 🔁 Count likes received by all artworks of an artist
router.get("/artist/:artistId", async (req, res) => {
  const { artistId } = req.params;
  try {
    const result = await pgclient.query(
      `SELECT COUNT(*) FROM likes 
       WHERE artwork_id IN (SELECT id FROM artworks WHERE artist_id = $1)`,
      [artistId]
    );
    res.json({ count: parseInt(result.rows[0].count) });
  } catch (err) {
    console.error("Error fetching likes for artist:", err);
    res.status(500).json({ error: "Server error" });
  }
});

// ✅ Check if user liked a specific artwork
router.get("/:artworkId/user/:userId", async (req, res) => {
  const { artworkId, userId } = req.params;
  try {
    const result = await pgclient.query(
      "SELECT 1 FROM likes WHERE artwork_id = $1 AND user_id = $2",
      [artworkId, userId]
    );
    res.json({ liked: result.rowCount > 0 });
  } catch (error) {
    console.error("Error checking like status:", error);
    res.status(500).json({ error: "Failed to check like" });
  }
});

// ✅ Get total likes for a given artwork
router.get("/:artworkId", async (req, res) => {
  const { artworkId } = req.params;
  try {
    const result = await pgclient.query(
      "SELECT COUNT(*) FROM likes WHERE artwork_id = $1",
      [artworkId]
    );
    res.json({ count: parseInt(result.rows[0].count) });
  } catch (error) {
    console.error("Error getting likes:", error);
    res.status(500).json({ error: "Failed to get likes" });
  }
});

// ❤️ Like an artwork
router.post("/", async (req, res) => {
  const { artwork_id, user_id } = req.body;
  try {
    await pgclient.query(
      "INSERT INTO likes (artwork_id, user_id) VALUES ($1, $2)",
      [artwork_id, user_id]
    );
    res.status(201).json({ success: true });
  } catch (error) {
    console.error("Error liking artwork:", error);
    res.status(500).json({ error: "Failed to like artwork" });
  }
});

// 💔 Unlike an artwork
router.delete("/", async (req, res) => {
  const { artwork_id, user_id } = req.body;
  try {
    await pgclient.query(
      "DELETE FROM likes WHERE artwork_id = $1 AND user_id = $2",
      [artwork_id, user_id]
    );
    res.status(200).json({ success: true });
  } catch (error) {
    console.error("Error unliking artwork:", error);
    res.status(500).json({ error: "Failed to unlike artwork" });
  }
});

export default router;
