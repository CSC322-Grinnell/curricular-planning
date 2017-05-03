require 'test_helper'

class OfferingTest < ActiveSupport::TestCase
  test "count of fixtures" do
    assert_equal 6, Offering.count # loaded from fixtures
  end

  test "validity of fixtures" do
    offerings = Offering.all
    offerings.each do |o|
      assert o.valid?
    end
  end

  test "validity when a field is missing" do
    o = getValidOffering
    assert o.valid?

    o = getValidOffering
    o.professor= nil
    assert_not o.valid?

    o = getValidOffering
    o.section = nil
    assert_not o.valid?

    o = getValidOffering
    o.time= nil
    assert_not o.valid?

    o = getValidOffering
    o.capacity= nil
    assert_not o.valid?

    o = getValidOffering
    o.semester= nil
    assert_not o.valid?

    o = getValidOffering
    o.course= nil
    assert_not o.valid?

  end

  def getValidOffering
    Offering.all[0]
  end

end
