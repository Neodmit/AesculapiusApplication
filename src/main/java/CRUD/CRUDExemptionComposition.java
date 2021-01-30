package CRUD;

import Connect.Connect;
import my.ExemptionComposition;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CRUDExemptionComposition {
    private static CallableStatement callableStatement = null;

    public static List<ExemptionComposition> getExemptionComposition() throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("SELECT e_exempt_ID, e_treaty_ID, e_type, a_date, a_time, (SELECT p_fio FROM patient WHERE patient_ID=a_patient_ID), (SELECT concat(d_surname,' ',d_name,' ', d_patronymic) FROM doctor WHERE doctor_ID=a_doctor_ID), e_summa, e_comment  FROM ExemptionComposition " +
                "LEFT JOIN exemption ON e_exempt_ID=exempt_ID " +
                "LEFT JOIN apointment ON e_treaty_ID=treaty_ID " +
                "ORDER BY e_treaty_ID DESC");
        ResultSet res = callableStatement.executeQuery();
        List<ExemptionComposition> exemptionCompositions = new ArrayList<ExemptionComposition>();
        while (res.next()) {
            ExemptionComposition exemptionComposition = new ExemptionComposition();
            exemptionComposition.setE_exempt_ID(res.getString(1));
            exemptionComposition.setE_treaty_ID(res.getString(2));
            exemptionComposition.setE_exempt_type(res.getString(3));
            exemptionComposition.setE_treaty_date(res.getString(4));
            exemptionComposition.setE_treaty_time(res.getString(5));
            exemptionComposition.setE_treaty_patient_fio(res.getString(6));
            exemptionComposition.setE_treaty_doctor_fio(res.getString(7));
            exemptionComposition.setE_summa(res.getString(8));
            exemptionComposition.setE_comment(res.getString(9));
            exemptionCompositions.add(exemptionComposition);
        }
        return exemptionCompositions;
    }

    public static void removeExemptionComposition(String exempt_id, String treaty_id) throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("DELETE FROM ExemptionComposition WHERE e_exempt_ID=? AND e_treaty_ID=?");
        callableStatement.setString(1, exempt_id);
        callableStatement.setString(2, treaty_id);
        callableStatement.execute();
    }

    public static void createExemptionComposition(String e_exempt, String e_treaty, String e_summa, String e_comment) throws SQLException {
        //String exempt[] = e_exempt.split("\\, ");
        String treaty[] = e_treaty.split("\\, ");
        String doctorFIO[] = treaty[2].split("\\s");
        callableStatement = Connect.getConnection().prepareCall("INSERT INTO ExemptionComposition VALUES ((SELECT exempt_ID FROM Exemption WHERE e_type=?), (SELECT treaty_ID FROM apointment WHERE a_date=? AND a_time=? AND a_doctor_ID=(SELECT doctor_ID FROM doctor WHERE d_surname=? AND d_name=? AND d_patronymic=?) AND a_patient_ID=(SELECT patient_ID FROM patient WHERE p_fio=?)), ?, ?)");
        callableStatement.setString(1, e_exempt);
        callableStatement.setString(2, treaty[0]);
        callableStatement.setString(3, treaty[1]);
        callableStatement.setString(4, doctorFIO[0]);
        callableStatement.setString(5, doctorFIO[1]);
        callableStatement.setString(6, doctorFIO[2]);
        callableStatement.setString(7, treaty[3]);
        callableStatement.setString(8, e_summa);
        callableStatement.setString(9, e_comment);
        callableStatement.execute();
    }

    public static void changeExemptionComposition(String e_exempt_type, String e_treaty_date, String e_treaty_time, String e_treaty_doctor, String e_treaty_patient, String e_summa, String e_comment) throws SQLException {
        String doctorFIO[] = e_treaty_doctor.split("\\s");
        callableStatement = Connect.getConnection().prepareCall("UPDATE ExemptionComposition SET e_exempt_ID=(SELECT exempt_ID FROM Exemption WHERE e_type=?), " +
                "e_treaty_ID=(SELECT treaty_ID FROM apointment WHERE a_date=? AND a_time=? AND a_doctor_ID=(SELECT doctor_ID FROM doctor WHERE d_surname=? AND d_name=? AND d_patronymic=?) AND " +
                "a_patient_ID=(SELECT patient_ID FROM patient WHERE p_fio=?)), " +
                "e_summa=?, e_comment=? " +
                "WHERE e_exempt_ID=(SELECT exempt_ID FROM Exemption WHERE e_type=?) AND " +
                "e_treaty_ID=(SELECT treaty_ID FROM apointment WHERE a_date=? AND a_time=? AND a_doctor_ID=(SELECT doctor_ID FROM doctor WHERE d_surname=? AND d_name=? AND d_patronymic=?) AND a_patient_ID=(SELECT patient_ID FROM patient WHERE p_fio=?))");
        callableStatement.setString(1, e_exempt_type);
        callableStatement.setString(2, e_treaty_date);
        callableStatement.setString(3, e_treaty_time);
        callableStatement.setString(4, doctorFIO[0]);
        callableStatement.setString(5, doctorFIO[1]);
        callableStatement.setString(6, doctorFIO[2]);
        callableStatement.setString(7, e_treaty_patient);
        callableStatement.setString(8, e_summa);
        callableStatement.setString(9, e_comment);
        callableStatement.setString(10, e_exempt_type);
        callableStatement.setString(11, e_treaty_date);
        callableStatement.setString(12, e_treaty_time);
        callableStatement.setString(13, doctorFIO[0]);
        callableStatement.setString(14, doctorFIO[1]);
        callableStatement.setString(15, doctorFIO[2]);
        callableStatement.setString(16, e_treaty_patient);
        callableStatement.execute();
    }

}
