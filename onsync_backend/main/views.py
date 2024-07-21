#VIEW.PY
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json

@csrf_exempt
def control_coffee_machine(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            command = data.get('command')
            if command in ['ON', 'OFF']:
                # Add your logic to control the coffee machine here
                return JsonResponse({'status': 'success', 'command': command})
            else:
                return JsonResponse({'status': 'error', 'message': 'Invalid command'}, status=400)
        except json.JSONDecodeError:
            return JsonResponse({'status': 'error', 'message': 'Invalid JSON'}, status=400)
    return JsonResponse({'status': 'error', 'message': 'Invalid request method'}, status=400)
