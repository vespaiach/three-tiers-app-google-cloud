import { useLoaderData } from 'react-router-dom';
import { callApi } from './api';

export async function loader () {
  return callApi('/todo_items.json')
}

export function TodoList () {
  const items = useLoaderData()
  return (
    <div>
      <h1>Todo List</h1>
      <ul>
        {items.map(item => <li key={item.id}>{item.name} - due: {new Date(item.due).toLocaleString()}</li>)}
      </ul>
    </div>
  );
}
