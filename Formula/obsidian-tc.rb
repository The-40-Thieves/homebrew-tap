class ObsidianTc < Formula
  desc "Model-agnostic MCP server for Obsidian vaults with RBAC and native search"
  homepage "https://github.com/The-40-Thieves/obsidian-tc"
  version "1.31.3"
  license "AGPL-3.0-only"

  # Prebuilt Bun standalone binaries, published per-platform on every GitHub release
  # (The-40-Thieves/obsidian-tc's publish.yml). The release also ships a SHASUMS256.txt whose
  # digests match the sha256 values below (independently recomputed with `shasum -a 256` on each
  # downloaded asset, not copied from that file) and GitHub's own per-asset `digest` field
  # (`gh release view <tag> --json assets`), which agree with both. There is no cosign/sigstore
  # signature yet — the repo's publish.yml itself notes "cosign still deferred" — so sha256 pinning
  # here is the only integrity check available; revisit this comment if that changes.
  on_macos do
    on_arm do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-darwin-arm64"
      sha256 "3470f6a904ed64292198674cb3b7b0f93f1e63656671bff89e8c8de3b18c094c"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-darwin-x64"
      sha256 "bb39e9d700bc10f4105d184241fc16ef1887eb43caf0f374baed973a5dcf7f88"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-arm64"
      sha256 "52fa105345cdb2d18218c69586d07e82c10eefc804fa32d71300a3684a8848a3"
    end
    on_intel do
      url "https://github.com/The-40-Thieves/obsidian-tc/releases/download/v#{version}/obsidian-tc-bun-linux-x64"
      sha256 "f2673a04e2a4e554b5f0dc148361f9bf0be20df5e12a264ffe3adc7cc187ebf9"
    end
  end

  def install
    # Exactly one of the URLs above resolves per platform, so exactly one asset is staged here;
    # the downloaded filename carries the platform suffix (e.g. obsidian-tc-bun-linux-arm64).
    bin.install Dir["obsidian-tc-bun-*"].first => "obsidian-tc"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/obsidian-tc --version")
  end
end
