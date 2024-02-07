require "test_helper"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
    log_in @user
  end

  test "can create a listing" do
    assert_difference "Listing.count", 1 do
      post listings_path, params: {
        listing: {
          title: Faker::Commerce.product_name,
          cover_photo: fixture_file_upload("test-image-1.jpg"),
          price: Faker::Commerce.price.floor,
          condition: "mint",
          tags: Faker::Commerce.send(:categories, 3),
          description: Faker::Lorem.paragraphs(number: 4).map { "<p>#{_1}</p>"}.join,
          address_attributes: {
            line_1: Faker::Address.building_number,
            line_2: Faker::Address.street_address,
            city: Faker::Address.city,
            postcode: Faker::Address.postcode,
            country: "GB"
          }
        }
      }
    end

    assert_redirected_to listing_path(Listing.last)
    assert Listing.last.published?
  end

  test "error when creating an invalid listing" do
    assert_no_difference "Listing.count" do
      post listings_path, params: {
        listing: {
          title: "title",
          price: 300,
          condition: "mint"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "p.is-danger"
    assert_select "label[for='listing_tags'] ~ p.is-danger"
    assert_select "trix-editor ~ p.is-danger"
  end

  test "can update a listing" do
    @listing = listings(:auto_listing_1_jerry)

    new_title = Faker::Commerce.product_name

    patch listing_path(@listing), params: {
      listing: {
        title: new_title,
        price: @listing.price
      }
    }

    assert_redirected_to listing_path(@listing)
    assert_equal new_title, @listing.reload.title
  end

  test "updating a draft listing publishes it" do
    @listing = listings(:auto_listing_1_jerry)
    @listing.draft!

    patch listing_path(@listing)

    assert_redirected_to listing_path(@listing)
    assert @listing.reload.published?
  end


  test "error when updating a listing with invalid data" do
    @listing = listings(:auto_listing_1_jerry)

    patch listing_path(@listing), params: {
      listing: {
        title: @listing.title,
        price: "NaN"
      }
    }

    assert_response :unprocessable_entity
  end

  test "can delete a listing" do
    @listing = listings(:auto_listing_1_jerry)

    assert_difference "Listing.count", -1 do
      delete listing_path(@listing)
    end

    assert_redirected_to my_listings_path
  end
end
