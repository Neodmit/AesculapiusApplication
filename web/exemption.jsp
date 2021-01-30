<%@ page import="my.Exemption" %>
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
    <%ArrayList<Exemption> exemptionList = (ArrayList<Exemption>) request.getAttribute("exemptionList");%>
    <div><h1 class="text-success">Список всех льгот:</h1></div>
    <table class="table">
        <thead>
        <tr class="text-warning">
            <th scope="col">#</th>
            <th scope="col">Название льготы</th>
            <th scope="col">Сумма льготы</th>
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

        <%for (Exemption exemption : exemptionList) {%>
        <tr class="text-white">
            <td><%=exemption.getExempt_ID()%>
            </td>
            <td><%=exemption.getE_type()%>
            </td>
            <td><%=exemption.getE_exempt()%>
            </td>

            <td>
                <form action="exemption" method="post">
                    <!-- Button to Open the Modal -->
                    <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#changeModal"
                            id="<%=exemption.getExempt_ID()%>" onclick="changeID(this.id)">
                        Изменить
                    </button>
                    <br><br/>
                    <input type="submit" class="btn btn-danger" name="remove<%=exemption.getExempt_ID()%>"
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

            <form action="exemption" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>Следующий ID:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_exempt_ID"
                                value="<%=Integer.parseInt(exemptionList.get(0).getExempt_ID())+1%>"></div>
                    <p>
                    <h3>Введите название:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_e_type"></div>
                    <p>
                    <h3>Введите сумму:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" name="add_e_exempt"></div>
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

            <form action="exemption" method="post">
                <!-- Modal body -->
                <div class="modal-body">
                    <p>
                    <h3>ID:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeExemptID"
                                name="change_exempt_ID"></div>
                    <p>
                    <h3>Название льготы:</h3>
                    <p>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeEType" name="change_e_type"></div>
                    <p>
                    <h3>Сумма льготы:</h3>
                    <div><input type="text" style="width:100%;font-size:15px" id="changeEExempt" name="change_e_exempt"></div>
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
        <%for (Exemption exemption : exemptionList) {%>
        if (val ==<%=exemption.getExempt_ID()%>) {
            document.getElementById("changeExemptID").setAttribute("value", val);
            document.getElementById("changeEType").setAttribute("value", "<%=exemption.getE_type()%>");
            document.getElementById("changeEExempt").setAttribute("value", "<%=exemption.getE_exempt()%>");
        }
        <%}%>
    }
</script>

