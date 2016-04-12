class ChargesController < ApplicationController
  before_action :authenticate_user!
  # after_action current_user.add_role :premium, only: :create

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
    charge = Stripe::Charge.create(
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

end
