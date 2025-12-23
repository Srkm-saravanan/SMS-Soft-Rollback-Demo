package com.college.management.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.college.management.model.Book;
import com.college.management.util.DBUtil;

public class BookDAO {

    // --- SQL QUERIES ---
    private static final String INSERT_BOOK_SQL = "INSERT INTO book (book_name) VALUES (?);";
    private static final String SELECT_ALL_BOOKS = "SELECT * FROM book ORDER BY book_name;";

    // Mapping Queries
    private static final String ASSIGN_BOOK_SQL = "INSERT INTO student_book_mapping (student_id, book_id) VALUES (?, ?);";
    private static final String UNASSIGN_BOOK_SQL = "DELETE FROM student_book_mapping WHERE student_id = ? AND book_id = ?;";

    private static final String SELECT_BOOKS_BY_STUDENT = 
        "SELECT b.book_id, b.book_name " +
        "FROM book b " +
        "JOIN student_book_mapping m ON b.book_id = m.book_id " +
        "WHERE m.student_id = ? " +
        "ORDER BY b.book_name;";

    // --- METHODS ---

    public void insertBook(Book book) {
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_BOOK_SQL)) {
            preparedStatement.setString(1, book.getBookName());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Book> selectAllBooks() {
        List<Book> books = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_BOOKS);
             ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                books.add(new Book(rs.getInt("book_id"), rs.getString("book_name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    public boolean assignBookToStudent(int studentId, int bookId) {
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(ASSIGN_BOOK_SQL)) {
            statement.setInt(1, studentId);
            statement.setInt(2, bookId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean unassignBook(int studentId, int bookId) {
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(UNASSIGN_BOOK_SQL)) {
            statement.setInt(1, studentId);
            statement.setInt(2, bookId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Book> getBooksByStudentId(int studentId) {
        List<Book> books = new ArrayList<>();
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(SELECT_BOOKS_BY_STUDENT)) {
            statement.setInt(1, studentId);
            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    books.add(new Book(rs.getInt("book_id"), rs.getString("book_name")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // --- NEW: REPORT METHOD ---
    // Returns a Map: StudentID -> Comma-separated list of issued book names (e.g., "Java Programming, Python Basics, SQL Fundamentals")
    public Map<Integer, String> getAllIssuedBooksReport() {
        Map<Integer, String> bookMap = new HashMap<>();
        
        String sql = "SELECT m.student_id, " +
                     "GROUP_CONCAT(b.book_name ORDER BY b.book_name SEPARATOR ', ') AS books " +
                     "FROM student_book_mapping m " +
                     "JOIN book b ON m.book_id = b.book_id " +
                     "GROUP BY m.student_id;";

        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet rs = statement.executeQuery()) {
            
            while (rs.next()) {
                int studentId = rs.getInt("student_id");
                String booksList = rs.getString("books");
                // Handle case where GROUP_CONCAT might return null (no books)
                bookMap.put(studentId, booksList != null ? booksList : "None");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookMap;
    }
}