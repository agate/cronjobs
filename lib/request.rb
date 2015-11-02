require 'yaml'
require 'rest-client'

class Request
  BASE_DIR = File.expand_path('../..', __FILE__)
  USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2438.3 Safari/537.36'

  def initialize(name, opts={})
    @name = name.to_s
    @config = YAML.load_file("#{BASE_DIR}/config/tasks_config.yml")[@name]
    @opts = opts
  end

  def get(url, ext_headers={})
    RestClient.get(url, ext_headers).to_str.force_encoding(Encoding::UTF_8)
  end

  private

  def headers(ext={})
    {
      'cookie' => @config['cookie'],
      'user-agent' => USER_AGENT
    }.merge(ext)
  end
end
