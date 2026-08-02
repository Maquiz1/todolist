from django.urls import reverse_lazy
from django.views.generic import ListView, CreateView, DetailView, UpdateView, DeleteView
from .models import Note
from .forms import NoteForm

class NoteListView(ListView):
    model = Note
    template_name = 'todo/note_list.html'
    context_object_name = 'notes'
    ordering = ['-created_at']

    def get_queryset(self):
        # Show only notes belonging to the logged‑in user
        if self.request.user.is_authenticated:
            return Note.objects.filter(user=self.request.user)
        return Note.objects.none()

class NoteCreateView(CreateView):
    model = Note
    form_class = NoteForm
    template_name = 'todo/note_form.html'
    success_url = reverse_lazy('note-list')

    def form_valid(self, form):
        # Associate the note with the current user
        if self.request.user.is_authenticated:
            form.instance.user = self.request.user
        return super().form_valid(form)

class NoteDetailView(DetailView):
    model = Note
    template_name = 'todo/note_detail.html'
    context_object_name = 'note'

    def get_queryset(self):
        if self.request.user.is_authenticated:
            return Note.objects.filter(user=self.request.user)
        return Note.objects.none()

class NoteUpdateView(UpdateView):
    model = Note
    form_class = NoteForm
    template_name = 'todo/note_form.html'
    success_url = reverse_lazy('note-list')

    def get_queryset(self):
        if self.request.user.is_authenticated:
            return Note.objects.filter(user=self.request.user)
        return Note.objects.none()

class NoteDeleteView(DeleteView):
    model = Note
    template_name = 'todo/note_confirm_delete.html'
    success_url = reverse_lazy('note-list')

    def get_queryset(self):
        if self.request.user.is_authenticated:
            return Note.objects.filter(user=self.request.user)
        return Note.objects.none()
