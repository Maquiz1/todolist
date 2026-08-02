from django.shortcuts import render

def home(request):
    """Landing page view for the dashboard app."""
    return render(request, 'dashboard/home.html')
