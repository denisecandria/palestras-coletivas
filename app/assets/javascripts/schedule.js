$(function() {
    $("#schedule_activity_id").change(function() {
        activity_id = $("#schedule_activity_id").val();
        activity_desc = $("#schedule_activity_id").find("option:selected").text();

        if (activity_id) {
            $.ajax({
                url : "/activities/",
                data : {
                    id : activity_id
                },
                async : false,
                type : "post",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                },
                dataType : "json",
                success : function(result) {
                    if (!result.error) {
                        if (result.type_activity == "talk") {
                            $("#search_result").show();
                            $("#search_talks").show();
                            $("#search_text").focus();
                        } else {
                            $("#schedule_talk_id").val("");
                            $("#talk_title").val("");
                            $("#div_talk").hide();
                            $("#search_talks").hide();
                            $("#search_result").hide();
                        }
                    }
                }
            });
        }
    });

    $("#search_button").click(function() {
        search_talk();
    });

    $("#search_text").keypress(function(event) {
        if (event.which == 13) {
            search_talk();
            return false;
        }
    });

    $('#edit_schedule_' + $('#schedule_schedule_id').val()).submit(function() {
        if ($("#search_talks").is(":visible")) {
            if ($("#schedule_talk_id").val() == "") {
                alert($("#alert_enter_talks").val());
                $("#search_text").focus();
                return false;
            }
        }
    });

    $("#schedule_activity_id").trigger("change");
    $("#schedule_date").focus();
});

function search_talk() {
    search_text = $("#search_text").val();
    titles_talks_select = $("#titles_talks_select").val();

    talks = "";

    if (search_text.length > 0) {
        $.getJSON('/schedules/search-talks/' + search_text, function(json) {
            if (json) {
                for (var i in json) {
                    thumb = json[i].thumbnail ? json[i].thumbnail : '/assets/without_presentation.jpg';

                    talks += '<hr />';
                    talks += '<div id="div_' + json[i]._id['$oid'] + '" class="talk">';
                    talks += '  <div class="container">';
                    talks += '    <div class="row">';
                    talks += '      <div class="col-md-2">';
                    talks += '        <img src="' + thumb + '" class="img-thumbnail" />';
                    talks += '        <input type="button" id="' + json[i]._id['$oid'] + '" title="' + json[i].title + '" class="btn btn-success btn-select-talk" value="' + titles_talks_select + '" />';
                    talks += '      </div>';
                    talks += '      <div class="col-md-10">';
                    talks += '        <h4><a href="/talks/' + json[i]._slugs[0] + '">' + json[i].title +'</a></h4>';
                    talks += '        <p>' + json[i].description + '</p>';
                    talks += '        <p>' + json[i].tags + '</p>';
                    talks += '      </div>';
                    talks += '    </div>';
                    talks += '  </div>';
                    talks += '</div>';
                }

                $("#search_result").html(talks);

                $(".btn-select-talk").click(function() {
                    talk_id = $(this).attr("id");
                    talk_title = $(this).attr("title");

                    $(".talk").each(function(index) {
                        $(this).css("background-color", "white");
                    });

                    $("#div_" + talk_id).css("background-color", "#CCFF99");

                    $("#schedule_talk_id").val(talk_id);
                    $("#talk_title").val(talk_title);
                    $("#div_talk").show();
                });
            }
        });
    } else {
        $("#search_result").html(talks);
    }
}
