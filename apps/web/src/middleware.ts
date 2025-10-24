import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(req: NextRequest) {
  if (!req.nextUrl.pathname.startsWith("/dashboard")) return NextResponse.next();
  const token = req.cookies.get("smm_token")?.value;
  if (!token) return NextResponse.redirect(new URL("/auth/login", req.url));
  return NextResponse.next();
}
export const config = { matcher: ["/dashboard/:path*"] };
