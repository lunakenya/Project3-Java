package com.example.proyecto2.controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HolaMundoController {

    @GetMapping("/hola")
    public String helloworld() {
        return "Hola Mundo";
    }

    @GetMapping("/")
    public String home() {
        return "Welcome to Distibuida by Kenya Luna";
    }
}
