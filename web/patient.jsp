<%@ page import="my.Patient" %>
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
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
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
    <%ArrayList<Patient> patientList = (ArrayList<Patient>) request.getAttribute("patientList");%>
    <div><h1 class="text-success">Список всех пациентов:</h1></div>
    <table class="table">
        <thead>
        <tr class="text-warning">
            <th scope="col">#</th>
            <th scope="col">ФИО</th>
            <th scope="col">Адрес</th>
            <th scope="col">Район</th>
            <th scope="col">Полис</th>
            <th scope="col">Год рождения</th>
            <th scope="col">Работа на преприятие</th>
            <th scope="col">Отдел</th>
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

        <%for (Patient patient : patientList) {%>
        <tr class="text-white">
            <td><%=patient.getPatient_ID()%>
            </td>
            <td><%=patient.getP_fio()%>
            </td>
            <td><%=patient.getP_address()%>
            </td>
            <td><%=patient.getP_district()%>
            </td>
            <td><%=patient.getP_policy()%>
            </td>
            <td><%=patient.getP_year()%>
            </td>
            <td>
                <ul class="fa-ul">
                    <%if (patient.getP_sign().equals("1")) {%>
                    <li>
                    <li><i class="fa-li fa fa-check-square"></i></li>
                    <%} else {%>
                    <li><i class="fa-li fa fa-minus-square"></i></li>
                    <%}%>
                </ul>
            </td>
            <td><%if (patient.getP_department() != null) {%>
                <%=patient.getP_department()%>
                <%}%>
            </td>
            <td>
                <form action="patient" method="post">
                    <!-- Button to Open the Modal -->
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#changeModal"
                            id="<%=patient.getPatient_ID()%>" onclick="changeID(this.id)">
                        Изменить
                    </button>
                    <br><br/>
                    <input type="submit" class="btn btn-danger" name="remove<%=patient.getPatient_ID()%>"
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

            <form action="patient" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>Следующий ID:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_patient_ID"
                                value="<%=Integer.parseInt(patientList.get(0).getPatient_ID())+1%>"></div>
                    <p>
                    <h3>Введите ФИО:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_p_FIO"></div>
                    <p>
                    <h3>Введите адрес:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_p_address"></div>
                    <p>
                    <h3>Введите район:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_p_district"></div>
                    <p>
                    <h3>Введите полис:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_p_policy"></div>
                    <p>
                    <h3>Введите год рождения:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_p_year"></div>
                    <p>
                    <h3>Отметка работы на предприятии:</h3>
                    <p>
                        <div class="form-check" >
                            <label class="form-check-label">
                                <h4><input type="radio" class="form-check-input" name="add_p_sign" value="1" onclick="PSign(this.value)">лаРаботает на предприятии</h4>
                            </label>
                        </div>
                        <div class="form-check" >
                            <label class="form-check-label">
                                <h4><input type="radio" class="form-check-input" name="add_p_sign" value="0" onclick="PSign(this.value)">лаНе работает на предприятии</h4>
                            </label>
                        </div>
                    <p>
                        <h3>Отдел, если человек работает на предприятии:</h3>
                    <p>
                        <div><input type="text" style="width:100%;font-size:15px" name="add_p_department" id="addPDepartment"></div>
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

            <form action="patient" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>ID:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changePatientID"
                                name="change_patient_ID"></div>
                    <p>
                    <h3>ФИО:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changePFIO" name="change_p_FIO">
                    </div>
                    <p>
                    <h3>Адрес:</h3>
                    <p></p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changePAddress"
                                name="change_p_address">
                    </div>
                    <p>
                    <h3>Район:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changePDistrict"
                                name="change_p_district">
                    </div>
                    <p>
                    <h3>Полис:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changePPolicy" name="change_p_policy">
                    </div>
                    <p>
                    <h3>Год рождения:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changePYear"
                                name="change_p_year"></div>
                    <p>
                    <h3>Работа на предприятии:</h3>
                    <p>
                        <div class="form-check">
                                <label class="form-check-label">
                                    <h4><input type="radio" class="form-check-input"  name="change_p_sign" id="changePSign1" value="1" onclick="PSign(this.value)" >лаРаботает</h4>
                                </label>
                        </div>
                        <div class="form-check">
                                <label lass="form-check-label">
                                    <h4><input type="radio" class="form-check-input"  name="change_p_sign" id="changePSign0" value="0" onclick="PSign(this.value)">лаНе работает</h4>
                                </label>
                        </div>
                    <p>
                        <h3>Отдел:</h3>
                        <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changePDepartment"
                            name="change_p_department"></div>
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
    function changeID(id) {
        <%for (Patient patient : patientList) {%>
            if (id==<%=patient.getPatient_ID()%>) {
                document.getElementById("changePatientID").setAttribute("value", id);
                document.getElementById("changePFIO").setAttribute("value", "<%=patient.getP_fio()%>");
                document.getElementById("changePAddress").setAttribute("value", "<%=patient.getP_address()%>");
                document.getElementById("changePDistrict").setAttribute("value", "<%=patient.getP_district()%>");
                document.getElementById("changePPolicy").setAttribute("value", "<%=patient.getP_policy()%>");
                document.getElementById("changePYear").setAttribute("value", "<%=patient.getP_year()%>");
                if (0==<%=patient.getP_sign()%>){
                    document.getElementById("changePDepartment").value=null;
                    document.getElementById("changePSign0").checked=true;
                    document.getElementById("changePDepartment").setAttribute("disabled","");
                }
                else{
                    document.getElementById("changePSign1").checked=true;
                    document.getElementById("changePDepartment").removeAttribute("disabled");
                    document.getElementById("changePDepartment").value="<%=patient.getP_department()%>";
                }
            }
        <%}%>
    }

    function PSign(val) {
        if(val==0){
            document.getElementById("addPDepartment").setAttribute("disabled","");
            document.getElementById("changePDepartment").setAttribute("disabled","");
            document.getElementById("addPDepartment").value=null;
            document.getElementById("changePDepartment").value=null;
        }
        else {
            document.getElementById("addPDepartment").removeAttribute("disabled");
            document.getElementById("changePDepartment").removeAttribute("disabled");
        }
    }
</script>


