from django import forms
from .models import Note

class NoteForm(forms.ModelForm):
    class Meta:
        model = Note
        fields = ['title', 'content', 'tags']
        widgets = {
            'title': forms.TextInput(attrs={'class': 'input', 'placeholder': 'Title'}),
            'content': forms.Textarea(attrs={'class': 'textarea', 'placeholder': 'Your notes...'}),
            'tags': forms.TextInput(attrs={'class': 'input', 'placeholder': 'comma,separated,tags'}),
        }
