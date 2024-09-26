# frozen_string_literal: true

module NRQL2Nerd
  class Error < StandardError; end

  class Client
    def initialize(api_key: nil, account_id: nil)
      @api_key = ENV.fetch("NEW_RELIC_API_KEY", api_key)
      @account_id = ENV.fetch("NEW_RELIC_ACCOUNT_ID", account_id)

      raise "NEW_RELIC_API_KEY is not set" if @api_key.nil?
      raise "NEW_RELIC_ACCOUNT_ID is not set" if @account_id.nil?
    end

    def graphql_nrql_query(query)
      <<~GRAPHQL
          query {
            actor {
              account(id: #{@account_id}) {
              nrql(query: "#{query}") {
                results
              }
            }
          }
        }
      GRAPHQL
    end

    def graphql_hash(query)
      {
        query: graphql_nrql_query(query)
      }
    end

    def prepare_query(query)
      JSON.pretty_generate(graphql_hash(query))
    end

    def client
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      http
    end

    def uri
      URI("https://api.newrelic.com/graphql")
    end

    def make_query_request(query)
      request = Net::HTTP::Post.new(uri)
      request["Content-Type"] = "application/json"
      request["API-Key"] = @api_key
      request.body = prepare_query(query)

      client.request(request)
    end

    def run_query(query)
      response = make_query_request(query)

      JSON.parse(response.body).dig("data", "actor", "account", "nrql", "results")
    end
  end
end
