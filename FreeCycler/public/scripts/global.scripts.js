$(document).ready(function() {

    $('.requestOfferButtons .btn').click(function(){

        var type = $(this).attr("data-type");

        $('.requestOfferForm #postType').val(type);

        $('.requestOfferButtons').addClass('hidden');
        $('.requestOfferForm').removeClass('hidden');
    });

    $('.requestOfferForm .cancelButton').click(function(){
        $('.requestOfferButtons').removeClass('hidden');
        $('.requestOfferForm').addClass('hidden');
    });

    $('#postCommentForm .btn-primary').click(function(event){
        event.preventDefault();
        var params = $(this).parents('form').serialize();
        var button = $(this);
        $.ajax({
            type: "POST",
            url: "/index/saveComment",
            data: params
        })
        .done(function( serverResponse ) {
             console.log(serverResponse);

             var html = '';
             html += '<div class="comment">';
             if(current_user_profilePhotoUrl.length == 0) {
                 html += '<img class="commentProfilePhoto" src="/images/koala.jpg" alt="" />';
             } else {
                 html += '<img class="commentProfilePhoto" src="/images/profilePhotos/'+current_user_profilePhotoUrl+'" alt="" />';
             }
             html += '<div class="commentTextParent"><span><strong>'+current_user_name+':</strong> '+serverResponse.commentText+'</span></div>';
             html += '<div class="commentDateTimeParent"><span>'+serverResponse.created_at+'</span></div>'
             html += '</div>';

             $(html).insertBefore($('#commentsList_' + serverResponse.post_id + ' form'));

             button.parents('form').find('#commentText').val('');

        });
    });

});