class Book
  attr_reader :author, :title, :id, :status, :year_published, :edition, :reviews, :check_out_date

  def initialize(title, author, status = 'available', id = nil, year_published=nil, edition=nil)
    @author         = author
    @title          = title
    @status         = status
    @id             = id
    @year_published = year_published
    @edition        = edition
    @reviews        = [ ]
    @check_out_date = nil
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      @check_out_date = Time.new
      true
    elsif @status == 'checked_out'
      false
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
      @check_out_date = nil
      true
    elsif @status == 'available'
      false
    end
  end

  def review(rating, comment = nil)
    @reviews << Review.new(rating, comment)
  end

  private

  def check_out_date=(date)
    @check_out_date = date
  end
end

class Review
  attr_reader :rating, :comment

  def initialize(rating, comment = nil)
    @rating  = rating
    @comment = comment
  end
end

class Borrower
  attr_reader :name, :books

  def initialize(name)
    @name  = name
    @books = [ ]
  end

  def has_two_books?
    @books.length == 2
  end

  def has_late_books?
    late_book = @books.find {|book| Time.now > (book.check_out_date + (1*7*24*60*60))}
    late_book != nil
  end
end

class Library
  attr_reader :books, :borrowers

  @@book_ids = 0

  def initialize
    @books     = []
    @borrowers = {}
  end

  def register_new_book(title, author)
    @books << Book.new( title, author, 'available', @@book_ids += 1 )
  end

  def check_out_book(book_id, borrower)
    return nil if borrower.has_two_books?
    return nil if borrower.has_late_books?

    @books.each do |book|
      if book.id == book_id && book.status == 'available'
        book.check_out
        @borrowers[book_id] = borrower.name
        borrower.books << book
        return book
      end
    end

    return nil
  end

  def get_borrower(book_id)
    @borrowers[book_id]
  end

  def check_in_book(a_book)
    @books.each do |book|
      if book.id == a_book.id
        book.check_in
        @borrowers.delete a_book.id
        return true
      end
    end
  end

  def available_books
    @books.select {|book| book.status == 'available'}
  end

  def borrowed_books
    @books.select {|book| book.status == 'checked_out'}
  end
end
