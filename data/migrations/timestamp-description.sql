-- This creates the bookshelves table with a primary key of id and a name column
CREATE TABLE bookshelves (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- This inserts the unique bookshelf categories into the new bookshelves.name column
INSERT INTO bookshelves(name) SELECT DISTINCT bookshelf FROM books;

-- This adds a new column to the books table that takes INTs so it can be linked to the IDs of the bookshelves table
ALTER TABLE books ADD COLUMN bookshelf_id INT;

-- This takes a view of the bookshelves table called bookshelf and uses it as reference for updating values in the books.bookshelf_id column by matching the books.bookshelf categories to the view's name column
UPDATE books SET bookshelf_id=bookshelf.id FROM (SELECT * FROM bookshelves) AS bookshelf WHERE books.bookshelf = bookshelf.name;

-- This drops the original bookshelf column from the books table
ALTER TABLE books DROP COLUMN bookshelf;

-- This makes the books.bookshelf_id a foreign key referencing the bookshelves primary key (the id column)
ALTER TABLE books ADD CONSTRAINT fk_bookshelves FOREIGN KEY (bookshelf_id) REFERENCES bookshelves(id);


