<%@ page import="my.Apointment" %>
<%@ page import="my.Exemption" %>
<%@ page import="my.ExemptionComposition" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <div class="col-2"><a href="exemption" name="letsgototheexemption"><h1 class="text-warning">Льготы</h1></a>
        </div>
        <div class="col-2"><a href="exemptionComposition" name="letsgototheexemptioncomposition"><h1
                class="text-warning">Составные льготы</h1></a></div>
    </div>
    <%
        ArrayList<ExemptionComposition> exemptionCompositionList = (ArrayList<ExemptionComposition>) request.getAttribute("exemptionCompositionList");
        ArrayList<Exemption> exemptionList = (ArrayList<Exemption>) request.getAttribute("exemptionList");
        ArrayList<Apointment> apointmentList = (ArrayList<Apointment>) request.getAttribute("apointmentList");
    %>
    <div><h1 class="text-success">Список всех льгот:</h1></div>
    <table class="table">
        <thead>
        <tr class="text-warning">
            <th scope="col">Название льготы</th>
            <th scope="col">Дата приёма</th>
            <th scope="col">Время</th>
            <th scope="col">Пациент</th>
            <th scope="col">Врач</th>
            <th scope="col">К оплате</th>
            <th scope="col">Комментарий</th>
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

        <%
            for (ExemptionComposition exemptionComposition : exemptionCompositionList) {

        %>
        <tr class="text-white">
            <td><%=exemptionComposition.getE_exempt_type()%>
            </td>
            <td><%=exemptionComposition.getE_treaty_date()%>
            </td>
            <td><%=exemptionComposition.getE_treaty_time()%>
            </td>
            <td><%=exemptionComposition.getE_treaty_patient_fio()%>
            </td>
            <td><%=exemptionComposition.getE_treaty_doctor_fio()%>
            </td>
            <td><%=exemptionComposition.getE_summa()%>
            </td>
            <td><%=exemptionComposition.getE_comment()%>
            </td>

            <td>
                <form action="exemptionComposition" method="post">
                    <!-- Button to Open the Modal -->
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#changeModal"
                            id="<%=exemptionComposition.getE_exempt_ID()%>, <%=exemptionComposition.getE_treaty_ID()%>"
                            onclick="changeID(this.id)">
                        Изменить
                    </button>
                    <br><br/>
                    <input type="submit" class="btn btn-danger"
                           name="remove<%=exemptionComposition.getE_exempt_ID()%>, <%=exemptionComposition.getE_treaty_ID()%>"
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

            <form action="exemptionComposition" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>Выберите льготу:</h3>
                    <p><select class="form-control" style="width:100%;font-size:15px" name="add_e_exempt">
                        <%
                            for (Exemption exemption : exemptionList) {
                        %>
                        <option><%=exemption.getE_type()%>
                        </option>
                        <%}%>
                    </select></p>
                    <p>
                    <h3>Следующий ID льгот:</h3>
                    <p><select class="form-control" style="width:100%;font-size:15px" name="add_e_treaty">
                        <%
                            for (Apointment apointment : apointmentList) {
                        %>
                        <option><%=apointment.getA_date()%>, <%=apointment.getA_time()%>
                            , <%=apointment.getA_doctor_fio()%>, <%=apointment.getA_patient_fio()%>
                        </option>
                        <%}%>
                    </select></p>
                    <p>
                    <h3>Введите к оплате:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_e_summa"></div>
                    <p>
                    <h3>Введите коммент:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_e_comment"></div>
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
    <!--Вообще по хорошему если во вставить есть выпадающий список, то и в изменить он тоже должен быть-->
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h1 class="modal-title">Измените одну или несколько записей</h1>
                <button type="button" class="close" data-dismiss="modal">X</button>
            </div>

            <form action="exemptionComposition" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>Название льготы:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeEExemptType"
                                    name="change_E_Exempt_Type"></div>
                    <p>
                    <h3>Дата приёма:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeETreatyDate"
                                name="change_e_treaty_date"></div>
                    <p>
                    <h3>Время:</h3>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeETreatyTime"
                                name="change_e_treaty_time"></div>
                    <p>
                    <h3>Пациент:</h3>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeETreatyPatient"
                                name="change_e_treaty_patient"></div>
                    <p>
                    <h3>Врач:</h3>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeETreatyDoctor"
                                name="change_e_treaty_doctor"></div>
                    <p>
                    <h3>К оплате:</h3>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeESumma" name="change_e_summa">
                    </div>
                    <p>
                    <h3>Комментарий:</h3>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeEComment"
                                name="change_e_comment"></div>
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
        <%for (ExemptionComposition exemptionComposition : exemptionCompositionList) {%>
        if (val.split(", ")[0] == <%=exemptionComposition.getE_exempt_ID()%> && val.split(", ")[1] ==<%=exemptionComposition.getE_treaty_ID()%>) { 
            document.getElementById("changeEExemptType").setAttribute("value", "<%=exemptionComposition.getE_exempt_type()%>");
            document.getElementById("changeETreatyDate").setAttribute("value", "<%=exemptionComposition.getE_treaty_date()%>");
            document.getElementById("changeETreatyTime").setAttribute("value", "<%=exemptionComposition.getE_treaty_time()%>");
            document.getElementById("changeETreatyPatient").setAttribute("value", "<%=exemptionComposition.getE_treaty_patient_fio()%>");
            document.getElementById("changeETreatyDoctor").setAttribute("value", "<%=exemptionComposition.getE_treaty_doctor_fio()%>");
            document.getElementById("changeESumma").setAttribute("value", "<%=exemptionComposition.getE_summa()%>");
            document.getElementById("changeEComment").setAttribute("value", "<%=exemptionComposition.getE_comment()%>");
        }
        <%}%>
    }
</script>

