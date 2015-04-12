$(function() {
    $("#searching_talk").hide();
    $("#talk_not_found").hide();

    $("#talk_presentation_url").focusout(function() {
        var link = $("#talk_presentation_url").val();

        if (link) {
            $("#searching_talk").show();

            $.ajax({
                url : "/talks/info_url",
                data : {
                    link : link
                },
                async : false,
                type : "post",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
                },
                dataType : "json",
                success : function(result) {
                    if (result.error) {
                        $("#searching_talk").hide();
                        $("#talk_not_found").show();
                        $("#talk_presentation_url").val("");
                        $("#talk_presentation_url").focus();
                    } else {
                        $("#talk_not_found").hide();
                        $("#talk_title").val(result.title);
                        $("#talk_code").val(result.code);
                        $("#talk_thumbnail").val(result.thumbnail);
                        if (result.description) {
                            $("#talk_description").val(result.description);
                        }
                    }
                }
            });

            $("#searching_talk").hide("slow");
        }
    });
});