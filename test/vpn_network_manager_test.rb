require File.dirname(__FILE__) + '/test_helper'

require 'tempfile'

module ChefVPCToolkit

class VpnNetworkManagerTest < Test::Unit::TestCase

  def setup
    tmpdir=TmpDir.new_tmp_dir
    File.open(File.join(tmpdir, "gconftool-2"), 'w') do |f|
      f.write("#!/bin/bash\nexit 0")
      f.chmod(0755)
    end
    ENV['PATH']=tmpdir+":"+ENV['PATH']
  end

  def teardown
    group_hash=CloudServersVPC.server_group_hash(SERVER_GROUP_XML)
    VpnNetworkManager.delete_certs(group_hash['id'])
  end

  def test_configure_gconf
    group_hash=CloudServersVPC.server_group_hash(SERVER_GROUP_XML)
    client_hash=CloudServersVPC.client_hash(CLIENT_XML)
    assert VpnNetworkManager.configure_gconf(group_hash, client_hash)
  end

  def test_ip_to_integer
    assert_equal 16782252, VpnNetworkManager.ip_to_integer("172.19.0.1")
  end

end

end