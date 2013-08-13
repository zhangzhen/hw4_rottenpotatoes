require 'spec_helper'

describe Movie do
  describe 'finding movies with same director' do
    it 'should call the movie method that finds all movies by director' do
      m = FactoryGirl.build(:movie, :title => 'Star Wars', :rating => 'PG', :director => 'George Lucas')
      Movie.should_receive(:find_all_by_director).with('George Lucas')
      m.find_with_same_director
    end
  end
end
