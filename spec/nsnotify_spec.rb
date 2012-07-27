require 'spec_helper'

describe Nsnotify do
  describe "#usable?" do
    it "should be usable" do
      Nsnotify.usable?.should eq true
    end
  end

  describe "#notify" do
    it "should notify.." do
      Nsnotify.notify "Nsnotify!", "Can you see my tongue?!"
      sleep 2
      Nsnotify.success "Yeah if this works!"
      sleep 2
      Nsnotify.error "Did something go wrong?!?"
    end
  end
end
