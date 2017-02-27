require "rails_helper"

RSpec.describe LikesController, type: :controller do
   let!(:user){FactoryGirl.create (:user)}
   let!(:project){FactoryGirl.create(:project)}
   before :each do
     sign_in(:user, user)
   end
   describe "POST #create" do
     it "expect like successful save" do
       expect{
         xhr :post , :create, {project_id: project.id, user_id: user.id}}
           .to change(Like, :count).by(1)
      end
    end

    describe "DELETE #destroy" do
      before do
        like = project.likes.build user_id: user.id
        like.save
      end
      it "expect unlike successful" do
        expect{
          xhr :delete , :destroy, {project_id: project.id, user_id: user.id, id: 1}}
           .to change(Like, :count).by(-1)
      end
   end
end
