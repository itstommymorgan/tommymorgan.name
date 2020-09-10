activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Ugly monkeypatching but it seems the only sane way to get around a bug in the
# autoprefixer logic right now.
module ::AutoprefixerRails
  def self.show_deprecation_message!
    return nil
  end
end

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

helpers do

end

configure :build do
  config[:prod] = true
  set :build_dir, 'public'
end
