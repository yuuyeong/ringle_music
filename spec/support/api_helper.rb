module ApiHelper
  def authenticated_header(user)
    headers = { 'Accept' => 'applicatilon/json', 'Content-Type' => 'application/json' }
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end
end