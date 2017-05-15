import SherlockBoard.Job

job :HtmlJob, 2 do
  send_html("html","<p>Hello World</p>")
end
