class Book
  attr_reader :author, :title, :id, :status

  def initialize(title, author, status = 'available', id = nil)
    @author = author
    @title  = title
    @status = status
    @id     = id
  end

  def check_out
    if @status == 'available'
      @status = 'checked_out'
      true
    elsif @status == 'checked_out'
      false
    end
  end

  def check_in
    if @status == 'checked_out'
      @status = 'available'
      true
    elsif @status == 'available'
      false
    end
  end
end

class Borrower
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Library

  @@book_ids = 0

  def initialize
    @books     = []
    @borrowers = {}
  end

  def books
    @books
  end

  def register_new_book(title, author)
    @books << Book.new( title, author, 'available', @@book_ids += 1 )
  end

  def add_book(title, author)
  end

  def check_out_book(book_id, borrower)
    return nil if @borrowers.values.include?(borrower.name)

    @books.each do |book|
      if book.id == book_id && book.status == 'available'
        book.check_out
        @borrowers[book_id] = borrower.name
        return book
      else
        return nil
      end
    end
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
