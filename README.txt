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

BoxClient is a library to remotely access Box.net accounts using the REST api.
This was originally written to supply the needs of the BoxFS project and
latelly it became a separate library for public use.

== Use
require 'box_client'
# These first 3 steps are mandatory for authentication
client = BoxClient::Client.new("your_api_key_goes_here")
client.authentication_url # you get the authentication URL here
# The user must visit this URL to authenticate using his username and password
client.get_auth_token # validate the authentication
# Now we're free to use the API
client.get_tree # get the root tree
client.get_tree(:id => 23456) # get the tree to folder with 23456 id
client.get_tree(:onelevel => false) # get the tree to root recursively
