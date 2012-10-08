# encoding : utf-8
require 'test_helper'

module Redirector
  class RedirectPathTest < ActiveSupport::TestCase

    test "build_url" do

    end

    test "base_with_landing_page" do
    end

    test "extract host from url with curly brackets" do
      path = RedirectPath.new(base: "http://ads.example.com/track?keyword={keyword}")
      assert_equal "ads.example.com", path.host
    end

    test "parse string to regexp" do
      rule = "*.example.com"
      pattern = RedirectPath.new.parse_to_regexp(rule)
      expected = Regexp.new(/^.*?\.example\.com$/i)
      assert_equal expected, pattern
    end

    test "ignore_encoding?" do
    end

    test "try_escape_url" do
    end

  end
end