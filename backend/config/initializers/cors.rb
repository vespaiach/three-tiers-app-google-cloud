# in config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:8080",
            "http://127.0.0.1:8080",
            "https://www.letbike.com",
            "https://letbike.com"

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true,
      max_age: 86400
  end
end
