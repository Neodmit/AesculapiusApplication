package CRUD;

import Connect.Connect;
import my.Doctor;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CRUDDoctor {
    private static CallableStatement callableStatement = null;

    public static List<Doctor> getDoctor() throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("SELECT doctor_ID, concat(d_surname,' ',d_name,' ', d_patronymic), d_room, d_university, d_type, d_experience, d_phone, d_born  FROM doctor ORDER BY doctor_ID DESC");
        ResultSet res = callableStatement.executeQuery();
        List<Doctor> doctors = new ArrayList<Doctor>();
        while (res.next()) {
            Doctor doctor = new Doctor();
            doctor.setDoctor_ID(res.getString(1));
            doctor.setD_FIO(res.getString(2));
            doctor.setD_room(res.getString(3));
            doctor.setD_university(res.getString(4));
            doctor.setD_type(res.getString(5));
            doctor.setD_experience(res.getString(6));
            doctor.setD_phone(res.getString(7));
            doctor.setD_born(res.getString(8));
            doctors.add(doctor);
        }
        return doctors;
    }

    public static void removeDoctor(String id) throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("DELETE FROM Doctor WHERE doctor_ID=?");
        callableStatement.setString(1, id);
        callableStatement.execute();
    }

    public static void createDoctor(String doctor_ID, String d_FIO, String d_room, String d_university, String d_type, String d_experience, String d_phone, String d_born) throws  SQLException{
        String doctorFIO[] = d_FIO.split("\\s");
        callableStatement = Connect.getConnection().prepareCall("INSERT INTO Doctor VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NULL)");
        callableStatement.setString(1, doctor_ID);
        callableStatement.setString(2, doctorFIO[1]);
        callableStatement.setString(3, doctorFIO[0]);
        callableStatement.setString(4, doctorFIO[2]);
        callableStatement.setString(5, d_room);
        callableStatement.setString(6, d_university);
        callableStatement.setString(7, d_type);
        callableStatement.setString(8, d_experience);
        callableStatement.setString(9, d_phone);
        callableStatement.setString(10, d_born);
        callableStatement.execute();
    }

    public static void changeDoctor(String doctor_ID, String d_FIO, String d_room, String d_university, String d_type, String d_experience, String d_phone, String d_born) throws  SQLException{
        String doctorFIO[] = d_FIO.split("\\s");
        callableStatement = Connect.getConnection().prepareCall("UPDATE Doctor SET doctor_ID=?, d_name=?, d_surname=?, d_patronymic=?, d_room=?, d_university=?, d_type=?, d_experience=?, d_phone=?, d_born=? WHERE doctor_ID=?");
        callableStatement.setString(1, doctor_ID);
        callableStatement.setString(2, doctorFIO[1]);
        callableStatement.setString(3, doctorFIO[0]);
        callableStatement.setString(4, doctorFIO[2]);
        callableStatement.setString(5, d_room);
        callableStatement.setString(6, d_university);
        callableStatement.setString(7, d_type);
        callableStatement.setString(8, d_experience);
        callableStatement.setString(9, d_phone);
        callableStatement.setString(10, d_born);
        callableStatement.setString(11, doctor_ID);
        callableStatement.execute();
    }
}
