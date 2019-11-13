# frozen_string_literal: true

#:nodoc:
module LinuxOS
  def self.parse_release_file
    release_file = '/etc/os-release'
    output = {}
    File.read(release_file).each_line do |line|
      line2 = line.chomp.tr('"', '').split('=')
      output[line2[0].to_sym] = line2[1]
    end
    output
  end

  def self.distro
    parse_release_file[:ID]
  end

  def self.version
    parse_release_file[:VERSION_ID]
  end

  def self.install_packages(ubuntu, snap, flatpak, arch, aur)
    install_command = ''

    ubuntu_packages = ubuntu
    snap_packages = snap
    flat_packages = flatpak
    pacman_packages = arch
    aur_packages = aur

    case LinuxOS.distro
    when 'ubuntu'
      if !ubuntu_packages.empty?
        install_command = "sudo apt install -y #{ubuntu_packages.join(' ')}"
      elsif !snap_packages.empty?
        install_command = "sudo snap install #{snap_packages.join(' ')}"
      elsif !flat_packages.empty?
        install_command = "flatpak install -y flathub #{flat_packages.join(' ')}"
      end
    when 'arch'
      if !pacman_packages.empty?
        install_command = "sudo pacman -S #{pacman_packages.join(' ')}"
      else !aur_packages.empty?
        install_command = 'echo building functionality'
      end
    end

    system(install_command)
  end
end
