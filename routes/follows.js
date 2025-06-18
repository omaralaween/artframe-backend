import express from "express";
import pgclient from "../db.js";

const router = express.Router();

// 🔄 Follow Artist (Only Buyers)
router.post("/", async (req, res) => {
  const { follower_id, followed_artist_id } = req.body;

  try {
    await pgclient.query(
      "INSERT INTO follows (follower_id, followed_artist_id) VALUES ($1, $2)",
      [parseInt(follower_id), parseInt(followed_artist_id)]
    );
    res.status(201).json({ success: true });
  } catch (error) {
    console.error("Error following:", error.message);
    res.status(500).json({ error: "Failed to follow artist" });
  }
});

// 🚫 Unfollow Artist (Only Buyers)
router.delete("/", async (req, res) => {
  const { follower_id, followed_artist_id } = req.body;

  try {
    await pgclient.query(
      "DELETE FROM follows WHERE follower_id = $1 AND followed_artist_id = $2",
      [parseInt(follower_id), parseInt(followed_artist_id)]
    );
    res.status(200).json({ success: true });
  } catch (error) {
    console.error("Error unfollowing:", error.message);
    res.status(500).json({ error: "Failed to unfollow artist" });
  }
});

// ✅ Check Follow Status
router.get("/check", async (req, res) => {
  const { follower_id, followed_artist_id } = req.query;

  try {
    const result = await pgclient.query(
      "SELECT 1 FROM follows WHERE follower_id = $1 AND followed_artist_id = $2",
      [parseInt(follower_id), parseInt(followed_artist_id)]
    );
    res.status(200).json({ isFollowing: result.rowCount > 0 });
  } catch (error) {
    console.error("Error checking follow status:", error.message);
    res.status(500).json({ error: "Failed to check follow status" });
  }
});

// 👥 Get followers count for an artist
router.get("/followers/:userId", async (req, res) => {
  const { userId } = req.params;
  try {
    const result = await pgclient.query(
      "SELECT COUNT(*) FROM follows WHERE followed_artist_id = $1",
      [parseInt(userId)]
    );
    res.json({ count: parseInt(result.rows[0].count) });
  } catch (err) {
    console.error("Error fetching followers:", err.message);
    res.status(500).json({ error: "Server error" });
  }
});

// 🔁 Get number of artists followed by a buyer
router.get("/followed/:userId", async (req, res) => {
  const { userId } = req.params;
  try {
    const result = await pgclient.query(
      "SELECT COUNT(*) FROM follows WHERE follower_id = $1",
      [parseInt(userId)]
    );
    res.json({ count: parseInt(result.rows[0].count) });
  } catch (err) {
    console.error("Error fetching followed artists:", err.message);
    res.status(500).json({ error: "Server error" });
  }
});

export default router;
