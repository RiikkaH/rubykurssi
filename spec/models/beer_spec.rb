require 'spec_helper'

describe Beer do

  it "is saved when it has name and style" do
    beer= Beer.create name:"olut", style:"tyyli"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved when name is not valid" do
    beer= Beer.create name:"", style:"tyyli"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved when it doesn't have style" do
    beer= Beer.create name:"olut"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

end
