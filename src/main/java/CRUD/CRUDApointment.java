package CRUD;

import my.Apointment;
import Connect.Connect;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class CRUDApointment {
    private static CallableStatement callableStatement = null;

    public static List<Apointment> getAllApointment() throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("SELECT treaty_ID, a_date, a_time, a_cost, concat(d_surname,' ',d_name,' ', d_patronymic), p_fio  FROM apointment " +
                "LEFT JOIN doctor ON a_doctor_ID=doctor_ID " +
                "LEFT JOIN patient ON a_patient_ID=patient_ID " +
                "ORDER BY treaty_ID DESC");
        ResultSet res = callableStatement.executeQuery();
        List<Apointment> apointments = new ArrayList<Apointment>();
        while (res.next()) {
            Apointment apointment = new Apointment();
            apointment.setTreaty_ID(res.getString(1));
            apointment.setA_date(res.getString(2));
            apointment.setA_time(res.getString(3));
            apointment.setA_cost(res.getString(4));
            apointment.setA_doctor_fio(res.getString(5));
            apointment.setA_patient_fio(res.getString(6));
            apointments.add(apointment);
        }
        return apointments;
    }

    public static List<Apointment> getTodayApointment(List<Apointment> todayList) {
        SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        String today = format1.format(date);
        List<Apointment> todayApointments = new ArrayList<Apointment>();
        for (Apointment apointment : todayList) {
            if (apointment.getA_date().equals(today)) {
                todayApointments.add(apointment);
            }
        }
        return todayApointments;
    }

    public static void removeApointment(String id) throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("DELETE FROM Apointment WHERE treaty_ID=?");
        callableStatement.setString(1, id);
        callableStatement.execute();
    }

    public static void createApointment(String treaty_ID, String a_date, String a_time, String a_cost, String a_doctor, String a_patient) throws SQLException {
        String doctorData[] = a_doctor.split("\\, ");
        String doctorFIO[] = doctorData[0].split("\\s");
        String patientData[] = a_patient.split("\\, ");
        callableStatement = Connect.getConnection().prepareCall("INSERT INTO Apointment VALUES(?, ?, ?, ?, (SELECT doctor_ID FROM doctor WHERE d_surname=?), (SELECT patient_ID FROM patient WHERE p_fio=?))");
        callableStatement.setString(1, treaty_ID);
        callableStatement.setString(2, a_date);
        callableStatement.setString(3, a_time);
        callableStatement.setString(4, a_cost);
        callableStatement.setString(5, doctorFIO[0]);
        callableStatement.setString(6, patientData[0]);
        callableStatement.execute();
    }

    public static void changeApointment(String treaty_ID, String a_date, String a_time, String a_cost, String a_doctor, String a_patient) throws SQLException {
        String doctorFIO[] = a_doctor.split("\\s");
        callableStatement = Connect.getConnection().prepareCall("UPDATE Apointment SET treaty_ID=?, a_date=?, a_time=?, a_cost=?, a_doctor_ID=(SELECT doctor_ID FROM doctor WHERE d_surname=?), a_patient_ID=(SELECT patient_ID FROM patient WHERE p_fio=?) WHERE treaty_ID=?");
        callableStatement.setString(1, treaty_ID);
        callableStatement.setString(2, a_date);
        callableStatement.setString(3, a_time);
        callableStatement.setString(4, a_cost);
        callableStatement.setString(5, doctorFIO[0]);
        callableStatement.setString(6, a_patient);
        callableStatement.setString(7, treaty_ID);
        callableStatement.execute();
    }
}
