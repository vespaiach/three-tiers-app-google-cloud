import { toast } from 'react-toastify';

export async function callApi (url, args) {
  try {
    const response = await fetch(`${import.meta.env.VITE_API_BASE_URL}${url}`, args);
    if (!response.ok) {
      toast.error(response.statusText);
      return { success: false };
    }
    return await response.json();
  } catch {
    toast.error('Network error!');
    return { success: false };
  }
}
