class Senn < Formula
  desc "Git-native infrastructure for single operators, built on Nix and OpenTofu."
  homepage "https://mrbandler.github.io/senn/"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mrbandler/senn/releases/download/v0.3.0/senn-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9b464a6940fda3ba20273dd95e59e8a2a83d1ed87c34d06b3a70e431d5d40247"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrbandler/senn/releases/download/v0.3.0/senn-cli-x86_64-apple-darwin.tar.xz"
      sha256 "fe3b36ff5186f89aae4574a810665670d2b7d72d85324a2903a16178037e280c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mrbandler/senn/releases/download/v0.3.0/senn-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9bc9dda246a3ed6ebf23b97130963f5ab97ffb2e1138f061cc02736a5a917cfb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mrbandler/senn/releases/download/v0.3.0/senn-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f4e76185d70e5e6802d91be45838fbd6b5fca9cad6de47dd4a89b31b622f9020"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "senn"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "senn"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "senn"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "senn"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
