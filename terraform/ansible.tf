locals {
  extra_vars = {
    download_cache_dir = "${abspath(path.root)}/.terraform"
    ansible_user       = var.vm_username
    ansible_sudo_pass  = random_password.password.result
    ansible_password   = random_password.password.result
  }

  extra_vars_file = "${abspath(path.root)}/.terraform/ansible-%s.json"
  playbook_path   = "../ansible/${var.playbook}"
}

resource "null_resource" "this" {

  provisioner "local-exec" {
    environment = {
      "TMP${self.id}" = jsonencode(local.extra_vars)
    }

    command = "echo $TMP${self.id} > ${format(local.extra_vars_file, self.id)}"
  }

  provisioner "local-exec" {
    environment = {
      ANSIBLE_FORCE_COLOR                = "False"
      ANSIBLE_HOST_KEY_CHECKING          = "False"
      ANSIBLE_USE_PERSISTENT_CONNECTIONS = "True"
    }

    command = <<-EOT
      extra_vars_file="${format(local.extra_vars_file, self.id)}"
      inventory="${azurerm_public_ip.this.ip_address},"
      ansible-playbook -v -c paramiko \
        -i "$inventory" -e "@$extra_vars_file" \
        --ssh-extra-args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' \
        "${local.playbook_path}" &&\
      rm -f $extra_vars_file
    EOT
  }

}
