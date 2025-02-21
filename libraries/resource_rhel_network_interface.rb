#
# Author:: Jacob McCann (<jacob.mccann2@target.com>)
# Cookbook:: rcs-network_interfaces
# Resource:: rhel_network_interface
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

require_relative 'resource_network_interface'
require 'securerandom'

class Chef
  class Resource
    class NetworkInterface
      #
      # Chef Resource for a rhel_network_interface
      #
      class Rhel < Chef::Resource::NetworkInterface
        provides :rhel_network_interface
        provides :network_interface, os: 'linux', platform_family: %w(rhel fedora) if Gem::Version.new(Chef::VERSION) >= Gem::Version.new('12.0.0')
        provides :network_interface, on_platforms: [:redhat, :centos] unless Gem::Version.new(Chef::VERSION) >= Gem::Version.new('12.0.0')

        def initialize(name, run_context = nil)
          super
          @resource_name = :rhel_network_interface
          @provider = Chef::Provider::NetworkInterface::Rhel

          @type = 'Ethernet'
          @nm_controlled = false

          if node['platform_version'].to_i >= 9
            @nm_controlled = true
            if name.start_with?('br')
              @type = 'Bridge'
            end
          end

          if @vlan == true
            @type = 'Vlan'
          end

          # @uuid = SecureRandom.uuid
        end

        property :nm_controlled, [TrueClass, FalseClass]
        property :ipv6init, [TrueClass, FalseClass]
        property :nozeroconf, [TrueClass, FalseClass]
        property :userctl, [TrueClass, FalseClass]
        property :peerdns, [TrueClass, FalseClass]
        property :bridge_device, String
        property :network, String
        property :type, String
        property :uuid, String
        property :devicetype, String
        property :ovs_bridge, String
        property :vlan, [TrueClass, FalseClass]
        property :mac_address, String, regex: /^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$/
        property :dns, [String, Array]
        property :prefix, Integer
        property :dns_domain, String
        property :zone, String
        property :arpcheck, [TrueClass, FalseClass]
        property :hotplug, [TrueClass, FalseClass]
        property :metric, Integer
        property :defroute, [TrueClass, FalseClass]
        property :ovsbootproto, String
        property :ovsdhcpinterfaces, [String, Array]
      end
    end
  end
end
