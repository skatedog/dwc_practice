class SearchesController < ApplicationController
  def search
    keyword = params[:keyword]
    case params[:model]
    when "book"
      models = Book.includes(user: :image_attachment)
      colomn = "title"
    when "user"
      models = User.all
      colomn = "name"
    end

    @searched_models =
    case params[:parameter]
    when "exact_match"
      models.where("#{colomn} = ?","#{keyword}")
    when "forward_match"
      models.where("#{colomn} LIKE?","#{keyword}%")
    when "backward_match"
      models.where("#{colomn} LIKE?","%#{keyword}")
    when "pattern_match"
      models.where("#{colomn} LIKE?","%#{keyword}%")
    end
  end
end
