require "base64"
require 'net/http'
require 'uri'
require 'json'

class IntegrationService

  def self.get_redirect_url(product)
    xml_document = product_params(product).to_xml
    encoded_string = Base64.encode64(xml_document)
    get_approve_url(encoded_string)
  end



  private
    def self.get_approve_url(encoded_string)
      uri = URI.parse(request_url)
      data = { encoded_string: encoded_string }
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
      request.body = data.to_json
      response = http.request(request)
      JSON.parse(response.body)["approve_url"]
    end

    def self.product_params(product)
      {
        name: product.name,
        amount: product.amount,
        email: product.email,
        user_name: product.user_name
      }
    end

    def self.request_url
      "https://blooming-beach-35304.herokuapp.com/payments/create_approve_url"
    end

end