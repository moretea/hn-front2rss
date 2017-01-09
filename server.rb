require "erb"
require "net/http"

require "bundler"
Bundler.setup
require "sinatra"
require "oga"


def process(day, page)
  url = URI("https://news.ycombinator.com/front?day=%s-%s-%s&p=%s" % [day.year, day.month, day.day, page])
  html = Net::HTTP.get(url)
  doc = Oga.parse_html(html)
  trs = doc.css(".itemlist > tr").to_a
  trs.pop(2) # remove last two tr's; contains "more" link.

  stories = trs.each_slice(3).to_a
  stories.shift # First one just contains meta info

  stories.map do |top, details, spacer|
    story_link = top.css("a.storylink").first

    {
      id: top.get("id"),
      title: story_link.text,
      link: story_link.get("href"),
      commentLink: "https://news.ycombinator.com/item?id=#{top.get("id")}"
    }
  end
end

def generate_rss(items)
  renderer = ERB.new(File.read("rss.xml.erb"))
  renderer.result(binding)
end

get "/hn.rss" do
  yesterday = Date.today - 1
  items = process(yesterday, 1)
  items += process(yesterday, 2)

  content_type "application/atom+xml"

  generate_rss(items)
end
