require "./library.rb"
# require 'pry-debugger'

describe Book do
  before(:each) do
    @book = Book.new("The Stranger", "Albert Camus")
  end

  it "has a title and author, and nil id" do
    # binding.pry

    expect(@book.title).to eq "The Stranger"
    expect(@book.author).to eq "Albert Camus"
    expect(@book.id).to be_nil
  end

  it "defaults year_published, check_out_date and edition to nil" do
    expect(@book.year_published).to be_nil
    expect(@book.edition).to be_nil
    expect(@book.check_out_date).to be_nil
    expect(@book.due_date).to be_nil
  end

  it "starts with an empty array of reviews" do
    expect(@book.reviews).to eq([])
  end

  it "has a default status of available" do
    expect(@book.status).to eq 'available'
  end

  it "can be checked out" do
    did_it_work = @book.check_out
    expect(did_it_work).to be_true
    expect(@book.status).to eq 'checked_out'
    expect(@book.check_out_date).to be_a(Time)
  end

  it "can't be checked out twice in a row" do
    did_it_work = @book.check_out
    expect(did_it_work).to eq(true)

    did_it_work_again = @book.check_out
    expect(did_it_work_again).to eq(false)

    expect(@book.status).to eq 'checked_out'
  end

  it "can be checked in" do
    @book.check_out
    @book.check_in
    expect(@book.status).to eq 'available'
    expect(@book.check_out_date).to be_nil
  end

  it "can be reviewed" do
    @book.review(5, 'This is awesome')
    expect(@book.reviews.first.rating).to eq(5)
  end
end

describe Borrower do
  it "has a name" do
    borrower = Borrower.new("Mike")
    expect(borrower.name).to eq "Mike"
  end

  it "starts with an empty hash of books" do
    borrower = Borrower.new("Mike")
    expect(borrower.books).to eq({})
  end
end

describe Library do
  it "starts with an empty array of books and empty hash of borrowers" do
    lib = Library.new
    expect(lib.books.count).to eq(0)
    expect(lib.borrowers.count).to eq(0)
  end

  it "add new books and assigns it an id" do
    lib = Library.new
    lib.register_new_book("Nausea", "Jean-Paul Sartre")
    expect(lib.books.count).to eq(1)

    created_book = lib.books.first
    expect(created_book.title).to eq "Nausea"
    expect(created_book.author).to eq "Jean-Paul Sartre"
    expect(created_book.id).to_not be_nil
  end

  it "can add multiple books" do
    lib = Library.new
    lib.register_new_book("One", "Bob")
    lib.register_new_book("Two", "Bob")
    lib.register_new_book("Three", "Bob")

    expect(lib.books.count).to eq(3)
  end

  it "allows a Borrower to check out a book by its id" do
    lib = Library.new
    lib.register_new_book("Green Eggs and Ham", "Dr. Seuss")
    book_id = lib.books.first.id

    # Sam wants to check out Green Eggs and Ham
    sam = Borrower.new('Sam-I-am')
    book = lib.check_out_book(book_id, sam)

    # The checkout should return the book
    expect(book).to be_a(Book)
    expect(book.title).to eq "Green Eggs and Ham"

    # The book should now be marked as checked out
    expect(book.status).to eq 'checked_out'
  end

  it "knows who borrowed a book" do
    lib = Library.new
    lib.register_new_book("The Brothers Karamazov", "Fyodor Dostoesvky")
    book_id = lib.books.first.id

    # Big Brother wants to check out The Brothers Karamazov
    bro = Borrower.new('Big Brother')
    book = lib.check_out_book(book_id, bro)

    # The Library should know that he checked out the book
    expect( lib.get_borrower(book_id) ).to eq 'Big Brother'
  end

  it "does not allow a book to be checked out twice in a row" do
    lib = Library.new
    lib.register_new_book("Surely You're Joking Mr. Feynman", "Richard Feynman")
    book_id = lib.books.first.id

    # Leslie Nielsen wants to double check on that
    nielsen = Borrower.new('Leslie Nielsen')
    book = lib.check_out_book(book_id, nielsen)

    # The first time should be successful
    expect(book).to be_a(Book)

    # However, you can't check out the same book twice!
    book_again = lib.check_out_book(book_id, nielsen)
    expect(book_again).to be_nil

    son = Borrower.new('Leslie Nielsen the 2nd')
    book_again = lib.check_out_book(book_id, son)
    expect(book_again).to be_nil
  end

  it "allows a Borrower to check a book back in" do
    lib = Library.new
    lib.register_new_book("Finnegans Wake", "James Joyce")
    book_id = lib.books.first.id

    # Bob wants to check out Finnegans Wake
    bob = Borrower.new('Bob Bobber')
    book = lib.check_out_book(book_id, bob)

    # o wait he changed his mind
    lib.check_in_book(book)

    # The book should now be marked as available!
    expect(book.status).to eq 'available'
  end

  it "does not allow a Borrower to check out more than two Books at any given time" do
    # yeah it's a stingy library
    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford")

    jackson = Borrower.new("Michael Jackson")
    book_1 = lib.books[0]
    book_2 = lib.books[1]
    book_3 = lib.books[2]

    # The first two books should check out fine
    book = lib.check_out_book(book_1.id, jackson)
    expect(book.title).to eq "Eloquent JavaScript"

    book = lib.check_out_book(book_2.id, jackson)
    expect(book.title).to eq "Essential JavaScript Design Patterns"

    # However, the third should return nil
    book = lib.check_out_book(book_2.id, jackson)
    expect(book).to be_nil
  end

  it "does not allow a Borrower to check out another Book if they have a late book" do
    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")

    jackson = Borrower.new("Michael Jackson")
    book_1 = lib.books[0]
    book_2 = lib.books[1]

    # The first book should check out fine
    book = lib.check_out_book(book_1.id, jackson)
    book.send(:due_date=, book.due_date - (2*7*24*60*60))
    expect(book.due_date).to be < Time.now

    # However, the second should return nil
    book = lib.check_out_book(book_2.id, jackson)
    expect(book).to be_nil
  end

  it "returns available books" do
    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford")

    # At first, all books are available
    expect(lib.available_books.count).to eq(3)
    expect(lib.available_books.first).to be_a(Book)

    jordan = Borrower.new("Michael Jordan")
    book = lib.check_out_book(lib.available_books.first.id, jordan)

    # But now, there should only be two available books
    expect(lib.available_books.count).to eq(2)
  end

  it "after a book it returned, it can be checked out again" do
    lib = Library.new
    lib.register_new_book("Harry Potter", "J. K. Rowling")
    book_id = lib.books.first.id

    # First, we check out the book
    vick = Borrower.new("Michael Vick")
    book = lib.check_out_book(book_id, vick)
    expect( lib.get_borrower(book_id) ).to eq 'Michael Vick'

    # When we check in a book, the Library does not care who checks it in
    lib.check_in_book(book)

    # Another person should be able to check the book out
    schumacher = Borrower.new("Michael Schumacher")
    book = lib.check_out_book(book_id, schumacher)
    expect( lib.get_borrower(book_id) ).to eq 'Michael Schumacher'
  end

  it "returns borrowed books" do
    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford")

    # At first, no books are checked out
    expect(lib.borrowed_books.count).to eq(0)

    kors = Borrower.new("Michael Kors")
    book = lib.check_out_book(lib.books.first.id, kors)

    # But now there should be one checked out book
    expect(lib.borrowed_books.count).to eq(1)
    expect(lib.borrowed_books.first).to be_a(Book)
  end

  it "lists the borrowers and thier checked out books" do
    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford")

    book_1 = lib.books[0]
    book_2 = lib.books[1]
    book_3 = lib.books[2]

    jackson = Borrower.new("Michael Jackson")
    john    = Borrower.new("John Smith")
    sam     = Borrower.new("Joe Sam")

    lib.check_out_book(book_1.id, jackson)
    lib.check_out_book(book_2.id, john)

    expect( lib.display_borrowers ).to be_a(String)
    expect( lib.display_borrowers ).to include("Michael Jackson",
                                               "John Smith",
                                               "Eloquent JavaScript",
                                               "Essential JavaScript Design Patterns")
  end

  it "lists overdue books" do
    lib = Library.new
    lib.register_new_book("Eloquent JavaScript", "Marijn Haverbeke")
    lib.register_new_book("Essential JavaScript Design Patterns", "Addy Osmani")
    lib.register_new_book("JavaScript: The Good Parts", "Douglas Crockford")

    book_1 = lib.books[0]
    book_2 = lib.books[1]
    book_3 = lib.books[2]

    jackson = Borrower.new("Michael Jackson")
    john    = Borrower.new("John Smith")
    sam     = Borrower.new("Joe Sam")

    lib.check_out_book(book_1.id, jackson)
    lib.check_out_book(book_2.id, john)

    book_1.send(:due_date=, book_1.due_date - (2*7*24*60*60))
    book_2.send(:due_date=, book_2.due_date - (2*7*24*60*60))

    expect( lib.overdue_books ).to be_a(String)
    expect( lib.overdue_books ).to include("Eloquent JavaScript",
                                           "Essential JavaScript Design Patterns")

    expect( lib.overdue_books ).not_to include("JavaScript: The Good Parts")
  end

end
