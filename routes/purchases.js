import express from "express";
import pgclient from "../db.js";
import { requireBuyer } from "../middleware/roleAuth.js"; // ✅ import named middleware

const router = express.Router();

// 🛒 Record Purchase (Only Buyers Allowed)
router.post("/", requireBuyer, async (req, res) => {
  const { user_id, artwork_id } = req.body;

  try {
    await pgclient.query(
      "INSERT INTO purchases (user_id, artwork_id) VALUES ($1, $2)",
      [user_id, artwork_id]
    );
    res.status(201).json({ success: true });
  } catch (error) {
    console.error("Error buying artwork:", error);
    res.status(500).json({ error: "Failed to process purchase" });
  }
});

// 📈 Get Purchase Count for an Artist (SALES COUNT)
router.get("/artist/:artistId", async (req, res) => {
  const { artistId } = req.params;

  try {
    const result = await pgclient.query(
      `SELECT COUNT(*) FROM purchases 
       WHERE artwork_id IN (SELECT id FROM artworks WHERE artist_id = $1)`,
      [artistId]
    );
    res.json({ count: parseInt(result.rows[0].count) });
  } catch (err) {
    console.error("Error fetching sales:", err);
    res.status(500).json({ error: "Server error" });
  }
});

// 🧾 Get All Purchases for a User (Buyer)
router.get("/:userId", async (req, res) => {
  const { userId } = req.params;

  try {
    const result = await pgclient.query(`
      SELECT a.*, u.username AS artist_name, u.avatar_url
      FROM purchases p
      JOIN artworks a ON p.artwork_id = a.id
      JOIN users u ON a.artist_id = u.id
      WHERE p.user_id = $1
    `, [userId]);

    res.status(200).json(result.rows);
  } catch (error) {
    console.error("Error fetching purchases:", error);
    res.status(500).json({ error: "Failed to get purchases" });
  }
});

export default router;
