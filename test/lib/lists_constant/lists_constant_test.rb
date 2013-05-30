require_relative '../../test_helper'

class Lister

  attr_accessor :color

  def initialize(color)
    @color = color
  end
end

describe ListsConstant do
  before do
    I18n.locale = :en
    Lister.send :include, ListsConstant
  end

  it "requires a name for the constant list" do
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

      it "localizes the variable description" do
        listed = Lister.new(:red)
        assert_equal listed.localized_color, @translations[:red]
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
end
