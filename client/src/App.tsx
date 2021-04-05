import React from "react";
import { BrowserRouter as Router, Route } from "react-router-dom";
import { AuthProvider } from "./contexts/auth";
import HomePage from "./pages/HomePage";
import LoginPage from "./pages/LoginPage";
import PostPage from "./pages/PostPage";
import RegisterPage from "./pages/RegisterPage";
import UserPage from "./pages/UserPage";

function App() {
  return (
    <div className="App">
      <AuthProvider>
        <Router>
          <Route exact path={["/", "/news"]} component={HomePage} />
          <Route exact path="/newest" component={HomePage} />
          <Route exact path="/ask" component={HomePage} />
          <Route exact path="/show" component={HomePage} />
          <Route exact path="/jobs" component={HomePage} />
          <Route exact path="/post/:id" component={PostPage} />
          <Route exact path="/user/:id" component={UserPage} />
          <Route exact path="/login" component={LoginPage} />
          <Route exact path="/register" component={RegisterPage} />
        </Router>
      </AuthProvider>
    </div>
  );
}

export default App;
