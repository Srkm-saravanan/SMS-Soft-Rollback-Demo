package com.college.management.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.college.management.model.Subject;
import com.college.management.util.DBUtil;

public class SubjectDAO {

    private static final String INSERT_SUBJECT_SQL = 
        "INSERT INTO subject (subject_name) VALUES (?);";
    private static final String SELECT_ALL_SUBJECTS = 
        "SELECT subject_id, subject_name FROM subject ORDER BY subject_name;";
    private static final String DELETE_SUBJECT_SQL = 
        "DELETE FROM subject WHERE subject_id = ?;";

    /**
     * Inserts a new Subject into the database.
     * @param newSubject The Subject object containing the name.
     * @return The auto-generated subjectId, or -1 if insertion fails.
     */
    public int insertSubject(Subject newSubject) {
        int subjectId = -1;
        
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SUBJECT_SQL, 
                                                                               Statement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setString(1, newSubject.getSubjectName());
            
            int rowsAffected = preparedStatement.executeUpdate();
            
            if (rowsAffected > 0) {
                try (ResultSet rs = preparedStatement.getGeneratedKeys()) {
                    if (rs.next()) {
                        subjectId = rs.getInt(1);
                        newSubject.setSubjectId(subjectId);
                    }
                }
                System.out.println("Subject inserted successfully: " + newSubject.getSubjectName());
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Exception during insertSubject: " + e.getMessage());
            e.printStackTrace();
        }
        return subjectId;
    }

    /**
     * Retrieves all subjects from the database.
     * @return A list of Subject objects.
     */
    public List<Subject> selectAllSubjects() {
        List<Subject> subjects = new ArrayList<>();
        
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_SUBJECTS)) {
            
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("subject_id");
                    String name = rs.getString("subject_name");
                    subjects.add(new Subject(id, name));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Exception during selectAllSubjects: " + e.getMessage());
            e.printStackTrace();
        }
        return subjects;
    }

    /**
     * Deletes a Subject from the database by its ID.
     * @param subjectId The ID of the subject to delete.
     * @return true if the deletion was successful, false otherwise.
     */
    public boolean deleteSubject(int subjectId) {
        boolean rowDeleted = false;
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_SUBJECT_SQL)) {
            
            statement.setInt(1, subjectId);
            rowDeleted = statement.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("SQL Exception during deleteSubject: " + e.getMessage());
            e.printStackTrace();
        }
        return rowDeleted;
    }
}