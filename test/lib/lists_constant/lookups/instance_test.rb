require_relative '../../../test_helper'

describe ListsConstant::Lookups::Instance do
  before do
    I18n.locale = :en

    @colors = [:red, :blue, :yellow]
    Lister.send :include, ListsConstant::Lookups::Instance.new('colors', @colors)
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
