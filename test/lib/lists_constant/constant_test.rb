require_relative '../../test_helper'

describe ListsConstant::Constant do
  before do
    @colors = [:red, :blue, :yellow]
    ListsConstant::Constant.new(Lister, 'colors', @colors)
  end

  after do
    Lister.send :remove_const, 'COLORS'
  end

  it "adds the constant to the includer" do
    assert_equal Lister::COLORS, @colors
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

    it "generates an inverted hash for option helpers" do
      assert_equal Lister.color_options, {
        @translations[:red] => :red,
        @translations[:blue] => :blue,
        @translations[:yellow] => :yellow
      }
    end

    describe "with a namespace" do
      before do
        ListsConstant.namespace = :mistranslations

        @mistranslations = {
          red: 'sangriento',
          blue: 'morado',
          yellow: 'gallina'
        }

        I18n.backend.store_translations :es, {
          mistranslations: {
            lister: {
              colors: @mistranslations
            }
          }
        }
      end

      after do
        ListsConstant.namespace = nil
      end

      it "scopes within the namespace for localization" do
        assert_equal Lister.colors, {
          red: @mistranslations[:red],
          blue: @mistranslations[:blue],
          yellow: @mistranslations[:yellow]
        }
      end
    end
  end
end
