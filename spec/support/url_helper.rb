module UrlHelper
  def api_url(path)
    %r{^https://token-1234:secret-1234@netverify\.com/#{path}}
  end
end
