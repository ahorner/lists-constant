require_relative '../../test_helper'

describe ListsConstant::Lookup do
  before do
    @lookup = ListsConstant::Lookup.new(Lister, 'colors')
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
      assert_equal @lookup.lookup(:red), @translations[:red]
      assert_equal @lookup.lookup(:blue), @translations[:blue]
      assert_equal @lookup.lookup(:yellow), @translations[:yellow]
    end
  end

  describe "with a specified namespace" do
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

    it "scopes within the lookup for localization" do
      assert_equal @lookup.lookup(:red), @mistranslations[:red]
      assert_equal @lookup.lookup(:blue), @mistranslations[:blue]
      assert_equal @lookup.lookup(:yellow), @mistranslations[:yellow]
    end
  end


end
