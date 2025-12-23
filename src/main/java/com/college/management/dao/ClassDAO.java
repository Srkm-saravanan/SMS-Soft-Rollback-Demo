package com.college.management.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.college.management.model.Class;
import com.college.management.util.DBUtil;

public class ClassDAO {

    // SQL statement to insert a new class
    private static final String INSERT_CLASS_SQL = 
        "INSERT INTO class (class_name) VALUES (?);";
    
    // SQL statement to select all classes
    private static final String SELECT_ALL_CLASSES = 
        "SELECT class_id, class_name FROM class;";
        
    // === NEW SQL STATEMENT FOR DELETE ===
    private static final String DELETE_CLASS_SQL = 
        "DELETE FROM class WHERE class_id = ?;";
    // ====================================

    /**
     * Inserts a new Class into the database.
     * @param newClass The Class object containing the name.
     * @return The auto-generated classId, or -1 if insertion fails.
     */
    public int insertClass(Class newClass) {
        int classId = -1;
        
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CLASS_SQL, 
                                                                               Statement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setString(1, newClass.getClassName());
            
            int rowsAffected = preparedStatement.executeUpdate();
            
            if (rowsAffected > 0) {
                // Retrieve the auto-generated primary key (class_id)
                try (ResultSet rs = preparedStatement.getGeneratedKeys()) {
                    if (rs.next()) {
                        classId = rs.getInt(1);
                        newClass.setClassId(classId); // Update the model object
                    }
                }
                System.out.println("Class inserted successfully: " + newClass.getClassName());
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Exception during insertClass: " + e.getMessage());
            e.printStackTrace();
        }
        return classId;
    }

    /**
     * Retrieves all classes from the database.
     * @return A list of Class objects.
     */
    public List<Class> selectAllClasses() {
        List<Class> classes = new ArrayList<>();
        
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CLASSES)) {
            
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("class_id");
                    String name = rs.getString("class_name");
                    classes.add(new Class(id, name));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Exception during selectAllClasses: " + e.getMessage());
            e.printStackTrace();
        }
        return classes;
    }

    // === NEW METHOD FOR DELETE ===
    /**
     * Deletes a Class from the database by its ID.
     * @param classId The ID of the class to delete.
     * @return true if the deletion was successful, false otherwise.
     */
    public boolean deleteClass(int classId) {
        boolean rowDeleted = false;
        try (Connection connection = DBUtil.getConnection();
             PreparedStatement statement = connection.prepareStatement(DELETE_CLASS_SQL)) {
            
            statement.setInt(1, classId);
            rowDeleted = statement.executeUpdate() > 0;
            
            if (rowDeleted) {
                System.out.println("Class deleted successfully with ID: " + classId);
            }
            
        } catch (SQLException e) {
            System.err.println("SQL Exception during deleteClass: " + e.getMessage());
            e.printStackTrace();
        }
        return rowDeleted;
    }
    // =============================
}