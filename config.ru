require './config/environment'

use Rack::MethodOverride
use RecipesController
use SessionController
use UsersController
run ApplicationController