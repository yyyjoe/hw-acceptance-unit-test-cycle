#- spec/controllers/movies_controller_spec.rb
require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  # the following line was commented because there are view tests
  #render_views  
  
  before :each do
    movies = [{:title => 'Star Wars', :rating => 'PG',
  	           :director => 'George Lucas', :release_date => '1977-05-25'},
    	        {:title => 'Alien', :rating => 'PG', 
  	           :director => '', :release_date => '1977-05-25'},
  	 ]

    @movies = movies.map { |movie| Movie.create movie } 
  end
  
  describe "GET #show" do
    subject { get :show, id: @movies[0] }
    
    it "assigns the requested movies[0] to @movie" do 
      get :show, id: @movies[0]
      assigns(:movie).should eq @movies[0]
    end
    
    it "renders the show template" do
      expect(subject).to render_template :show
      expect(subject).to render_template "show" 
    end
  end
  
  
  describe "GET #new" do
    subject { get :new }
    
    it "renders the new template" do
      expect(subject).to render_template :new
      expect(subject).to render_template "new" 
    end
  end
  
  
  
  describe "GET #edit" do
    subject { get :edit, id: @movies[1] }
    
    it "assigns the requested movies[1] to @movie" do 
      get :edit, id: @movies[1]
      assigns(:movie).should eq @movies[1]
    end
    
    it "renders the show template" do
      expect(subject).to render_template :edit
      expect(subject).to render_template "edit" 
    end
  end
  
  describe "PUT #update" do
    context "valid attributes" do 
      it "located the requested @movie" do 
        put :update, id: @movies[1], movie: @movies[1].attributes
        assigns(:movie).should eq @movies[1]
      end 
      
      it "changes @movie's attributes" do 
        put :update, id: @movies[1], movie: @movies[1].attributes = { director: 'Ridley Scott' }
        @movies[1].reload 
        @movies[1].director.should eq "Ridley Scott"
      end 
      
      it "redirects to the /movies/id after updated" do 
        put :update, id: @movies[1], movie: @movies[1].attributes
          response.should redirect_to movie_path @movies[1]
      end 
      
      it "shows a correct message after updated" do
        put :update, id: @movies[1], movie: @movies[1].attributes
        flash[:notice].should =~ /#{@movies[1].title} was successfully updated./i
      end
    end
    
=begin
    TODO: there are not validations, skipped this case
    context "with invalid attributes" do
    end
=end
  end
  
  describe "DELETE #destroy" do
    it "deletes the movie" do 
      expect{ 
        delete :destroy, id: @movies[1]
        }.to change(Movie,:count).by(-1) 
    end 
    
    it "redirects to movies#index" do 
      delete :destroy, id: @movies[1] 
      response.should redirect_to :movies
    end
    
    it "shows a correct message after deleted" do
      delete :destroy, id: @movies[1], movie: @movies[1].attributes
      flash[:notice].should =~ /Movie '#{@movies[1].title}' deleted./i
    end
  end

end