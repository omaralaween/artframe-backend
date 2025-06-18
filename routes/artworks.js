import express from "express";
import pgclient from "../db.js";
import { requireArtist } from "../middleware/roleAuth.js";

const router = express.Router();

// Get all artworks with artist info
router.get("/", async (req, res) => {
  try {
    const query = `
      SELECT artworks.*, users.username, users.avatar_url
      FROM artworks
      JOIN users ON artworks.artist_id = users.id
      ORDER BY artworks.created_at DESC;
    `;
    const result = await pgclient.query(query);
    res.status(200).json(result.rows);
  } catch (error) {
    console.error("Error fetching artworks:", error);
    res.status(500).json({ error: "Failed to fetch artworks" });
  }
});

// Get artworks by followed artists
router.get("/followed/:userId", async (req, res) => {
  const { userId } = req.params;

  try {
    const query = `
      SELECT a.*, u.username, u.avatar_url
      FROM artworks a
      JOIN follows f ON a.artist_id = f.followed_artist_id
      JOIN users u ON a.artist_id = u.id
      WHERE f.follower_id = $1
      ORDER BY a.created_at DESC;
    `;
    const result = await pgclient.query(query, [userId]);
    res.json(result.rows);
  } catch (error) {
    console.error("Error fetching followed artworks:", error);
    res.status(500).json({ error: "Failed to fetch feed" });
  }
});

// Post a new artwork (only by artists)
router.post("/", requireArtist, async (req, res) => {
  try {
    const { artist_id, title, description, image_url, price } = req.body;

    const query = `
      WITH inserted AS (
        INSERT INTO artworks (artist_id, title, description, image_url, created_at, price)
        VALUES ($1, $2, $3, $4, NOW(), $5)
        RETURNING *
      )
      SELECT inserted.*, users.username, users.avatar_url
      FROM inserted
      JOIN users ON inserted.artist_id = users.id;
    `;
    
    const values = [artist_id, title, description, image_url, price];
    const result = await pgclient.query(query, values);

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error("Error posting artwork:", error);
    res.status(500).json({ error: "Failed to post artwork" });
  }
});

// Get single artwork by ID
router.get("/:id", async (req, res) => {
  const { id } = req.params;

  try {
    const query = `
      SELECT artworks.*, users.username, users.avatar_url
      FROM artworks
      JOIN users ON artworks.artist_id = users.id
      WHERE artworks.id = $1
    `;
    const result = await pgclient.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Artwork not found" });
    }

    res.status(200).json(result.rows[0]);
  } catch (error) {
    console.error("Error fetching artwork by ID:", error);
    res.status(500).json({ error: "Failed to fetch artwork" });
  }
});

export default router;
