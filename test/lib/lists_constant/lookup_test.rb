require_relative '../../test_helper'

describe ListsConstant::Lookup do
  before do
    @colors = [:red, :blue, :yellow]
    ListsConstant::Lookup.new(Lister, 'colors', @colors)
  end

  it "adds instance query methods for each value" do
    listed = Lister.new(:red)

    assert listed.color_red?
    refute listed.color_yellow?
    refute listed.color_blue?
  end

  describe "given I18n translations" do
    before do
      @translations = {
        red: 'rojo',
        blue: 'azul',
        yellow: 'amarillo'
      }

      I18n.backend.store_translations :es, {
        lister: {
          colors: @translations
        }
      }

      I18n.locale = :es
    end

    it "localizes the variable description" do
      listed = Lister.new(:red)
      assert_equal listed.localized_color, @translations[:red]
    end
  end
end
