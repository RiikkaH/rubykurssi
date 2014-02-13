require 'spec_helper'


describe "Beer" do
  let!(:style) { FactoryGirl.create :style }
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "creating works if name is valid" do
    visit new_beer_path

    fill_in('beer[name]', with:"uusiolut")
    select('Koff', from:'beer[brewery_id]')
    select('Lager', from:'beer[style_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "when name is not valid, beer won't be saved and the page shows a message" do
    visit new_beer_path

    fill_in('beer[name]', with:"")
    select('Koff', from:'beer[brewery_id]')
    select('Lager', from:'beer[style_id]')

    click_button "Create Beer"

    expect(page).to have_content 'New beer'
    expect(Beer.count).to eq(0)
    expect(page).to have_content '1 error prohibited this beer from being saved:'
  end

end
