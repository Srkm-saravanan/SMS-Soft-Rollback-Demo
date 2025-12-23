package com.college.management.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.college.management.dao.ClassDAO;
import com.college.management.model.Class;

@WebServlet("/ClassServlet")
public class ClassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClassDAO classDAO;

    public void init() {
        classDAO = new ClassDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // POST is used for inserting data
        insertNewClass(request);
        // After insertion, redirect to GET method to show the updated list
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check for the 'action' parameter to see if a delete request was sent
        String action = request.getParameter("action");
        if (action != null && action.equals("delete")) {
            deleteClass(request);
        }
        
        // Always retrieve and show the list of classes
        List<Class> classList = classDAO.selectAllClasses();
        request.setAttribute("classList", classList);
        
        request.getRequestDispatcher("class-list.jsp").forward(request, response);
    }

    private void insertNewClass(HttpServletRequest request) {
        String className = request.getParameter("className");
        if (className != null && !className.trim().isEmpty()) {
            Class newClass = new Class(className.trim());
            int newId = classDAO.insertClass(newClass);
            
            if (newId != -1) {
                request.setAttribute("message", "Success! Class '" + className + "' added with ID: " + newId);
            } else {
                // This typically means a database error (e.g., duplicate unique key)
                request.setAttribute("message", "Error! Class could not be added. (Name might already exist).");
            }
        }
    }

    private void deleteClass(HttpServletRequest request) {
        try {
            // Get the ID passed from the JSP URL
            int id = Integer.parseInt(request.getParameter("id"));
            // Call the new DAO method
            boolean isSuccess = classDAO.deleteClass(id);
            
            if (isSuccess) {
                request.setAttribute("message", "Success! Class with ID " + id + " was deleted.");
            } else {
                request.setAttribute("message", "Error! Class with ID " + id + " could not be found or deleted.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Error! Invalid class ID provided for deletion.");
        }
    }
}