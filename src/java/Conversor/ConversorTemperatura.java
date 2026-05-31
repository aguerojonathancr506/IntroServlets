/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author aguer
 */

package Conversor;

public class ConversorTemperatura {

    
    public double convertir(double temperatura, String conversion) {

        switch (conversion) {

            case "Celsius → Fahrenheit":
                return (temperatura * 9/5) + 32;

            case "Fahrenheit → Celsius":
                return (temperatura - 32) * 5/9;

            case "Celsius → Kelvin":
                return temperatura + 273.15;

            case "Kelvin → Celsius":
                return temperatura - 273.15;

            default:
                return 0;
        }
    }
}
