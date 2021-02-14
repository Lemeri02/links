# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainReader, type: :model do
  describe '#call' do
    let(:from) { 0 }
    let(:to) { 2 }

    before :each do
      domains = ['funbox.ru', 'mail.ru']
      DomainCreator.call(domains, 1)
    end

    it 'returns domains between from and to' do
      domains = DomainReader.call(from, to)
      expect(domains).to eq ['funbox.ru', 'mail.ru']
    end
  end
end
