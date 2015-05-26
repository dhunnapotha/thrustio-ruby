
class AnyMailClientTest < Test::Unit::TestCase

  def test_constants
    assert_equal "https://thrust.io/api/v1/mail", Thrust::AnyMail::API_URL
    assert_equal "https://thrust.io/api/v1/mail/search", Thrust::AnyMail::SEARCH_URL
    assert_equal "https://thrust.io/api/v1/mail/searchesLeft", Thrust::AnyMail::SEARCHES_LEFT_URL
  end


  def test_search_should_post_necessary_params_and_return_array_of_emails
    client = Thrust::AnyMail::Client.new('dummy-key')
    expected_params = {:name => "Gautam Chandra" , :domain => "gmail.com", :key => "dummy-key"}
    stubbed_response = {:status => "success", :emails => ["gautam@gmail.com", "gautam.chandra@gmail.com"]}.to_json

    RestClient.expects(:post).with("https://thrust.io/api/v1/mail/search", expected_params).returns(stubbed_response)

    expected_emails = ["gautam@gmail.com", "gautam.chandra@gmail.com"]
    assert_equal expected_emails, client.search("Gautam Chandra", "gmail.com")

  end


  def test_searches_left_should_post_necessary_params_and_return_the_count_of_searches_left 
    client = Thrust::AnyMail::Client.new('dummy-key')
    expected_params = {:key => "dummy-key"}
    stubbed_response = {:status => "success", :searches => "40"}.to_json

    RestClient.expects(:post).with("https://thrust.io/api/v1/mail/searchesLeft", expected_params).returns(stubbed_response)

    assert_equal 40, client.searchesLeft
  end

end

