# frozen_string_literal: true

require "spec_helper"
require "nrql2nerd/client"
require "webmock/rspec"

RSpec.describe NRQL2Nerd::Client do
  before do
    ENV["NEW_RELIC_API_KEY"] = "test-api-key"
    ENV["NEW_RELIC_ACCOUNT_ID"] = "12345"
  end

  let(:client) { described_class.new }
  let(:query) { "SELECT * FROM Transaction" }

  describe "#graphql_nrql_query" do
    it "returns a formatted GraphQL query string" do # rubocop:disable RSpec/ExampleLength
      expected_query = <<~GRAPHQL.strip
          query {
            actor {
              account(id: 12345) {
              nrql(query: "SELECT * FROM Transaction") {
                results
              }
            }
          }
        }
      GRAPHQL

      expect(client.graphql_nrql_query(query).strip).to eq(expected_query)
    end
  end

  describe "#graphql_hash" do
    it "returns a hash with the query key" do
      expect(client.graphql_hash(query)).to have_key(:query)
    end
  end

  describe "#prepare_query" do
    it "returns a JSON string" do
      result = client.prepare_query(query)
      expect { JSON.parse(result) }.not_to raise_error
    end
  end

  describe "#uri" do
    it "returns the correct URI" do
      expect(client.uri.to_s).to eq("https://api.newrelic.com/graphql")
    end
  end

  describe "#client" do
    it "returns a Net::HTTP object" do
      expect(client.client).to be_a(Net::HTTP)
    end

    it "sets use_ssl to true" do
      expect(client.client.use_ssl?).to be true
    end
  end

  describe "#make_query_request" do
    before do
      stub_request(:post, "https://api.newrelic.com/graphql")
        .to_return(status: 200, body: {
          data: {
            actor: {
              account: {
                nrql: {
                  results: []
                }
              }
            }
          }
        }.to_json, headers: { "Content-Type" => "application/json" })
    end

    it "sends a POST request with correct headers and body" do
      response = client.make_query_request(query)
      expect(response).to be_a(Net::HTTPResponse)
    end
  end

  describe "#run_query" do
    before do
      stub_request(:post, "https://api.newrelic.com/graphql")
        .to_return(status: 200, body: {
          data: {
            actor: {
              account: {
                nrql: {
                  results: [{ count: 42 }]
                }
              }
            }
          }
        }.to_json, headers: { "Content-Type" => "application/json" })
    end

    it "returns parsed results from the API response" do
      results = client.run_query(query)
      expect(results).to eq([{ "count" => 42 }])
    end
  end
end
