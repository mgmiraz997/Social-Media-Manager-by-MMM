"use client";
import { useEffect } from "react";
import { setAuth, api } from "@/lib/api";
import { readToken } from "@/lib/session";

export default function DashboardLayout({ children }: { children: React.ReactNode }) {
  useEffect(() => {
    const token = readToken();
    if (token) {
      setAuth(token);
      document.cookie = `smm_token=${token}; path=/`;
      // Ensure user has a team; create default if missing
      (async () => {
        try {
          const { data } = await api.get("/teams/me"); // expect { teamId: string } | null
          if (!data || !data.teamId) {
            await api.post("/teams", { name: "My Team" });
          }
        } catch { /* ignore for now */ }
      })();
    }
  }, []);
  return <div className="w-full">{children}</div>;
}
