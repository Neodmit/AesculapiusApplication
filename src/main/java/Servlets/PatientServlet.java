package Servlets;

import CRUD.CRUDPatient;
import my.Patient;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class PatientServlet extends HttpServlet {
    List<Patient> patients = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            for (int i = 1; i <= patients.size(); i++) {
                if (request.getParameter("remove" + String.valueOf(i)) != null) {
                    CRUDPatient.removePatient(String.valueOf(i));
                }
            }
            if (request.getParameter("add") != null) {
                CRUDPatient.createPatient(request.getParameter("add_patient_ID"),
                        request.getParameter("add_p_FIO"),
                        request.getParameter("add_p_address"),
                        request.getParameter("add_p_district"),
                        request.getParameter("add_p_policy"),
                        request.getParameter("add_p_year"),
                        request.getParameter("add_p_sign"),
                        request.getParameter("add_p_department"));
            }
            if (request.getParameter("change") != null) {
                CRUDPatient.changePatient(request.getParameter("change_patient_ID"),
                        request.getParameter("change_p_FIO"),
                        request.getParameter("change_p_address"),
                        request.getParameter("change_p_district"),
                        request.getParameter("change_p_policy"),
                        request.getParameter("change_p_year"),
                        request.getParameter("change_p_sign"),
                        request.getParameter("change_p_department"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getParameter("letsgotothepatient");
        try {
            patients = CRUDPatient.getPatient();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("patientList", patients);
        getServletConfig().getServletContext().getRequestDispatcher("/patient.jsp").forward(request, response);
    }
}
