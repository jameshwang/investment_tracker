require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @user.password = "foobar"
    @user.password_confirmation = "foobar"
  end

  test "user should respond to" do
    assert @user.respond_to?(:name)
    assert @user.respond_to?(:email)
    assert @user.respond_to?(:password_digest)
    assert @user.respond_to?(:password)
    assert @user.respond_to?(:password_confirmation)
  end

  test "user name must be present" do
    assert @user.valid?
    @user.name = ""
    refute @user.valid?
  end

  test "user email must be present" do
    assert @user.valid?
    @user.email = ""
    refute @user.valid?
  end

  test "user email must be a valid email" do
    @user.email = "adf@asdf"
    refute @user.valid?, "#{@user.email} should not be valid"
    @user.email = "fd@dsf."
    refute @user.valid?, "#{@user.email} should not be valid"
    @user.email = "df@f.c"
    assert @user.valid?, "#{@user.email} should be valid"
  end

  test "user email must be unique" do
    @user.save!
    @user2 = User.new(name: "uesr2", email: @user.email)
    refute @user2.valid?, "emails must be unique"
    @user2.email.upcase!
    refute @user2.valid?, "emails must be unique and case insensitive"
  end

  test "user must have a portfolio" do

  end
end
