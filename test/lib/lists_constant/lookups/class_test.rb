require_relative '../../../test_helper'

describe ListsConstant::Lookups::Class do
  before do
    I18n.locale = :en

    @colors = [:red, :blue, :yellow]
    Lister.const_set 'COLORS', @colors
    Lister.extend ListsConstant::Lookups::Class.new('colors', @colors)
  end

  after do
    Lister.send :remove_const, 'COLORS'
  end

  it "determines if a passed value is available" do
    assert Lister.includes_color?(:red)
    assert Lister.includes_color?('blue')
    refute Lister.includes_color?(:magenta)
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

    it "generates a hash of the localized names with their values" do
      assert_equal Lister.colors, {
        red: @translations[:red],
        blue: @translations[:blue],
        yellow: @translations[:yellow]
      }
    end

    it "localizes passed values" do
      assert_equal Lister.localized_color(:red), @translations[:red]
      assert_equal Lister.localized_color('blue'), @translations[:blue]
      assert_equal Lister.localized_color(:magenta), nil
    end

    it "generates an inverted hash for option helpers" do
      assert_equal Lister.color_options, {
        @translations[:red] => :red,
        @translations[:blue] => :blue,
        @translations[:yellow] => :yellow
      }
    end
  end
end
