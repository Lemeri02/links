# frozen_string_literal: true

class DomainValidator < ApplicationService
  def initialize(domains)
    @domains = domains
  end

  def call
    validate_domains
  end

  private
  def validate_domains
    domains = @domains.map { |domain| parse_for_domain(domain) }

    # @return nil if domains array contains any nil element
    return nil if domains.any?(&:nil?)

    domains.uniq
  end

  def parse_for_domain(string)
    return nil if string.empty?

    raw = string.strip

    # Add a scheme to the string in case it has none,
    # because it is required for parsing well with URI
    copy = "https://#{raw}" unless "#{raw}".match('://')
    copy ||= raw

    host = URI.parse(copy).host

    # Validate a host with gem public_suffix
    return nil unless PublicSuffix.valid?(host, ignore_private: true)

    host
  end
end
