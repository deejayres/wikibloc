class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_if_premium

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Premium Wikibloc Membership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.add_role :premium
    flash[:notice] = "Thank you for becoming a premium Wikibloc member! You may now create private wikis!"
    redirect_to wikis_path

    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Wikibloc Membership - #{current_user.username}",
      amount: Amount.default
    }
  end

  private

  def check_if_premium
    if current_user.is_premium?
      flash[:notice] = "You are already a premium member!"
      redirect_to wikis_path
    end
  end

end
