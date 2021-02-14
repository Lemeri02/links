# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainValidator, type: :model do
  describe '#call' do
    it 'returns nil when link is invalid' do
      domains = DomainValidator.call(['host_without_dot_com'])
      expect(domains).to eq nil
    end

    it 'returns valid domains' do
      domains = DomainValidator.call(['funbox.ru', 'google.com'])
      expect(domains).to eq(['funbox.ru', 'google.com'])
    end

    it 'returns unique domains' do
      domains = DomainValidator.call(['funbox.ru', 'google.com', 'https://funbox.ru/search'])
      expect(domains).to eq(['funbox.ru', 'google.com'])
    end

    it 'returns only host without scheme, path and port' do
      domains = DomainValidator.call(['https://funbox.ru:8080/search&t=asdlkj&d=slkdlkl'])
      expect(domains).to eq(['funbox.ru'])
    end
  end
end
