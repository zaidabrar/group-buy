import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  serverExternalPackages: ["pg"],
  // Let the dev server be opened through GitHub Codespaces forwarded URLs.
  allowedDevOrigins: ["*.app.github.dev"],
};

export default nextConfig;
