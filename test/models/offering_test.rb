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

  test "validity when saving new Offering" do
    o = newValidOffering
    assert o.valid?

    o = newValidOffering
    o.professor= nil
    assert_not o.valid?

    o = newValidOffering
    o.time= nil
    assert_not o.valid?

    o = newValidOffering
    o.capacity= nil
    assert_not o.valid?

    o = newValidOffering
    o.semester= nil
    assert_not o.valid?

    o = newValidOffering
    o.course= nil
    assert_not o.valid?

  end

  def newValidOffering
    o = Offering.new
    o.professor= "Professor"
    o.time= "time"
    o.capacity= 1
    o.course_id= 1
    o.semester_id= 1
    return o
  end

end
