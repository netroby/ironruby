require File.dirname(__FILE__) + '/../../spec_helper'
require File.dirname(__FILE__) + '/fixtures/classes'

describe "Module#extended" do
  it "is called when an object gets extended with self" do
    begin
      m = Module.new do
        def self.extended(o)
          $extended_object = o
        end
      end
      
      (o = mock('x')).extend(m)
      
      $extended_object.should == o
    ensure
      $extended_object = nil
    end
  end
  
  it "is called after Module#extend_object" do
    begin
      m = Module.new do
        def self.extend_object(o)
          $extended_object = nil
        end
        
        def self.extended(o)
          $extended_object = o
        end
      end
      
      (o = mock('x')).extend(m)
      
      $extended_object.should == o
    ensure
      $extended_object = nil
    end
  end

  ruby_version_is ""..."1.9" do
    it "is private in its default implementation" do
      Module.new.private_methods.should include("extended")
    end
  end

  ruby_version_is "1.9" do
    it "is private in its default implementation" do
      Module.new.private_methods.should include(:extended)
    end
  end
end
