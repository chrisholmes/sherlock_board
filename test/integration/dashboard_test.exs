defmodule SherlockBoard.DashboardTest do
  use SherlockBoard.IntegrationCase

  test "there is a set of six boxes" do
    navigate_to("/foo")
    assert length(find_all_elements(:css, "div.box")) == 2
  end

  test "there are boxes with data set by backend jobs" do
    navigate_to("/foo")
    wait_until fn ->
      assert visible_in_element?({:css, "div.box div.html"}, ~r/Hello World/)
    end
    wait_until fn ->
      assert visible_in_element?({:css, "div.box div.number-widget"}, ~r/bar/)
    end
  end
end

