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
  module Error
    class InvalidAPIKey; end
    class Unauthenticated; end
    class ApplicationRestricted; end
    class UnexistentFolder; end

    module HelperMethods
      def ensure_authenticated
        raise Unauthenticated, 'Please, authenticate first.' unless @auth_token
      end

      def verify_response(response)
        case response['status']
        when /^get_.*_ok$/
            return
        when 'not_logged_in'
            raise Unauthenticated, 'Client unauthenticated'
        when 'application_restricted'
            raise ApplicationRestricted, 'Box.net restricted access to resource'
        when 'e_folder_id'
            raise UnexistentFolder, 'Unexistent folder!'
        end
      end
    end
  end
end
