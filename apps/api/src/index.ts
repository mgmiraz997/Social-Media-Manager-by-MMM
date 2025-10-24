import "dotenv/config";
import express from "express";
import cors from "cors";
import pino from "pino";

const app = express();
const logger = pino();

app.use(cors());
app.use(express.json());

// Health check
//app.get("/health", (_, res) => res.json({ ok: true }));

const port = process.env.PORT || 4000;

app.get("/", (_req, res) => {
  res.send("✅ API is running. Try GET /health");
});

app.listen(port, () => {
  logger.info(`API running on http://localhost:${port}`);
});