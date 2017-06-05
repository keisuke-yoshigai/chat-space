require "rails_helper"

describe Message do

  before :each do
    @group = create(:group)
    @user = create(:user)
  end

  context "メッセージを保存できる場合" do
    it "メッセージがあれば保存できる" do
      message = build(:message, group_id: @group.id,user_id: @user.id, image: nil)
      expect(message).to be_valid
    end
    it "画像があれば保存できる" do
      message = build(:message, group_id: @group.id,user_id: @user.id, body: nil)
      expect(message).to be_valid
    end
    it "メッセージと画像があれば保存できる" do
      message = build(:message, group_id: @group.id,user_id: @user.id)
      expect(message).to be_valid
    end
  end

  context "メッセージを保存できない場合"do
    it "メッセージも画像も無いと保存できない" do
      message = build(:message, group_id: @group.id, user_id: @user.id, body: nil, image: nil)
      message.valid?
      expect(message.errors.full_messages).to include("Body or imageを入力してください")
    end
    it "group_idが無いと保存できない" do
      message = build(:message, group_id: nil, user_id: @user.id)
      message.valid?
      expect(message.errors.full_messages).to include("Groupを入力してください")
    end
    it "user_idが無いと保存できない" do
      message = build(:message, group_id: @group.id, user_id: nil)
      message.valid?
      expect(message.errors.full_messages).to include("Userを入力してください")
    end
  end
end
