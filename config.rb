activate :directory_indexes

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
page "/*.xml", layout: false
page "/*.json", layout: false
page "/*.txt", layout: false

ignore "/slack.html"

years = data.slack_statuses.map { |status| status.date.year }.uniq

years.each do |year|
  proxy "/slack-statuses/#{year}", "/slack.html", locals: { year: year }, layout: "layout"
end

# No idea why I have to hand-code this - will have to figure it out later.
proxy "/slack-statuses", "/slack.html", locals: { year: 2023 }, layout: "layout"

helpers do
end

configure :build do
  config[:prod] = true
  set :build_dir, "public"
end
