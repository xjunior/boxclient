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

module BoxClient
  module APIMethods
    def get_auth_token
      response = get(:get_auth_token, :ticket => @ticket)
      verify_response(response)
      @user = response['user']
      @auth_token = response['auth_token']
    end

    def get_ticket
      response = get(:get_ticket)
      verify_response(response)
      response
    end

    def get_tree(options={:onelevel=>true})
      ensure_authenticated
      folder_id = options.delete(:id) || 0
      options[:nozip] = true
      params = options.collect{|opt| opt[0] if opt[1]}.compact
      response = get(:get_account_tree,
        :auth_token => @auth_token,
        :folder_id => folder_id,
        :params => params)
      verify_response(response)
      response['tree']
    end
  end
end
