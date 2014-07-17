require 'spec_helper'

describe RoundsController do
  let(:user) { create :user }
  #for some reason, let(:user2){create :user} leads to a 'username already exists' error
  let(:user2) { User.create(username: "Pei", password: "yolo") }
  let(:game) { Game.create(user_id: user.id) }


  describe 'GET #new' do
    before(:each) do
      Round.create( game_id: game.id,
                    user_id: user2.id,
                    content: "content",
                    content_type: "description")
    end

    context "user is logged in" do
      before(:each) do
        session[:user_id] = user.id
      end
      it "sets @game to the selected game" do
        get :new, game_id: game.id
        expect(assigns(:game)).to eq game
      end

      context "user played the game's last round" do
        it "redirects to the root path" do
          Round.create( game_id: game.id,
                        user_id: user.id,
                        content: "content",
                        content_type: "drawing")
          get :new, game_id: game.id
          expect(response).to redirect_to root_path
        end
      end

      context "user did not play the game's last round" do
        it "sets @last_round to the last round of the selected game" do
          get :new, game_id: game.id
          expect(assigns(:last_round)).to eq game.rounds.last
        end
        it "sets session[:game_id] to the selected game's id" do
          get :new, game_id: game.id
          expect(session[:game_id]).to eq game.id
        end
        it "renders new_description_to_game template if last round was a drawing" do
          Round.create( game_id: game.id,
                        user_id: user2.id,
                        content: "content",
                        content_type: "drawing")
          get :new, game_id: game.id
          expect(response).to render_template :new_description_to_game
        end
        it "renders new_drawing_to_game template if last round was a description" do
          Round.create( game_id: game.id,
                        user_id: user2.id,
                        content: "content",
                        content_type: "description")
          get :new, game_id: game.id
          expect(response).to render_template :new_drawing_to_game
        end
      end
    end

    context "user is not logged in" do
      it "redirects to the root path" do
        get :new, game_id: game.id
        expect(response).to redirect_to root_path
      end
    end
  end


  describe 'POST #create_drawing' do
    let(:svg) { "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?><!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" version=\"1.1\" width=\"500\" height=\"500\" style=\"background-color: #fff\" xml:space=\"preserve\"><desc>Created with Fabric.js 1.4.6</desc><defs></defs><g transform=\"translate(201.25 132)\"><path d=\"M 0 4 Q 0 4 0.5 4 Q 1 4 1.25 4 Q 1.5 4 3 4 Q 4.5 4 5.5 3.5 Q 6.5 3 7.5 3 Q 8.5 3 10.5 2 Q 12.5 1 14 1 Q 15.5 1 16.5 0.5 Q 17.5 0 18.5 0 Q 19.5 0 20 0 Q 20.5 0 21 0 Q 21.5 0 21.5 0 L 21.5 0\" style=\"stroke: #000; stroke-width: 10; stroke-dasharray: ; stroke-linecap: round; stroke-linejoin: round; stroke-miterlimit: 10; fill: none; opacity: 1;\" transform=\"translate(-10.5 -2)\" stroke-linecap=\"round\" /></g></svg>" }

    context "drawing is an addition to existing game" do
      before(:each) do
        session[:game_id] = game.id
      end
      it "creates a new round in the game" do
        expect{
          post :create_drawing, svg: svg
        }.to change(game.rounds, :count).by(1)
      end
      it "does not create a new game" do
        expect {
          post :create_drawing, svg: svg
        }.to_not change(Game, :count)
      end
      it "redirects to the home page" do
        post :create_drawing, svg: svg
        expect(response).to redirect_to root_path
      end
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


  describe 'POST #create_description' do
    let(:description) { "Winter is coming."}

    context "drawing is an addition to existing game" do
      before(:each) do
        session[:game_id] = game.id
      end
      it "creates a new round in the game" do
        expect{
          post :create_description, description: description
        }.to change(game.rounds, :count).by(1)
      end
      it "does not create a new game" do
        expect {
          post :create_description, description: description
        }.to_not change(Game, :count)
      end
      it "redirects to the home page" do
        post :create_description, description: description
        expect(response).to redirect_to root_path
      end
    end

    context "drawing is the first of a new game" do
      it "creates a new game in the database" do
        expect{
          post :create_description, description: description
        }.to change(Game, :count).by(1)
      end
      it "creates a new round in the database" do
        expect{
          post :create_description, description: description
        }.to change(Round, :count).by(1)
      end
      it "redirects to the home page" do
        post :create_description, description: description
        expect(response).to redirect_to root_path
      end
    end
  end

end
