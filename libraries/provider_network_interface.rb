#
# Author:: Jacob McCann (<jacob.mccann2@target.com>)
# Cookbook Name:: rcs-network_interfaces
# Provider:: network_interface
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

require 'chef/provider/lwrp_base'

class Chef
  class Provider
    #
    # Chef Provider for Network Interfaces
    #
    class NetworkInterface < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)

      action :create do
        raise Chef::Exceptions::UnsupportedAction, "#{self} does not support :create"
      end
    end
  end
end
