class AwsSearchInstances < Formula
  include Language::Python::Virtualenv

  desc "Search AWS EC2 Instances and Export Tags to CSV"
  homepage "https://github.com/aws-samples/search-ec2-instances-export-tags"
  license "MIT"
  head "https://github.com/aws-samples/search-ec2-instances-export-tags.git", branch: "main"

  depends_on "python@3.10"

  resource "awscli" do
    url "https://files.pythonhosted.org/packages/eb/d2/b742c43c1393bd3e04ef3bb7bb575c5225876140521a072fb6542657ab2e/awscli-1.25.72.tar.gz"
    sha256 "488f50c21a58d8916a2f158532c8e917ddf7adece03e763634045b173b8413c5"
  end

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/72/63/baebfcb18a2ff05b26b6603fd73f262ce5155c1cbc9adb7f00240ad82dd9/boto3-1.24.71.tar.gz"
    sha256 "0ee555dc0f362d2761d86e0264ee79985b09de4289334fbec7de384b39ccce72"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/d5/20/458287e7879f8a1fbe50076370b1487a3a3e6b1299543cfdf706f27a9edf/botocore-1.27.71.tar.gz"
    sha256 "91dc4e8ae768db3a5c26ef8acd6425bbbec4b17636350d526c226a5879d3c613"
  end

  resource "colorama" do
    url "https://files.pythonhosted.org/packages/1f/bb/5d3246097ab77fa083a61bd8d3d527b7ae063c7d8e8671b1cf8c4ec10cbe/colorama-0.4.4.tar.gz"
    sha256 "5941b2b48a20143d2267e95b1c2a7603ce057ee39fd88e7329b0c292aa16869b"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/2f/e0/3d435b34abd2d62e8206171892f174b180cd37b09d57b924ca5c2ef2219d/docutils-0.16.tar.gz"
    sha256 "c2de3a60e9e7d07be26b7f2b00ca0309c207e06c100f9cc2a94931fc75a478fc"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/00/2a/e867e8531cf3e36b41201936b7fa7ba7b5702dbef42922193f05c8976cd6/jmespath-1.0.1.tar.gz"
    sha256 "90261b206d6defd58fdd5e85f478bf633a2901798906be2ad389150c5c60edbe"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/a4/db/fffec68299e6d7bad3d504147f9094830b704527a7fc098b721d38cc7fa7/pyasn1-0.4.8.tar.gz"
    sha256 "aef77c9fb94a3ac588e87841208bdec464471d9871bd5050a287cc9a475cd0ba"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/a0/a4/d63f2d7597e1a4b55aa3b4d6c5b029991d3b824b5bd331af8d4ab1ed687d/PyYAML-5.4.1.tar.gz"
    sha256 "607774cbba28732bfa802b54baa7484215f530991055bb562efbed5b2f20a45e"
  end

  resource "rsa" do
    url "https://files.pythonhosted.org/packages/db/b5/475c45a58650b0580421746504b680cd2db4e81bc941e94ca53785250269/rsa-4.7.2.tar.gz"
    sha256 "9d689e6ca1b3038bc82bf8d23e944b6b6037bc02301a574935b2dd946e0353b9"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/e1/eb/e57c93d5cd5edf8c1d124c831ef916601540db70acd96fa21fe60cef1365/s3transfer-0.6.0.tar.gz"
    sha256 "2ed07d3866f523cc561bf4a00fc5535827981b117dd7876f036b0c1aca42c947"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/71/39/171f1c67cd00715f190ba0b100d606d440a28c93c7714febeca8b79af85e/six-1.16.0.tar.gz"
    sha256 "1e61c37477a1626458e36f7b1d82aa5c9b094fa4802892072e49de9c60c4c926"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/b2/56/d87d6d3c4121c0bcec116919350ca05dc3afd2eeb7dc88d07e8083f8ea94/urllib3-1.26.12.tar.gz"
    sha256 "3fa96cf423e6987997fc326ae8df396db2a8b7c667747d47ddd8ecba91f4a74e"
  end

  def install
    venv = virtualenv_create(libexec, "python3.10")
    resources.each do |r|
      venv.pip_install r
    end
    
    file_with_shebang = ""
    File.open('search_instances.py', 'r') do |fd|
      contents = fd.read
      file_with_shebang = "#!#{libexec}/bin/python3.10\n" << contents
    end
    File.open('search_instances.py', 'w') do |fd| 
      fd.write(file_with_shebang)
    end

    bin.install "search_instances.py" => "aws-search-instances"
  end

  test do
    assert_match(/^usage: aws-search-instances/, shell_output("#{bin}/aws-search-instances --help").strip)
  end
end
