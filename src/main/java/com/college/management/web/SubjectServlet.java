package com.college.management.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.college.management.dao.SubjectDAO;
import com.college.management.model.Subject;

@WebServlet("/SubjectServlet")
public class SubjectServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SubjectDAO subjectDAO;

    public void init() {
        subjectDAO = new SubjectDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Insert the new Subject
        insertNewSubject(request);
        
        // 2. REDIRECT to the list (Fixes the "Wrong Page" & "Double Submit" bugs)
        response.sendRedirect("SubjectServlet?action=list");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) { action = "list"; }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "delete":
                deleteSubject(request);
                // Redirect after delete to refresh list cleanly
                response.sendRedirect("SubjectServlet?action=list");
                break;
            default:
                listSubjects(request, response); // Default: Show the list
                break;
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("subject-form.jsp").forward(request, response);
    }

    private void insertNewSubject(HttpServletRequest request) {
        String subjectName = request.getParameter("subjectName");
        if (subjectName != null && !subjectName.trim().isEmpty()) {
            Subject newSubject = new Subject(subjectName.trim());
            subjectDAO.insertSubject(newSubject);
            // We don't set "message" here because sendRedirect wipes it. 
            // In a real app, we would use a Session attribute for "Flash Messages".
        }
    }

    private void listSubjects(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 1. Get all subjects from DB
        List<Subject> listSubject = subjectDAO.selectAllSubjects();
        
        // 2. Send to JSP
        request.setAttribute("subjectList", listSubject);
        request.getRequestDispatcher("subject-list.jsp").forward(request, response);
    }

    private void deleteSubject(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            subjectDAO.deleteSubject(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}