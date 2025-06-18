export function requireBuyer(req, res, next) {
  const role = req.headers["x-role"];
  if (role === "buyer") {
    next();
  } else {
    res.status(403).json({ message: "Buyer access only" });
  }
}

export function requireArtist(req, res, next) {
  const role = req.headers["x-role"];
  if (role === "artist") {
    next();
  } else {
    res.status(403).json({ message: "Artist access only" });
  }
}
