import axios from "axios";
import React, { useContext } from "react";
import { Link } from "react-router-dom";
import { AuthContext } from "../contexts/auth";

function Navbar() {
  const auth = useContext(AuthContext);

  return (
    <nav className="w-100 h-auto flex items-center text-sm bg-gradient-to-r from-purple-400 via-purple-300 to-purple-300">
      <span className="w-5 h-5 grid place-items-center font-semibold border border-white text-white leading-none m-1">
        E
      </span>
      <h1 className="font-bold">
        <Link to="/news">Elixir News</Link>
      </h1>
      <span className="ml-3 mr-1">
        <Link to="/newest">new</Link>
      </span>
      |
      <span className="mx-1">
        <Link to="/comments">comments</Link>
      </span>
      |
      <span className="mx-1">
        <Link to="/ask">ask</Link>
      </span>
      |
      <span className="mx-1">
        <Link to="/show">show</Link>
      </span>
      |
      <span className="ml-1">
        <Link to="/jobs">jobs</Link>
      </span>
      {auth.authenticated && (
        <>
          |
          <span className="ml-1">
            <Link to="/submit">submit</Link>
          </span>
        </>
      )}
      {auth.authenticated ? (
        <>
          <span className="ml-auto">
            <Link to={`/user/${auth.me?.id}`}>{auth.me?.first_name}</Link>
          </span>
          <span className="mx-3">
            <button
              type="button"
              className="focus:outline-none"
              onClick={auth.logout}
            >
              logout
            </button>
          </span>
        </>
      ) : (
        <>
          <span className="ml-auto">
            <Link to="/login">login</Link>
          </span>
          <span className="mx-3">
            <Link to="/register">register</Link>
          </span>
        </>
      )}
    </nav>
  );
}

export default Navbar;
