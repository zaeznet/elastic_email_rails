require 'action_mailer'

Dir[File.dirname(__FILE__) + '/elastic_email/*.rb'].each {|file| require file }

module ElasticEmail
end
