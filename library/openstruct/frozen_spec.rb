require File.dirname(__FILE__) + '/../../spec_helper'
require 'ostruct'

describe "OpenStruct.new when frozen" do
  before :each do
    @os = OpenStruct.new(:name => "John Smith", :age => 70, :pension => 300).freeze
  end
  #
  # method_missing case handled in method_missing_spec.rb
  #
  it "shall still be readable" do
    @os.age.should eql(70)
    @os.pension.should eql(300)
    @os.name.should == "John Smith"
  end
  it "shall not be writeable" do
    lambda{ @os.age = 42 }.should raise_error( TypeError )
  end
  if "shall not create new fields" do
    lambda{ @os.state = :new }.should raise_error( TypeError )
  end
  it "shall create a frozen clone" do
    f = @os.clone
    f.age.should == 70
    lambda{ f.age = 0 }.should raise_error( TypeError )
    lambda{ f.state = :newer }.should raise_error( TypeError )
  end
  it "shall create an unfrozen dup" do
    d = @os.dup
    d.age.should == 70
    d.age = 42
    d.age.should == 42
  end

end

