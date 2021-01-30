<%@ page import="my.Doctor" %>
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
        <div class="col-2"><a href="exemption" name="letsgototheexemption"><h1 class="text-warning">Льготы</h1></a></div>
        <div class="col-2"><a href="exemptionComposition" name="letsgototheexemptioncomposition"><h1 class="text-warning">Составные льготы</h1></a></div>
    </div>
    <%ArrayList<Doctor> doctorList = (ArrayList<Doctor>) request.getAttribute("doctorList");%>
    <div><h1 class="text-success">Список всех врачей:</h1></div>
    <table class="table">
        <thead>
        <tr class="text-warning">
            <th scope="col">#</th>
            <th scope="col">ФИО</th>
            <th scope="col">Кабинет</th>
            <th scope="col">Университет</th>
            <th scope="col">Спициализация</th>
            <th scope="col">Опыт</th>
            <th scope="col">Номер телефона</th>
            <th scope="col">Год рождения</th>
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

        <%for (Doctor doctor : doctorList) {%>
        <tr class="text-white">
            <td><%=doctor.getDoctor_ID()%>
            </td>
            <td><%=doctor.getD_FIO()%>
            </td>
            <td><%=doctor.getD_room()%>
            </td>
            <td><%=doctor.getD_university()%>
            </td>
            <td><%=doctor.getD_type()%>
            </td>
            <td><%=doctor.getD_experience()%>
            </td>
            <td><%=doctor.getD_phone()%>
            </td>
            <td><%=doctor.getD_born()%>
            </td>
            <td>
                <form action="doctor" method="post">
                    <!-- Button to Open the Modal -->
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#changeModal"
                            id="<%=doctor.getDoctor_ID()%>" onclick="changeID(this.id)">
                        Изменить
                    </button>
                    <br><br/>
                    <input type="submit" class="btn btn-danger" name="remove<%=doctor.getDoctor_ID()%>"
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

            <form action="doctor" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>Следующий ID:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_doctor_ID"
                                value="<%=Integer.parseInt(doctorList.get(0).getDoctor_ID())+1%>"></div>
                    <p>
                    <h3>Введите ФИО:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_d_FIO"></div>
                    <p>
                    <h3>Введите кабинет:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_d_room"></div>
                    <p>
                    <h3>Введите университет:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_d_university"></div>
                    <p>
                    <h3>Введите специализацию:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_d_type"></div>
                    <p>
                    <h3>Введите опыт работы:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_d_experience"></div>
                    <p>
                    <h3>Введите номер телефона:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_d_phone"></div>
                    <p>
                    <h3>Введите год рождения:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_d_born"></div>
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

            <form action="doctor" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>ID:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeDoctorID"
                                name="change_doctor_ID"></div>
                    <p>
                    <h3>ФИО:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeDFIO" name="change_d_FIO">
                    </div>
                    <p>
                    <h3>Кабинет:</h3>
                    <p></p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeDRoom" name="change_d_room">
                    </div>
                    <p>
                    <h3>Университет:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeDUniversity"
                                name="change_d_university">
                    </div>
                    <p>
                    <h3>Специализация:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeDType" name="change_d_type">
                    </div>
                    <p>
                    <h3>Опыт:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeDExperience"
                                name="change_d_experience"></div>
                    <p>
                    <h3>Номер телефона:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeDPhone"
                                name="change_d_phone"></div>
                    <p>
                    <h3>Год рождения:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeDBorn"
                                name="change_d_born"></div>
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
        <%for (Doctor doctor : doctorList) {%>
        if (val ==<%=doctor.getDoctor_ID()%>) {
            document.getElementById("changeDoctorID").setAttribute("value", val);
            document.getElementById("changeDFIO").setAttribute("value", "<%=doctor.getD_FIO()%>");
            document.getElementById("changeDRoom").setAttribute("value", "<%=doctor.getD_room()%>");
            document.getElementById("changeDUniversity").setAttribute("value", "<%=doctor.getD_university()%>");
            document.getElementById("changeDType").setAttribute("value", "<%=doctor.getD_type()%>");
            document.getElementById("changeDExperience").setAttribute("value", "<%=doctor.getD_experience()%>");
            document.getElementById("changeDPhone").setAttribute("value", "<%=doctor.getD_phone()%>");
            document.getElementById("changeDBorn").setAttribute("value", "<%=doctor.getD_born()%>");
        }
        <%}%>
    }
</script>
