# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( bootstrap/css/bootstrap.min.css bootstrap/css/bootstrap-theme.min.css bootstrap/js/bootstrap.min.js bootstrap/css/dashboard.css bootstrap/css/ie10-viewport-bug-workaround.css bootstrap/js/holder.min.js bootstrap/js/ie10-viewport-bug-workaround.js )

