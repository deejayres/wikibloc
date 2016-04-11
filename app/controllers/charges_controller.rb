class ChargesController < ApplicationController

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 15_00,
      description: "Premium Wikibloc Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thank you for becoming a premium Wikibloc member! You may now create private wikis!"
    redirect_to wikis_path

    rescue Stipe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Wikibloc Membership - #{current_user.username}",
      amount: 15_00
    }
  end

end
