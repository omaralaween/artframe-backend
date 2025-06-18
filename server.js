import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import pgclient from './db.js';
import authRoute from './routes/auth.js';
import artworkRoute from './routes/artworks.js';
import usersRoute from './routes/users.js';
import likesRoute from "./routes/likes.js";
import commentsRoute from './routes/comments.js';
import purchaseRoute from './routes/purchases.js';
import followsRoute from './routes/follows.js'

const app = express();
dotenv.config();
app.use(cors());
app.use(express.json());

const PORT = process.env.PORT;

app.use("/api/auth", authRoute);
app.use("/api/artworks", artworkRoute);
app.use("/api/users", usersRoute);
app.use("/api/likes", likesRoute);
app.use("/api/comments", commentsRoute);
app.use("/api/purchases", purchaseRoute);
app.use("/api/follows", followsRoute);


pgclient.connect()
  .then(() => console.log("🟢 Connected to PostgreSQL"))
  .catch(err => console.error("🔴 DB connection error:", err));

app.listen(PORT, () => {
  console.log(`Listening on PORT ${PORT}`);
});
