import axios from "axios";
import React, { FormEvent, useContext, useEffect, useState } from "react";
import { useMutation } from "react-query";
import { useHistory } from "react-router";
import Layout from "../components/Layout";
import { AuthContext } from "../contexts/auth";

type LoginType = {
  email: string;
  password: string;
};

const handleLogin = (data: LoginType) => {
  return axios.post("/users/login", data).catch((e) => {
    throw new Error(e.response.data.alert?.msg || "Unable to log in user");
  });
};

function LoginPage() {
  const auth = useContext(AuthContext);
  const history = useHistory();

  const [email, setEmail] = useState<string>("");
  const [password, setPassword] = useState<string>("");

  const { mutate, isSuccess, isError, error } = useMutation<
    any,
    any,
    LoginType
  >(handleLogin);

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    mutate({
      email: email,
      password: password,
    });
  };

  useEffect(() => {
    if (isSuccess) {
      history.push("/news");
      auth.refresh();
    }
  }, [isSuccess]);

  return (
    <Layout title="Login | Elixir News">
      <form
        className="label-info-layout text-sm ml-3 mt-3"
        onSubmit={handleSubmit}
      >
        <h1 className="col-span-2 text-base font-bold mb-3">Login</h1>
        <label htmlFor="email">email:</label>
        <input
          type="text"
          id="email"
          className="w-64"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
        />
        <label htmlFor="password">password:</label>
        <input
          type="password"
          id="password"
          className="w-64"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <button type="submit" className="mt-3">
          login
        </button>
      </form>
      <p>{isError && error.message}</p>
      <p>{isSuccess && "Successfully logged in!"}</p>
    </Layout>
  );
}

export default LoginPage;
