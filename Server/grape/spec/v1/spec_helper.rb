Bundler.require(:default)
Bundler.require(:test)

require "rack/test"

require_relative '../../config/config'
require_relative '../../../lib/logger_with_lineno'
Dir[File.dirname(__FILE__)+"/../../model/*.rb"].each{ |file|
  require_relative file
}
require_relative '../../dispatch'


def get_session_id
  'a86a484534bb45e1822732d663c7f639'
end
