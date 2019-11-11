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

  def self.install_packages(package_list)
    install_command = ''

    case distro
    when 'ubuntu'
      install_command = 'sudo apt install -y'
    end

    system("#{install_command} #{package_list.join(' ')} ")
  end
end
