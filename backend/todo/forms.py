from django import forms
from .models import Task


class TaskForm(forms.ModelForm):
    class Meta:
        model = Task
        fields = ['title', 'description', 'completed']
        widgets = {
            'title': forms.TextInput(attrs={'class': 'input', 'placeholder': 'Title'}),
            'description': forms.Textarea(attrs={'class': 'textarea', 'placeholder': 'Description', 'rows': 3}),
            'completed': forms.CheckboxInput(attrs={'class': 'checkbox'}),
        }
