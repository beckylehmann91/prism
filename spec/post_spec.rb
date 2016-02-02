require "rails_helper"
require "spec_helper"

describe Post do
  it 'has a title' do
    post = Post.create(title: "Things")
    expect(post.title).to eq("Things")
  end
end
