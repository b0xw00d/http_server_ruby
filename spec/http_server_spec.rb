require "./src/server/server_setup.rb"
require 'date'

describe "our http server" do

  it "returns the proper headers" do
    expect(ServerSetup.response_headers(200, "hello")).to be_a(Array)
  end

  it "return all headers as strings" do
    expect(ServerSetup.response_headers(200, "hello").all? {|header| header.is_a? String}).to eq(true)
  end

  it "should return the proper html for faulty URIs" do
    response = "you cant do that"
    expect(ServerSetup.response_headers(404, response).last).to eq("you cant do that")
  end

  it "should return the proper html for succesful page visits" do
    response = "success!"
    expect(ServerSetup.response_headers(200, response).last).to eq("success!")
  end

end