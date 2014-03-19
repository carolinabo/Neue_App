require 'spec_helper'

describe "Resource pages" do

  subject { page }

  describe "index" do

  let(:user) { FactoryGirl.create(:user) }

    before do
      sign_in user
      visit resources_path
    end

    it { should have_selector('title', text: 'All resources') }
    it { should have_selector('h1',    text: 'All resources') }

 #   it 'list resources' do
 #     assign(:resource, Ressource.create(name: 'Nagel', capacity: 25))
 #
 #     render
 #
 #     rendered.should contain('Nagel')
 #     rendered.should contain(25)
  #  end




  end


  end
