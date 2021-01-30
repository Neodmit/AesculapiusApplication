<%@ page import="my.Apointment" %>
<%@ page import="my.Doctor" %>
<%@ page import="my.Patient" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>

<html>
<head>
    <% request.setCharacterEncoding("UTF-8"); %>
    <title>$Title$</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
          integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1"><!--Для разных девайсов-->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <!--Подкл Будстрапа-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script><!--Подкл разного всего-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <!--Подкл разного всего-->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <!--Подкл разного всего-->
</head>
<body class="bg-dark">
<div class="container">
    <div class="row bg-secondary">
        <div class="col-2"><a href="apointment" name="letsgototheapointment"><h1 class="text-warning">Приёмы</h1></a>
        </div>
        <div class="col-2"><a href="doctor" name="letsgotothedoctor"><h1 class="text-warning">Врачи</h1></a></div>
        <div class="col-2"><a href="patient" name="letsgotothepatient"><h1 class="text-warning">Пациенты</h1></a></div>
        <div class="col-2"><a href="exemption" name="letsgototheexemption"><h1 class="text-warning">Льготы</h1></a></div>
        <div class="col-2"><a href="exemptionComposition" name="letsgototheexemptioncomposition"><h1 class="text-warning">Составные льготы</h1></a></div>
    </div>
    <%
        ArrayList<Apointment> todayList = (ArrayList<Apointment>) request.getAttribute("todayList");
        ArrayList<Apointment> allList = (ArrayList<Apointment>) request.getAttribute("allList");
        if (todayList.isEmpty()) { %>
    <div><h1 class="text-success">Сегодня нет приёмов</h1></div>
    <%} else {%>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">#</th>
            <th scope="col">Дата</th>
            <th scope="col">Время</th>
            <th scope="col">Стоимость</th>
            <th scope="col">Врач</th>
            <th scope="col">Пациент</th>
        </tr>
        </thead>
    </table>
    <% for (Apointment apointment : todayList) { %>

    <% }
    } %>
    <div><h1 class="text-success">Список всех приёмов:</h1></div>
    <table class="table">
        <thead>
        <tr class="text-warning">
            <th scope="col">#</th>
            <th scope="col">Дата</th>
            <th scope="col">Время</th>
            <th scope="col">Стоимость</th>
            <th scope="col">Врач</th>
            <th scope="col">Пациент</th>
            <th scope="col"></th>
        </tr>
        </thead>

        <tbody>
        <tr>
            <td>
                <!-- Button to Open the Modal -->
                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal">
                    Добавить запись
                </button>
            </td>
        </tr>
        <%for (Apointment apointment : allList) {%>
        <tr class="text-white">
            <td><%=apointment.getTreaty_ID()%>
            </td>
            <td><%=apointment.getA_date()%>
            </td>
            <td><%=apointment.getA_time()%>
            </td>
            <td><%=apointment.getA_cost()%>
            </td>
            <td><%=apointment.getA_doctor_fio()%>
            </td>
            <td><%=apointment.getA_patient_fio()%>
            </td>
            <td>
                <form action="apointment" method="post">
                    <!-- Button to Open the Modal -->
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#changeModal"
                            id="<%=apointment.getTreaty_ID()%>" onclick="changeID(this.id)">
                        Изменить
                    </button>
                    <input type="submit" class="btn btn-danger" name="remove<%=apointment.getTreaty_ID()%>"
                           value="Удалить">
                </form>
            </td>
        </tr>
        </tbody>
        <%} %>
    </table>
</div>

<!-- The Modal -->
<div class="modal" id="addModal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h1 class="modal-title">Новая запись</h1>
                <button type="button" class="close" data-dismiss="modal">X</button>
            </div>

            <form action="apointment" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>Следующий ID:</h3></p>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_treaty_ID"
                                value="<%=Integer.parseInt(allList.get(0).getTreaty_ID())+1%>"></div>
                    </p>
                    <p>
                    <h3>Введите дату:</h3></p>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_a_date"></div>
                    </p>
                    <p>
                    <h3>Введите время:</h3></p>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_a_time"></div>
                    </p>
                    <p>
                    <h3>Введите стоимость:</h3></p>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_a_cost"></div>
                    </p>
                    <p>
                    <h3>Введите врача:</h3></p>
                    <p><select class="form-control" style="width:100%;font-size:15px" name="add_a_doctor">
                        <%
                            ArrayList<Doctor> doctorList = (ArrayList<Doctor>) request.getAttribute("doctorList");
                            for (Doctor doctor : doctorList) {
                        %>
                        <option><%=doctor.getD_FIO()%>, <%=doctor.getD_born()%>, <%=doctor.getD_type()%>
                        </option>
                        <%}%>
                    </select></p>
                    <p>
                    <h3>Введите пациента:</h3></p>
                    <p><select class="form-control" style="width:100%;font-size:15px" name="add_a_patient">
                        <%
                            ArrayList<Patient> patientList = (ArrayList<Patient>) request.getAttribute("patientList");
                            for (Patient patient : patientList) {
                        %>
                        <option><%=patient.getP_fio()%>, <%=patient.getP_year()%>, <%=patient.getP_address()%>
                        </option>
                        <%}%>
                    </select></p>
                </div>


                <!-- Modal footer -->
                <div class="modal-footer">
                    <input type="submit" class="btn btn-success" name="add" value="Добавить">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Закрыть</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- The Modal -->
<div class="modal" id="changeModal">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h1 class="modal-title">Измените одну или несколько записей</h1>
                <button type="button" class="close" data-dismiss="modal">X</button>
            </div>

            <form action="apointment" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>ID:</h3></p>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeTreatyID"
                                name="change_treaty_ID">
                    </div>
                    </p>
                    <p>
                    <h3>Дата:</h3></p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeADate" name="change_a_date">
                    </div>
                    </p>
                    <p>
                    <h3>Время:</h3></p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeATime" name="change_a_time">
                    </div>
                    </p>
                    <p>
                    <h3>Стоимость:</h3></p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeACost" name="change_a_cost">
                    </div>
                    </p>
                    <p>
                    <h3>Врач:</h3></p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeADoctor" name="change_a_doctor">
                    </div>
                    </p>
                    <p>
                    <h3>Пациент:</h3></p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeAPatient"
                                name="change_a_patient"></div>
                    </p>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <input type="submit" class="btn btn-warning" name="change" value="Изменить">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Закрыть</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>

<script>
    function changeID(val) {
        <%for (Apointment apointment : allList) {%>
        if (val ==<%=apointment.getTreaty_ID()%>) {
            document.getElementById("changeTreatyID").setAttribute("value", val);
            document.getElementById("changeADate").setAttribute("value", "<%=apointment.getA_date()%>");
            document.getElementById("changeATime").setAttribute("value", "<%=apointment.getA_time()%>");
            document.getElementById("changeACost").setAttribute("value", "<%=apointment.getA_cost()%>");
            document.getElementById("changeADoctor").setAttribute("value", "<%=apointment.getA_doctor_fio()%>");
            document.getElementById("changeAPatient").setAttribute("value", "<%=apointment.getA_patient_fio()%>");
        }
        <%}%>
    }
</script>
