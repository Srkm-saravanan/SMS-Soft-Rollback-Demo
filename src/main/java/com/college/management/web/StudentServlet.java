package com.college.management.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.college.management.dao.ClassDAO;
import com.college.management.dao.StudentDAO;
import com.college.management.model.Class;
import com.college.management.model.Student;

@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StudentDAO studentDAO;
    private ClassDAO classDAO;

    public void init() {
        studentDAO = new StudentDAO();
        classDAO = new ClassDAO();
        // REMOVED: SubjectDAO and BookDAO (V1 did not use them)
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // V1 Logic: The only POST action allowed is inserting a new student.
        // We removed handling for 'assignSubject', 'issueBook', and 'updateStudent'.
        insertNewStudent(request);
        doGet(request, response);
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
                deleteStudent(request); 
                listStudents(request, response); 
                break;
            // REMOVED: edit, manageLearning, unassign, returnBook, report
            default: 
                listStudents(request, response); 
                break;
        }
    }

    // --- HELPER METHODS (Reverted to V1) ---

    private void insertNewStudent(HttpServletRequest request) {
        String rollNumber = request.getParameter("rollNumber");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        int classId = Integer.parseInt(request.getParameter("classId"));
        
        // V1: We deliberately ignore Mobile and Address
        String mobileNumber = null;
        String address = null;

        Student newStudent = new Student(rollNumber, firstName, lastName, email, classId, mobileNumber, address);
        int newId = studentDAO.insertStudent(newStudent);
        
        if (newId != -1) request.setAttribute("message", "Success! Student added: " + firstName);
        else request.setAttribute("message", "Error! Could not add student.");
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Class> classList = classDAO.selectAllClasses();
        request.setAttribute("classList", classList);
        request.getRequestDispatcher("student-form.jsp").forward(request, response);
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Student> listStudent = studentDAO.selectAllStudents();
        request.setAttribute("listStudent", listStudent);
        request.getRequestDispatcher("student-list.jsp").forward(request, response);
    }

    private void deleteStudent(HttpServletRequest request) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            studentDAO.deleteStudent(id);
            request.setAttribute("message", "Student deleted successfully.");
        } catch (Exception e) { e.printStackTrace(); }
    }
}