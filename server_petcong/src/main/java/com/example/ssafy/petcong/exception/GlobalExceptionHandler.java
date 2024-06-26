package com.example.ssafy.petcong.exception;

import lombok.extern.slf4j.Slf4j;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

import java.nio.file.InvalidPathException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.NoSuchElementException;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {
    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(
            MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatusCode status, WebRequest request) {
        ex.printStackTrace();

        return ResponseEntity
                .status(HttpStatus.BAD_REQUEST)
                .body(ex.getMessage());
    }

    @ExceptionHandler(InvalidPathException.class)
    public ResponseEntity<String> handleInvalidPathException(InvalidPathException ex) {
        log.warn(ex.getMessage());
        ex.printStackTrace();
        return ResponseEntity
                .badRequest()
                .body(ex.getMessage());
    }

    @ExceptionHandler(NoSuchElementException.class)
    public ResponseEntity<String> handleNoSuchElementException(NoSuchElementException ex) {
        log.warn(ex.getMessage());
        ex.printStackTrace();
        return ResponseEntity
                .badRequest()
                .body(ex.getMessage());
    }

    @ExceptionHandler(NotRegisterdException.class)
    public ResponseEntity<String> handleNotRegisterdException(NotRegisterdException ex) {
        ex.printStackTrace();
        return ResponseEntity
                .accepted()
                .build();
    }

    @ExceptionHandler(SQLException.class)
    public ResponseEntity<String> handleSQLException(SQLException ex) {
        ex.printStackTrace();
        return ResponseEntity
                .internalServerError()
                .body(ex.getMessage());
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<?> runtimeExceptionHandler(RuntimeException e) {
        e.printStackTrace();
        log.error(e.getMessage());
        log.error(Arrays.toString(e.getStackTrace()));
        e.printStackTrace();
        return ResponseEntity
                .badRequest()
                .body(e.getMessage() + Arrays.toString(e.getStackTrace()));
    }
}