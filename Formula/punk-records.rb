class PunkRecords < Formula
  include Language::Python::Virtualenv

  desc "Sync AI agent memories (CLAUDE.md, AGENTS.md, rules) across machines"
  homepage "https://github.com/gablooge/punk-records"
  url "https://files.pythonhosted.org/packages/9d/96/7c8dd72b31913b4e90015739b8fe9c7a85b1597d1aa3a60f708e77b82ef1/punk_records-0.6.0.tar.gz"
  sha256 "0cab151a6ce6a7b1c8be9027cab6b7324b2ea5b7e53bf962eaa9562b3691372d"
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
