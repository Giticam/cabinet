class DocsController < ApplicationController
  before_action :find_doc, only: [:show, :edit, :update, :destroy]
  def index
    @docs = Doc.where(user_id: current_user)
  end

  def show
  end

  def new
    @doc = current_user.docs.build
    # The only difference between some_firm.clients.new and some_firm.clients
    # .build seems to be that build also adds the newly-created client to the
    # clients collection
  #   If you're creating an object through an association, build should be preferred
  #  over new as build keeps your in-memory object, some_firm (in this case)
  #  in a consistent state even before any objects have been saved to the database.

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
