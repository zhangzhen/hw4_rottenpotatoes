# -*- coding: utf-8 -*-
require 'spec_helper'

describe MoviesController do
  describe 'Searching for similar movies' do
    before :each do
      @fake_m = mock('movie')
      @fake_m.stub(:director).and_return('Lucas')
      @fake_results = [mock('movie1'), mock('movie2')]
    end
    it 'should call the model method that retrieves the current movie' do
      Movie.should_receive(:find).with('1').and_return(@fake_m)
      @fake_m.stub(:find_with_same_director).and_return(@fake_results)
      get :search_for_similar_movies, :id => 1
    end
    it 'should call the model method that performs similar movies search' do
      Movie.stub(:find).and_return(@fake_m)
      @fake_m.should_receive(:find_with_same_director).
        and_return(@fake_results)
      get :search_for_similar_movies, :id => 1
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find).and_return(@fake_m)
        @fake_m.stub(:find_with_same_director).and_return(@fake_results)
        get :search_for_similar_movies, :id => 1
      end
      it 'should select the Search Results template for rendering' do
        response.should render_template('search_for_similar_movies')
      end
      it 'should make the TMDb search results available to that template' do
        assigns(:movies).should == @fake_results
      end
    end
    it 'should redirect to the home page if a movie has no director info' do
      Movie.stub(:find).and_return(@fake_m)
      @fake_m.stub(:director).and_return('')
      @fake_m.stub(:title).and_return('Alien')
      get :search_for_similar_movies, :id => 1
      response.should redirect_to(movies_path)
    end
  end
end
