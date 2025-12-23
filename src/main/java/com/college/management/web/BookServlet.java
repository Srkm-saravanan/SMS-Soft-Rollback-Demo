package com.college.management.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.college.management.dao.BookDAO;
import com.college.management.model.Book;

@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;

    public void init() {
        bookDAO = new BookDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Handle "Add New Book"
        String bookName = request.getParameter("bookName");
        Book newBook = new Book(bookName);
        bookDAO.insertBook(newBook);
        
        // Redirect to the list to see the result
        response.sendRedirect("BookServlet?action=list");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) { action = "list"; }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            default:
                listBooks(request, response);
                break;
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("book-form.jsp").forward(request, response);
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Book> listBook = bookDAO.selectAllBooks();
        request.setAttribute("listBook", listBook);
        request.getRequestDispatcher("book-list.jsp").forward(request, response);
    }
}