class DocsController < ApplicationController
  before_action :find_doc, only: [:show, :edit, :update, :destroy]
  def index
    @docs = Doc.all.order("created_at DESC")
  end

  def show
  end

  def new
    @doc = current_user.docs.build
  end

  def create
    @doc = Doc.new doc_params
    if @doc.save
      redirect_to @doc
    else
      render 'new'
      # redirect is the new HTTP request, so incase you create a long document
      # it will refresh it and you will loose all the content, so we use render.
    end
  end

  def edit
    # edit is responsible for the new file just the way as edit is responsible for
    # the new edit..create is responsible for creating parameters and update is
    #responsible for updating the parameters.
  end

  def update
    if @doc.update doc_params
      redirect_to @doc
    else
      render 'edit'
    end
  end

  def destroy
    @doc.destroy
    redirect_to docs_path
  end

  private

  def find_doc
    @doc = Doc.find(params[:id])
  end

  def doc_params
    params.require(:doc).permit(:title, :content)
  end
end
