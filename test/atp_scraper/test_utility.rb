require 'test_helper'

class TestActivity < Test::Unit::TestCase
  test "Normal score case" do
    expected = "76(3) 67(10) 64"
    actual = AtpScraper::Utility.convert_score("763 6710 64")
    assert_equal(actual, expected)
  end

  test "Final set score is 76 or 67" do
    expected1 = "76(3) 67(4) 64 36 76-74"
    actual1 = AtpScraper::Utility.convert_score("763 674 64 36 76-74")
    assert_equal(actual1, expected1)

    expected2 = "76(3) 67(4) 64 36 67-65"
    actual2 = AtpScraper::Utility.convert_score("763 674 64 36 67-65")
    assert_equal(actual2, expected2)
  end

  test "Without tie-break sub score" do
    expected = "76 67 64"
    actual = AtpScraper::Utility.convert_score("76 67 64")
    assert_equal(actual, expected)
  end
end
