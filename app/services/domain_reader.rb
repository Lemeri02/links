# frozen_string_literal: true

class DomainReader < ApplicationService
  def initialize(from, to)
    @from = from
    @to = to
  end

  def call
    find_domains if !@from.nil? && !@to.nil? && (@from.to_i <= @to.to_i)
  end

  private
  def find_domains
    domains = REDIS.zrangebyscore('host', @from, @to)

    # In Redis the same element can't be repeated in a sorted set since every element is unique.
    # To solve this case, we concatenate the elements with unix_time
    # Then in this method we cut unix_time and return only unique domains
    domains.map do |domain|
      domain.split(':')[0]
    end.uniq
  end
end
