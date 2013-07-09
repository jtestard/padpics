require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  def setup
    @user = User.create({:username=>'julestestard',:email=>'jules.testard@gmail.com',:password=>'1234',:password_confirmation=>'1234'})
  end
  
  def teardown
    @user.destroy
  end
  
  test "the truth" do
    assert true
  end
  
  test "user exists" do
    assert_equal "julestestard", @user.username
    assert_equal "jules.testard@gmail.com", @user.email
  end
  
  test "upload from url" do
    #@picture = @user.pictures.create(:image_url => "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-prn2/988906_10151580667828022_177671941_n.jpg")
    #@picture = @user.pictures.create(:image_url => "http://eofdreams.com/data_images/dreams/cat/cat-07.jpg")
    @picture = Picture.new(:image_url => "http://eofdreams.com/data_images/dreams/cat/cat-07.jpg")
    @picture.user_id = @user.id
    @picture.save
    puts @picture.inspect
  end
end
