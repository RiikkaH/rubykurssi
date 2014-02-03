require 'spec_helper'


describe User do

  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username:"Pekka", password:"ab1", password_confirmation:"ab1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with password that contains only letters" do
    user = User.create username:"Pekka", password:"Abcdefg", password_confirmation:"Abcdefg"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(10, user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_style
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the style of the only rated beer if only one rating" do
      beer=create_beer_with_rating(10, user)

      expect(user.favorite_style).to eq(beer.style)
    end

    it "is the style that has highest average rating" do
      beer1 = FactoryGirl.create(:beer, style:"Lager")
      beer2 = FactoryGirl.create(:beer, style:"Porter")
      beer3 = FactoryGirl.create(:beer, style:"Porter")
      rating1 = FactoryGirl.create(:rating, score:11, beer:beer1, user:user)
      rating2 = FactoryGirl.create(:rating, score:30, beer:beer2, user:user)
      rating3 = FactoryGirl.create(:rating, score:10, beer:beer3, user:user)

      expect(user.favorite_style).to eq("Porter")
    end
  end

describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_brewery
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the brewery of the only rated beer if only one rating" do
      beer=create_beer_with_rating(10, user)

      expect(user.favorite_brewery).to eq(beer.brewery)
    end

    it "is the brewery that has highest average rating" do
      beer1 = FactoryGirl.create(:beer, brewery:"Panimo1")
      beer2 = FactoryGirl.create(:beer, brewery:"Panimo2")
      beer3 = FactoryGirl.create(:beer, brewery:"Panimo2")
      rating1 = FactoryGirl.create(:rating, score:11, beer:beer1, user:user)
      rating2 = FactoryGirl.create(:rating, score:30, beer:beer2, user:user)
      rating3 = FactoryGirl.create(:rating, score:10, beer:beer3, user:user)

      expect(user.favorite_brewery).to eq("Panimo2")
    end
  end

end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end
