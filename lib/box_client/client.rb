#--
# Copyright (c) 2008 Carlos Henrique Júnior <carlos@milk-it.net>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

require 'active_resource'
require 'box_client/error'
require 'box_client/api_methods'

module BoxClient
  class Client < ActiveResource::Base
    self.site = 'http://www.box.net/api/1.0/rest'
    include APIMethods
    include Error::HelperMethods

    def initialize(apikey)
      @apikey = apikey
      response = get_ticket
      @ticket = response['ticket']
    end

    def authentication_url
      'http://www.box.net/api/1.0/auth/%s' % @ticket
    end

    def user
      @user
    end

    def auth_token
      @auth_token
    end

    private

    def self.custom_method_collection_url(method_name, options={})
      options[:action] = method_name
      prefix_options, query_options = split_options(options)
      "#{prefix(prefix_options).chop}#{query_string(query_options)}"
    end

    def custom_method_element_url(method_name, options={})
      options[:api_key] = @apikey
      self.class.custom_method_collection_url(method_name, options)
    end
  end
end
