class PunkRecords < Formula
  include Language::Python::Virtualenv

  desc "Sync AI agent memories (CLAUDE.md, AGENTS.md, rules) across machines"
  homepage "https://github.com/gablooge/punk-records"
  url "https://files.pythonhosted.org/packages/69/70/16af36fb258626fa89609132ecf79eaaf189b617835f01b38405e12e719b/punk_records-0.6.1.tar.gz"
  sha256 "3ac3363f638cefde325e270e9a2aa2ccca3ffdd565e5d0fd9001588f8c251d3a"
  license "MIT"

  depends_on "python@3.15"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/punk --version")

    ENV["HOME"] = testpath
    ENV["GIT_CONFIG_GLOBAL"] = testpath/"gitconfig"
    touch testpath/"gitconfig"
    system bin/"punk", "--home", testpath/"store", "init", "--no-global", "--machine", "brew"
    (testpath/"app").mkpath
    (testpath/"app/CLAUDE.md").write "- run tests with make test\n"
    system bin/"punk", "--home", testpath/"store", "track", testpath/"app", "--id", "local/app"
    system bin/"punk", "--home", testpath/"store", "save"
    assert_match "make test", shell_output("#{bin}/punk --home #{testpath}/store show local/app CLAUDE.md")
  end
end
