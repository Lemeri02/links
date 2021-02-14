# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainsController, type: :controller do
  describe '#index' do
    let(:unix_time) { REDIS.time.first }
    let(:from) { unix_time }
    let(:to) { unix_time + 500 }

    before(:example) do
      post :create, params: { domain: { links: ['http://diji.com', 'goverment.ru', 'http://funbox.ru/search&t=hello', 'funbox.ru'] } }
    end

    it 'response status will be 200' do
      get :index, params: { from: from, to: to }
      expect(response.status).to eq 200
    end

    it 'responds to json by default' do
      get :index, params: { from: from, to: to }
      expect(response.media_type).to eq 'application/json'
    end

    it 'returns unique domains without scheme and paths' do
      expected = {
        domains: ['diji.com', 'funbox.ru', 'goverment.ru'], status: :ok
      }.to_json

      get :index, params: { from: from, to: to }
      expect(response.body).to eq expected
    end

    it 'returns error with wrong params' do
      expected = {
        status: :error,
        message: 'Domains not found. Please try again with other time range!'
      }.to_json

      get :index, params: { from: from }
      expect(response.body).to eq expected
    end
  end

  describe '#create' do
    it 'returns status ok' do
      expected = {
        status: :ok
      }.to_json

      post :create, params: { domain: { links: ['http://diji.com', 'goverment.ru'] } }
      expect(response.body).to eq expected
    end

    it 'returns status error' do
      expected = {
        status: :error,
        message: "You sent an invalid value!"
      }.to_json

      post :create, params: { domain: { links: ['some_host_without_dot_com', 'goverment.ru'] } }
      expect(response.body).to eq expected
    end
  end
end
