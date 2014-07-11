require 'spec_helper'

describe RoundsController do
  let(:user) { create :user }
  let(:game) { create :game }
  describe 'POST #create_drawing' do
    let(:svg) { "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?><!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" version=\"1.1\" width=\"500\" height=\"500\" style=\"background-color: #fff\" xml:space=\"preserve\"><desc>Created with Fabric.js 1.4.6</desc><defs></defs><g transform=\"translate(201.25 132)\"><path d=\"M 0 4 Q 0 4 0.5 4 Q 1 4 1.25 4 Q 1.5 4 3 4 Q 4.5 4 5.5 3.5 Q 6.5 3 7.5 3 Q 8.5 3 10.5 2 Q 12.5 1 14 1 Q 15.5 1 16.5 0.5 Q 17.5 0 18.5 0 Q 19.5 0 20 0 Q 20.5 0 21 0 Q 21.5 0 21.5 0 L 21.5 0\" style=\"stroke: #000; stroke-width: 10; stroke-dasharray: ; stroke-linecap: round; stroke-linejoin: round; stroke-miterlimit: 10; fill: none; opacity: 1;\" transform=\"translate(-10.5 -2)\" stroke-linecap=\"round\" /></g></svg>" }
    context "drawing is an addition to existing game" do
      it "creates a new round in the game"
      it "does not create a new game"
      it "redirects to the home page"
    end
    context "drawing is the first of a new game" do
      it "creates a new game in the database" do
        expect{
          post :create_drawing, svg: svg
        }.to change(Game, :count).by(1)
      end
      it "creates a new round in the database" do
        expect{
          post :create_drawing, svg: svg
        }.to change(Round, :count).by(1)
      end
      it "redirects to the home page" do
        post :create_drawing, svg: svg
        expect(response).to redirect_to root_path
      end
    end
  end
end
