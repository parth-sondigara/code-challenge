require 'rails_helper'

RSpec.describe "Orders API", type: :request do
  let!(:product) { create(:product) }
  let(:valid_attributes) do
    {
      product_id: product.id,
      quantity: 2,
      name: "John Doe",
      email: "johndoe@example.com"
    }
  end

  describe "POST /orders" do
    context "when user name is missing" do
      it "returns an error" do
        post "/orders", params: valid_attributes.except(:name), as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["message"]).to eq("User creation failed")
      end
    end

    context "when user email is missing" do
      it "returns an error" do
        post "/orders", params: valid_attributes.except(:email), as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["message"]).to eq("User creation failed")
      end
    end

    context "when request is valid" do
      it "creates an order and returns success" do
        post "/orders", params: valid_attributes, as: :json

        expect(response).to have_http_status(:created)
        expect(json["message"]).to eq("Order placed successfully")
        expect(json["data"]["attributes"]["product"]["name"]).to eq(product.name)
        expect(json["data"]["attributes"]["quantity"]).to eq(2)
      end
    end

    context "when product does not exist" do
      it "returns not found error" do
        post "/orders", params: valid_attributes.merge(product_id: 999, quantity: 2), as: :json

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json["message"]).to eq("Something went wrong.")
        expect(json["errors"]).to eq("Couldn't find Product with 'id'=999")
      end
    end
  end
end
