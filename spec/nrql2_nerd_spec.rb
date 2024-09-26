# frozen_string_literal: true

require "nrql2nerd"

RSpec.describe NRQL2Nerd do
  before do
    ENV["NEW_RELIC_API_KEY"] = "1234567890"
    ENV["NEW_RELIC_ACCOUNT_ID"] = "1234567890"
  end

  it "has a version number" do
    expect(NRQL2Nerd::VERSION).not_to be_nil
  end
end
