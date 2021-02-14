# frozen_string_literal: true

class DomainsController < ApplicationController
  def index
    domains = DomainReader.call(find_params[:from], find_params[:to])

    response = if domains.nil? || domains.empty?
                 { status: :error, message: 'Domains not found. Please try again with other time range!' }
               else
                 { domains: domains, status: :ok }
               end

    render json: response
  end

  def create
    domains = DomainValidator.call(create_params[:links])

    DomainCreator.call(domains) unless domains.nil?

    response = if domains.nil?
                 { status: :error, message: 'You sent an invalid value!' }
               else
                 { status: :ok }
               end

    render json: response
  end

  private
  def create_params
    params.require(:domain).permit(links: [])
  end

  def find_params
    params.permit(:from, :to)
  end
end
