require "./server/uri_parser.rb"

describe "uri parser" do

  it "parses params" do
    expect(UriParser.parse_params("GET /welcome?first=Chase&last=Rogers HTTP/1.1")).to eq({"first" => ["Chase"], "last" => ["Rogers"]})
  end

end