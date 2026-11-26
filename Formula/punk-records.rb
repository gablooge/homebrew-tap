class PunkRecords < Formula
  include Language::Python::Virtualenv

  desc "Sync AI agent memories (CLAUDE.md, AGENTS.md, rules) across machines"
  homepage "https://github.com/gablooge/punk-records"
  url "https://files.pythonhosted.org/packages/d5/ef/b537592d4a746110baa86da4294a18896dbdeb2c4213c2652b08aa7c095e/punk_records-0.6.2.tar.gz"
  sha256 "813f42ef10b7ad521ebf3f1c67ad5b107ce570f067725dc9dbe1bf4bbee7806d"
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
