class SubscriptionsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    Subscription.create(phone_number: params[:phone_number])
  end
end
