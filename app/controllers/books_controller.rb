class BooksController < ApplicationController
  def new
  end

  def index
    @user = current_user

    @books = Book.all

    @book = Book.new
  end

  def show
     @book = Book.find(params[:id])

     @book_new = Book.new

     @user = @book.user

     @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id

    redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end

  def create
     # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user

    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
    # 4. トップ画面へリダイレクト
     redirect_to book_path(@book.id), notice: 'You have created book successfully.'
    else
      @books = Book.all
      render :index
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
