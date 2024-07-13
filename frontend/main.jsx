import * as React from 'react';
import { createRoot } from 'react-dom/client';
import { ToastContainer } from 'react-toastify';
  import 'react-toastify/dist/ReactToastify.css';
import {
  createBrowserRouter,
  RouterProvider,
} from "react-router-dom";
import * as TodoListComponent from './src/TodoList';

const router = createBrowserRouter([
  {
    path: "/",
    element: <TodoListComponent.TodoList />,
    loader: TodoListComponent.loader
  },
]);

const root = createRoot(document.getElementById('root'))
root.render(<React.StrictMode><RouterProvider router={router} /><ToastContainer /></React.StrictMode>);
