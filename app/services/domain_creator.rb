# frozen_string_literal: true

class DomainCreator < ApplicationService
  def initialize(domains, unix_time = nil)
    @domains = domains
    @unix_time = unix_time
  end

  def call
    create_host
  end

  private
  def create_host
    @domains.each do |domain|
      unix_time = @unix_time || REDIS.time.first

      # In Redis the same element can't be repeated in a sorted set since every element is unique.
      # To solve this case, we concatenate the elements with unix_time
      REDIS.zadd('host', unix_time, "#{domain}:#{unix_time}")
    end
  end
end
