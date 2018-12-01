// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
var quillSettings = {
    modules: {
        toolbar: [
            ['bold', 'italic', 'underline', 'strike'],
            ['link', 'blockquote', 'code-block'],
            [{ list: 'ordered' }, { list: 'bullet' }], ['send']
        ]
    },
    placeholder: "Enter your comment",
    theme: 'snow'
};
var createEditor = new Quill('#editor', quillSettings);

var form = document.querySelector(".comment-form form");
var sendButton = createEditor.container.parentElement.querySelector('.ql-send');
var textInput = form.querySelector('input[name="comment[text]"]');

sendButton.addEventListener('click', function() {
  if (createEditor.getLength() > 0) {
    textInput.value = createEditor.root.innerHTML;
    form.submit();
  }
  else {
      alert("Please enter a comment!");
  }
});

window.editEditor = {};

document.querySelectorAll(".edit-comment").forEach(el => el.addEventListener("click", function(event) {
    event.preventDefault();
    var commentID = this.getAttribute('data-id');
    
    if(this.parentElement.parentElement.querySelector('.ql-container') == undefined && this.querySelector('.ql-container') == null) {
        window.editEditor[commentID] =  new Quill(this.parentElement.parentElement.getElementsByClassName("comment-text")[0], quillSettings);
    }
    var editEditor = window.editEditor[commentID];
    var editorParent = editEditor.container.parentElement;
    var sendButton = editorParent.querySelector('.ql-send');

    editorParent.classList.remove('inactive');
    editEditor.enable(true);
    
    sendButton.addEventListener("click", function(event) {
        if (editEditor.getLength() > 0) {
            var xhttp = new XMLHttpRequest();
            var value = JSON.stringify({ 
                comment: {
                    text: editEditor.root.innerHTML
                }
            });
            console.log(value);
            xhttp.open("PUT", window.location.href + "/comments/" + commentID, true);
            xhttp.setRequestHeader("Content-Type", "application/json");
            xhttp.setRequestHeader("X-CSRF-Token", document.querySelector("meta[name='csrf-token']").getAttribute('content'));
            xhttp.send(value);
            
            editEditor.container.parentElement.classList.add('inactive');
            editEditor.enable(false);
        }
        else {
            alert("Please enter something!");
        }
    });
}));