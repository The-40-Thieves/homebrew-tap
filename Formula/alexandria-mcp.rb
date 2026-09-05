class AlexandriaMcp < Formula
  desc "MCP server for natural-language search and cited answers across 152 public research libraries"
  homepage "https://github.com/The-40-Thieves/alexandria-mcp"
  url "https://registry.npmjs.org/@the-40-thieves/alexandria-mcp/-/alexandria-mcp-11.0.0.tgz"
  sha256 "b1b31f8d11ff4d152805ed2171af50075125910755ed33433554b38ae4b09159"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    request = {
      jsonrpc: "2.0",
      id: 1,
      method: "initialize",
      params: {
        protocolVersion: "2025-06-18",
        capabilities: {},
        clientInfo: { name: "brew-test", version: "1.0.0" },
      },
    }.to_json

    (testpath/"initialize.json").write("#{request}\n")

    output = with_env("TRANSPORT" => "stdio") do
      shell_output("#{bin}/alexandria-mcp < #{testpath}/initialize.json")
    end

    assert_match "serverInfo", output
  end
end
