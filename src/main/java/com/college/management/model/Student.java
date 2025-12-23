package com.college.management.model;

public class Student {
    private int studentId;
    private String rollNumber;
    private String firstName;
    private String lastName;
    private String email;
    private int classId;

    // NEW FIELDS (Version 2.0)
    private String mobileNumber;
    private String address;

    // Helper Object (for displaying class name)
    private Class studentClass;

    // Default constructor
    public Student() {}

    // Constructor for insertion/registration (without ID, includes new fields)
    public Student(String rollNumber, String firstName, String lastName, String email, int classId,
                   String mobileNumber, String address) {
        this.rollNumber = rollNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.classId = classId;
        this.mobileNumber = mobileNumber;
        this.address = address;
    }

    // Constructor for retrieval (with ID, without new fields - backward compatible)
    public Student(int studentId, String rollNumber, String firstName, String lastName, String email, int classId) {
        this.studentId = studentId;
        this.rollNumber = rollNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.classId = classId;
    }

    // Full constructor (with ID and new fields)
    public Student(int studentId, String rollNumber, String firstName, String lastName, String email, int classId,
                   String mobileNumber, String address) {
        this.studentId = studentId;
        this.rollNumber = rollNumber;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.classId = classId;
        this.mobileNumber = mobileNumber;
        this.address = address;
    }

    // Getters and Setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getRollNumber() {
        return rollNumber;
    }

    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public Class getStudentClass() {
        return studentClass;
    }

    public void setStudentClass(Class studentClass) {
        this.studentClass = studentClass;
    }

    // New Getters and Setters
    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}