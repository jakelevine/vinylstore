Rails.application.config.middleware.use OmniAuth::Builder do
  provider :rdio, ENV['RDIO_KEY'], ENV['RDIO_SECRET']
  provider :lastfm, ENV['LASTFM_KEY'], ENV['LASTFM_SECRET']

end