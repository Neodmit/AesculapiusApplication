package Servlets;

import CRUD.CRUDExemption;
import CRUD.CRUDPatient;
import my.Exemption;
import my.Patient;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ExemptionServlet extends HttpServlet {
    List<Exemption> exemptions = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            for (int i = 1; i <= exemptions.size(); i++) {
                if (request.getParameter("remove" + String.valueOf(i)) != null) {
                    CRUDExemption.removeExemption(String.valueOf(i));
                }
            }
            if (request.getParameter("add") != null) {
                CRUDExemption.createExemption(request.getParameter("add_exempt_ID"),
                        request.getParameter("add_e_type"),
                        request.getParameter("add_e_exempt"));
            }
            if (request.getParameter("change") != null) {
                CRUDExemption.changeExemption(request.getParameter("change_exempt_ID"),
                        request.getParameter("change_e_type"),
                        request.getParameter("change_e_exempt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getParameter("letsgototheexemption");

        try {
            exemptions= CRUDExemption.getExemption();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("exemptionList", exemptions);
        getServletConfig().getServletContext().getRequestDispatcher("/exemption.jsp").forward(request, response);
    }
}
