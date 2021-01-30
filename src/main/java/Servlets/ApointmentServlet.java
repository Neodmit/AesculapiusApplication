package Servlets;

import CRUD.CRUDApointment;
import CRUD.CRUDDoctor;
import CRUD.CRUDPatient;
import my.Apointment;
import my.Doctor;
import my.Patient;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ApointmentServlet extends HttpServlet {
    List<Apointment> allApointments = null;
    List<Apointment> todayApointments = null;
    List<Doctor> doctors = null;
    List<Patient> patients = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            for (int i = 1; i <= allApointments.size(); i++) {
                if (request.getParameter("remove" + String.valueOf(i)) != null) {
                    CRUDApointment.removeApointment(String.valueOf(i));//Delete
                }
            }
            if (request.getParameter("add") != null) {
                CRUDApointment.createApointment(request.getParameter("add_treaty_ID"),
                        request.getParameter("add_a_date"),
                        request.getParameter("add_a_time"),
                        request.getParameter("add_a_cost"),
                        request.getParameter("add_a_doctor"),
                        request.getParameter("add_a_patient"));
            }
            if (request.getParameter("change") != null) {
                CRUDApointment.changeApointment(request.getParameter("change_treaty_ID"),
                        request.getParameter("change_a_date"),
                        request.getParameter("change_a_time"),
                        request.getParameter("change_a_cost"),
                        request.getParameter("change_a_doctor"),
                        request.getParameter("change_a_patient"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getParameter("letsgototheapointment");
        try {
            allApointments = CRUDApointment.getAllApointment();//Read
            todayApointments = CRUDApointment.getTodayApointment(allApointments);
            doctors = CRUDDoctor.getDoctor();
            patients = CRUDPatient.getPatient();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("todayList", todayApointments);
        request.setAttribute("allList", allApointments);
        request.setAttribute("doctorList", doctors);
        request.setAttribute("patientList", patients);
        getServletConfig().getServletContext().getRequestDispatcher("/apointment.jsp").forward(request, response);
    }

}
