require 'spec_helper'

describe Roar do
  describe "#usable?" do
    it "should be usable" do
      Roar.usable?.should eq true
    end
  end

  describe "#notify" do
    it "should notify.." do
      Roar.notify "Roar!", "Can you see my tongue?!"
      sleep 2
      Roar.success "Yeah if this works!"
      sleep 2
      Roar.error "Did something go wrong?!?"
    end
  end
end
