require "test_helper"

describe Classroom do
  let(:classroom) { Classroom.new }

  it "must be valid" do
    value(classroom).must_be :valid?
  end
end
