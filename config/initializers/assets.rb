# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap/css/bootstrap.min.css bootstrap/css/bootstrap-theme.min.css bootstrap/js/bootstrap.min.js bootstrap/css/dashboard.css bootstrap/css/ie10-viewport-bug-workaround.css bootstrap/js/holder.min.js bootstrap/js/ie10-viewport-bug-workaround.js admin/admin.js admin/pagination.css admin/signup.css bootstrap/js/ie-emulation-modes-warning.js kartik-v-bootstrap-fileinput/js/plugins/canvas-to-blob.min.js kartik-v-bootstrap-fileinput/js/plugins/sortable.min.js kartik-v-bootstrap-fileinput/js/plugins/purify.min.js kartik-v-bootstrap-fileinput/js/fileinput.min.js kartik-v-bootstrap-fileinput/themes/fa/theme.js kartik-v-bootstrap-fileinput/css/fileinput.min.css multiselect/js/multiselect.min.js multiselect/css/style.css multiselect/lib/google-code-prettify/prettify.css bootstrap-switch/js/bootstrap-switch.min.js bootstrap-switch/css/bootstrap3/bootstrap-switch.min.css client/css/bootstrap.min.css client/css/shop-homepage.css client/js/jquery.js client/js/bootstrap.min.js client/js/client.js bootstrap-notify-3.1.3/dist/bootstrap-notify.min.js rateyo.v2.1.1/jquery.rateyo.min.js rateyo.v2.1.1/jquery.rateyo.min.css bootstrap-validator/validator.min.js)

