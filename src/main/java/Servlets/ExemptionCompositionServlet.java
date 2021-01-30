package Servlets;

import CRUD.CRUDApointment;
import CRUD.CRUDExemption;
import CRUD.CRUDExemptionComposition;
import my.Apointment;
import my.Exemption;
import my.ExemptionComposition;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ExemptionCompositionServlet extends HttpServlet {
    List<ExemptionComposition> exemptionCompositions = null;
    List<Exemption> exemptions = null;
    List<Apointment> apointments = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            for (ExemptionComposition exemptionComposition : exemptionCompositions) {
                if (request.getParameter("remove" + exemptionComposition.getE_exempt_ID()+", "+exemptionComposition.getE_treaty_ID()) != null) {//Вообще по-хорошему так должно быть во всём коде
                    CRUDExemptionComposition.removeExemptionComposition(exemptionComposition.getE_exempt_ID(),  exemptionComposition.getE_treaty_ID());
                }
            }
            if (request.getParameter("add") != null) {
                CRUDExemptionComposition.createExemptionComposition(request.getParameter("add_e_exempt"),
                        request.getParameter("add_e_treaty"),
                        request.getParameter("add_e_summa"),
                        request.getParameter("add_e_comment"));
            }
            if (request.getParameter("change") != null) {
                CRUDExemptionComposition.changeExemptionComposition(request.getParameter("change_E_Exempt_Type"),
                        request.getParameter("change_e_treaty_date"),
                        request.getParameter("change_e_treaty_time"),
                        request.getParameter("change_e_treaty_doctor"),
                        request.getParameter("change_e_treaty_patient"),
                        request.getParameter("change_e_summa"),
                        request.getParameter("change_e_comment"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getParameter("letsgototheexemptioncomposition");

        try {
            exemptionCompositions = CRUDExemptionComposition.getExemptionComposition();
            exemptions = CRUDExemption.getExemption();
            apointments = CRUDApointment.getAllApointment();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("exemptionCompositionList", exemptionCompositions);
        request.setAttribute("exemptionList", exemptions);
        request.setAttribute("apointmentList", apointments);
        getServletConfig().getServletContext().getRequestDispatcher("/exemptionComposition.jsp").forward(request, response);
    }
}
