# frozen_string_literal: true

require_relative "nrql2nerd/version"
require_relative "nrql2nerd/client"
require "json"
require "net/http"
require "uri"

module NRQL2Nerd
  class Error < StandardError; end
end
