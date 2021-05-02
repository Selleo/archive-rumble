import {
  listenAndServe,
  ServerRequest,
} from "https://deno.land/std@0.95.0/http/server.ts";

console.log("server is running...");

listenAndServe(
  { hostname: "0.0.0.0", port: 3000 },
  async (req: ServerRequest) => {
    let body = "Use /hello URI\n";
    
    if (req.url == "/hello") {
      body = "Hello\n";
    }
    
    console.log("\x1b[35m", req.method, "\x1b[32m", req.url, "\x1b[37m", req.headers.get("user-agent"));

    const headers = new Headers();
    headers.set("Content-Type", "text/plain");
    headers.set("Connection", "keep-alive");
    req.respond({
      status: 200,
      body,
      headers
    });
  }
);