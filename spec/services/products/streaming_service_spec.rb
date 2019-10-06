require 'rails_helper'

describe Products::StreamingService do
  describe "#process" do
    subject { Products::StreamingService.new(payload).process }

    context "payload is valid" do
      let(:payload) { { "store" => "store", "model" => "model", "inventory" => 2 } }

      context "product is new" do
        it "creates product quantity" do
          expect do
            subject
          end.to change(Product, :count).by(+1)
        end

        it "broadcasts the product to the channel" do
          expect(ActionCable.server).to receive(:broadcast).with("shop_channel", anything)
          subject
        end
      end

      context "product already exist" do
        # Use factorybot to handle model generation
        let!(:product) { Product.create(store: "store", model: "model", quantity: 1) }

        it "updates product quantity" do
          expect do
            subject
            product.reload
          end.to change(product, :quantity).from(1).to(2)
        end

        it "broadcasts the product to the channel" do
          expect(ActionCable.server).to receive(:broadcast).with("shop_channel", anything)
          subject
        end
      end
    end

    context "payload is invalid" do
      let(:payload) { { store: "store", model: "model" } }

      it "logs an error" do
        expect(Rails.logger).to receive(:error).with(anything)

        subject
      end
    end
  end
end
