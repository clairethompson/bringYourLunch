class SubscriptionsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    puts '********************** in create'
    puts params[:phone_number]
  end
end
