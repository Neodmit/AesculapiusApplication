package CRUD;

import Connect.Connect;
import my.Patient;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CRUDPatient {
    private static CallableStatement callableStatement = null;

    public static List<Patient> getPatient() throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("SELECT patient_ID, p_fio, p_address, p_district, p_policy, p_year, p_sign, p_department  FROM patient ORDER BY patient_ID DESC");
        ResultSet res = callableStatement.executeQuery();
        List<Patient> patients = new ArrayList<Patient>();
        while (res.next()) {
            Patient patient = new Patient();
            patient.setPatient_ID(res.getString(1));
            patient.setP_fio(res.getString(2));
            patient.setP_address(res.getString(3));
            patient.setP_district(res.getString(4));
            patient.setP_policy(res.getString(5));
            patient.setP_year(res.getString(6));
            patient.setP_sign(res.getString(7));
            patient.setP_department(res.getString(8));
            patients.add(patient);
        }
        return patients;
    }

    public static void removePatient(String id) throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("DELETE FROM Patient WHERE patient_ID=?");
        callableStatement.setString(1, id);
        callableStatement.execute();
    }

    public static void createPatient(String patient_ID, String p_fio, String p_address, String p_district, String p_policy, String p_year, String p_sign, String p_department) throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("INSERT INTO Patient VALUES(?, ?, ?, ?, ?, ?, ?, ?)");
        callableStatement.setString(1, patient_ID);
        callableStatement.setString(2, p_fio);
        callableStatement.setString(3, p_address);
        callableStatement.setString(4, p_district);
        callableStatement.setString(5, p_policy);
        callableStatement.setString(6, p_year);
        callableStatement.setByte(7, Byte.valueOf(p_sign));
        callableStatement.setString(8, p_department);
        callableStatement.execute();
    }

    public static void changePatient(String patient_ID, String p_fio, String p_address, String p_district, String p_policy, String p_year, String p_sign, String p_department) throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("UPDATE Patient SET patient_ID=?, p_fio=?, p_address=?, p_district=?, p_policy=?, p_year=?, p_sign=?, p_department=? WHERE patient_ID=?");
        callableStatement.setString(1, patient_ID);
        callableStatement.setString(2, p_fio);
        callableStatement.setString(3, p_address);
        callableStatement.setString(4, p_district);
        callableStatement.setString(5, p_policy);
        callableStatement.setString(6, p_year);
        callableStatement.setByte(7, Byte.valueOf(p_sign));
        callableStatement.setString(8, p_department);
        callableStatement.setString(9, patient_ID);
        callableStatement.execute();
    }
}
