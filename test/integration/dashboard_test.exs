defmodule SherlockBoard.DashboardTest do
  use SherlockBoard.IntegrationCase

  test "there is a set of six boxes" do
    navigate_to("/foo")
    assert length(find_all_elements(:css, "div.box")) == 6
  end

  test "there is a box with data set by backend" do
    navigate_to("/foo")
    assert visible_in_element?({:css, "div.box#one"}, ~r/foobar/)
  end
end

