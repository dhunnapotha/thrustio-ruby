require_relative '../../../../lib/anymail/anymail'
require 'test/unit'
require 'mocha/test_unit'
require 'json'

class AnyMailClientTest < Test::Unit::TestCase

  def test_constants
    assert_equal "https://thrust.io/api/v1/mail", Thrust::AnyMail::API_URL
    assert_equal "https://thrust.io/api/v1/mail/search", Thrust::AnyMail::SEARCH_URL
    assert_equal "https://thrust.io/api/v1/mail/searchesLeft", Thrust::AnyMail::SEARCHES_LEFT_URL
  end


  def test_search_should_post_necessary_params_and_return_emails
    client = Thrust::AnyMail::Client.new('dummy-key')

    RestClient.expects(:post).with("https://thrust.io/api/v1/mail/search", {:name => "Gautam Chandra" , :domain => "gmail.com", :key => "dummy-key"}).returns({:status => "success", :emails => ["gautam@gmail.com", "gautam.chandra@gmail.com"]}.to_json)

    expected_emails = ["gautam@gmail.com", "gautam.chandra@gmail.com"]
    assert_equal expected_emails, client.search("Gautam Chandra", "gmail.com")

  end

end

