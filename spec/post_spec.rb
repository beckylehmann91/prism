require "rails_helper"
require "spec_helper"

describe Post do
  it 'has a title' do
    post = Post.create(title: "Things")
    expect(post.title).to eq("Things")
  end
end

# describe Image do
#   it "has a height" do
#     image = Image.create(height: 540, width: 540)
#     expect(image.height).to eq(540)
#   end

#   it "has a filename" do
#     image = Image.create(filename: "the/file/location")
#     expect(image.filename).to eq("the/file/location")
#   end
# end
