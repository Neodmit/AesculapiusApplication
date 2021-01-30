package Servlets;


import CRUD.CRUDApointment;
import CRUD.CRUDDoctor;
import my.Doctor;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


public class DoctorServlet extends HttpServlet {
    List<Doctor> doctors = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            for (int i = 1; i <= doctors.size(); i++) {
                if (request.getParameter("remove" + String.valueOf(i)) != null) {
                    CRUDDoctor.removeDoctor(String.valueOf(i));
                }
            }
            if (request.getParameter("add") != null) {
                CRUDDoctor.createDoctor(request.getParameter("add_doctor_ID"),
                        request.getParameter("add_d_FIO"),
                        request.getParameter("add_d_room"),
                        request.getParameter("add_d_university"),
                        request.getParameter("add_d_type"),
                        request.getParameter("add_d_experience"),
                        request.getParameter("add_d_phone"),
                        request.getParameter("add_d_born"));
            }
            if (request.getParameter("change") != null) {
                CRUDDoctor.changeDoctor(request.getParameter("change_doctor_ID"),
                        request.getParameter("change_d_FIO"),
                        request.getParameter("change_d_room"),
                        request.getParameter("change_d_university"),
                        request.getParameter("change_d_type"),
                        request.getParameter("change_d_experience"),
                        request.getParameter("change_d_phone"),
                        request.getParameter("change_d_born"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getParameter("letsgotothedoctor");
        try {
            doctors = CRUDDoctor.getDoctor();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("doctorList", doctors);
        getServletConfig().getServletContext().getRequestDispatcher("/doctor.jsp").forward(request, response);
    }
}
