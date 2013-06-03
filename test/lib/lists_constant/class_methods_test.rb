require_relative '../../test_helper'

describe ListsConstant::ClassMethods do
  before do
    Lister.send :extend, ListsConstant::ClassMethods
  end

  it "requires a name for a list constant" do
    assert_raises ArgumentError do
      Lister.lists_constant :red, :blue, :yellow
    end
  end

  describe "creating a constant list" do
    before do
      Lister.lists_constant :red,
        :blue,
        :yellow,
        as: :colors
    end

    after do
      Lister.send :remove_const, 'COLORS'
    end

    it "adds the constant to the includer" do
      assert_equal Lister::COLORS, [:red, :blue, :yellow]
    end
  end
end
