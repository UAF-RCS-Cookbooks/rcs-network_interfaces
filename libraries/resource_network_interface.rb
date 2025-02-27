#
# Author:: Jacob McCann (<jacob.mccann2@target.com>)
# Cookbook:: rcs-network_interfaces
# Resource:: network_interface
#
# Copyright:: 2015, Target Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/resource'
require 'ipaddr'

class Chef
  class Resource
    #
    # Chef Resource for a network_interface
    #
    class NetworkInterface < Chef::Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :network_interface
        @provider = Chef::Provider::NetworkInterface
        @action = :create
        @allowed_actions = [:create]

        # This is equivalent to setting :name_attribute => true
        @device = name

        @bootproto = 'dhcp'
        @onboot = true
        @cookbook = 'rcs-network_interfaces'
        if node['platform_version'].to_i >= 9 && node['platform_family'] == 'rhel'
          @source = 'nmconnection.erb'
        else
          @source = 'ifcfg.erb'
        end
        @reload = true
        @reload_type = :immediately
      end

      def cookbook(arg = nil)
        set_or_return(:cookbook, arg, kind_of: String)
      end

      def source(arg = nil)
        set_or_return(:source, arg, kind_of: String)
      end

      def device(arg = nil)
        set_or_return(:device, arg, kind_of: String)
      end

      def type(arg = nil)
        set_or_return(:type, arg, kind_of: String)
      end

      def bridge_stp(arg = nil) # Needs added to NM
        set_or_return(:bridge_stp, arg, kind_of: [TrueClass, FalseClass])
      end

      def bond_master(arg = nil) # Needs added to NM
        set_or_return(:bond_master, arg, kind_of: String)
      end

      def bond_mode(arg = nil) # Needs added to NM
        set_or_return(:bond_mode, arg, kind_of: String)
      end

      def onboot(arg = nil)
        set_or_return(:onboot, arg, kind_of: [TrueClass, FalseClass])
      end

      def bootproto(arg = nil) # Needs added to NM
        set_or_return(:bootproto, arg, kind_of: String)
      end

      def address(arg = nil)
        set_or_return(:address, arg, kind_of: String)
      end

      def gateway(arg = nil)
        set_or_return(:gateway, arg, kind_of: String)
      end

      def mtu(arg = nil)
        set_or_return(:mtu, arg, kind_of: Integer)
      end

      def netmask(arg = nil)
        if node['platform_version'].to_i >= 9 && node['platform_family'] == 'rhel'
          arg = IPAddr.new(arg.to_s).to_i.to_s(2).count("1").to_s unless arg.nil?
        else
          set_or_return(:mask, arg, kind_of: String)
        end
      end

      def broadcast(arg = nil) # Needs added to NM
        set_or_return(:broadcast, arg, kind_of: String)
      end

      def reload(arg = nil) # Needs added to NM
        set_or_return(:reload, arg, kind_of: [TrueClass, FalseClass])
      end

      def reload_type(arg = nil) # Needs added to NM
        set_or_return(:reload_type, arg, kind_of: Symbol)
      end

      def hw_address(arg = nil)
        set_or_return(:hw_address, arg, kind_of: String, regex: /^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$/)
      end

      def vlan(arg = nil)
        set_or_return(:vlan, arg, kind_of: [TrueClass, FalseClass, String, Integer])
      end

      def post_up(arg = nil) # Needs added to NM
        set_or_return(:post_up, arg, kind_of: [String, Array])
      end
    end
  end
end
