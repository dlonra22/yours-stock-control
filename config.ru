require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end



#enable delete and patch requests
use Rack::MethodOverride

run ApplicationController
use TransactionsController
use ItemsController
use UsersController

