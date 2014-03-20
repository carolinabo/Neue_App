require 'spec_helper'

describe Resource do

  before { @resource = Resource.new(name: "Schrauben eindrehen", capacity: "25") }

  subject { @resource }

  it { should respond_to(:name) }
  it { should respond_to(:capacity) }

  it { should be_valid }

  it "capacity is positive" do
    resource = Resource.new
    resource.capacity.should > 0
  end

  describe "when name is not present" do
    before { @resource.name = " " }
    it { should_not be_valid }
  end

  describe "when capacity is not present" do
    before { @resource.capacity = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @resource.name = "a" * 51}
    it { should_not be_valid }
  end

  describe "when name is already taken" do
    before do
      resource_with_same_name = @resource.dup
      resource_with_same_name.save
    end
    it { should_not be_valid }
  end

end