class PunkRecords < Formula
  include Language::Python::Virtualenv

  desc "Sync AI agent memories (CLAUDE.md, AGENTS.md, rules) across projects and machines"
  homepage "https://github.com/gablooge/punk-records"
  url "https://files.pythonhosted.org/packages/0c/49/521cce46fe002d96445544c42e459f8ffc99940fd16559d24b83a5c71df3/punk_records-0.4.0.tar.gz"
  sha256 "d182592da2c675937c670969b7b1638f6e5295de266b0dc470fec0e89c4c74e5"
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
