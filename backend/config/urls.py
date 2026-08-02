# URL configuration for project config.
# The urlpatterns list routes URLs to views. See Django docs for details.
# (Docstring removed for clarity)
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('', include('dashboard.urls')),
    path('todo/', include('todo.urls')),
    path('notes/', include('notes.urls')),
    path('admin/', admin.site.urls),
    path('accounts/', include('django.contrib.auth.urls')),
]
