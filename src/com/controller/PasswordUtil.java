package com.controller;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class PasswordUtil {

	public static String hashPassword(String password) throws NoSuchAlgorithmException {
	    if (password == null || password.trim().isEmpty()) {
	        throw new IllegalArgumentException("Password cannot be null or empty.");
	    }
	    MessageDigest digest = MessageDigest.getInstance("SHA-256");
	    byte[] encodedHash = digest.digest(password.getBytes());
	    return Base64.getEncoder().encodeToString(encodedHash);
	}

	public static boolean verifyPassword(String enteredPassword, String storedHashedPassword) throws NoSuchAlgorithmException {
	    if (enteredPassword == null || enteredPassword.trim().isEmpty()) {
	        throw new IllegalArgumentException("Entered password cannot be null or empty.");
	    }
	    String enteredHashedPassword = hashPassword(enteredPassword);
	    return enteredHashedPassword.equalsIgnoreCase(storedHashedPassword);
	}

}
