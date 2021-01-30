package CRUD;

import Connect.Connect;
import my.Exemption;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CRUDExemption {
    private static CallableStatement callableStatement = null;

    public static List<Exemption> getExemption() throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("SELECT exempt_ID, e_type, e_exempt  FROM exemption ORDER BY exempt_ID DESC");
        ResultSet res = callableStatement.executeQuery();
        List<Exemption> exemptions = new ArrayList<Exemption>();
        while (res.next()) {
            Exemption exemption = new Exemption();
            exemption.setExempt_ID(res.getString(1));
            exemption.setE_type(res.getString(2));
            exemption.setE_exempt(res.getString(3));
            exemptions.add(exemption);
        }
        return exemptions;
    }

    public static void removeExemption(String id) throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("DELETE FROM Exemption WHERE exempt_ID=?");
        callableStatement.setString(1, id);
        callableStatement.execute();
    }

    public static void createExemption(String exempt_ID, String e_type, String e_exempt) throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("INSERT INTO Exemption VALUES(?, ?, ?)");
        callableStatement.setString(1, exempt_ID);
        callableStatement.setString(2, e_type);
        callableStatement.setString(3, e_exempt);
        callableStatement.execute();
    }

    public static void changeExemption(String exempt_ID, String e_type, String e_exempt) throws SQLException {
        callableStatement = Connect.getConnection().prepareCall("UPDATE Exemption SET exempt_ID=?, e_type=?, e_exempt=? WHERE exempt_ID=?");
        callableStatement.setString(1, exempt_ID);
        callableStatement.setString(2, e_type);
        callableStatement.setString(3, e_exempt);
        callableStatement.setString(4, exempt_ID);
        callableStatement.execute();
    }

}
