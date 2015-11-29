require "./src/server/uri_parser.rb"

describe "uri parser" do

  it "parses the damn thing" do
    expect(UriParser.parser("GET /welcome?first=Chase&last=Rogers HTTP/1.1")).to eq({first: "Chase", last: "Rogers"})
  end

end