resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "hcloud_ssh_key" "default" {
  name       = var.ssh_key_name
  public_key = tls_private_key.ssh_key.public_key_openssh

  depends_on = [tls_private_key.ssh_key]
}
