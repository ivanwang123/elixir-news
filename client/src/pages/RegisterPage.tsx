import axios from "axios";
import React, { FormEvent, useEffect, useState } from "react";
import { useMutation } from "react-query";
import { useHistory } from "react-router";
import Layout from "../components/Layout";

type RegisterType = {
  first_name: string;
  last_name: string;
  email: string;
  password: string;
  confirm_password: string;
};

const handleRegister = (data: RegisterType) => {
  return axios.post("/users/register", data).catch((e) => {
    throw new Error(e.response.data.alert?.msg || "Unable to register user");
  });
};

function RegisterPage() {
  const history = useHistory();

  const [firstName, setFirstName] = useState<string>("");
  const [lastName, setLastName] = useState<string>("");
  const [email, setEmail] = useState<string>("");
  const [password, setPassword] = useState<string>("");
  const [confirmPassword, setConfirmPassword] = useState<string>("");

  const { mutate, isSuccess, isError, error, data } = useMutation<
    any,
    any,
    RegisterType
  >(handleRegister);

  const handleSubmit = (e: FormEvent) => {
    e.preventDefault();
    mutate({
      first_name: firstName,
      last_name: lastName,
      email: email,
      password: password,
      confirm_password: confirmPassword,
    });
  };

  useEffect(() => {
    if (isSuccess) history.push("/login");
  }, [isSuccess]);

  return (
    <Layout title="Register | Elixir News">
      <form
        className="label-info-layout text-sm ml-3 mt-3"
        onSubmit={handleSubmit}
      >
        <h1 className="col-span-2 text-base font-bold mb-3">Register</h1>
        <label htmlFor="first-name">first name:</label>
        <input
          type="text"
          id="first-name"
          className="w-64"
          value={firstName}
          onChange={(e) => setFirstName(e.target.value)}
        />
        <label htmlFor="last-name">last name:</label>
        <input
          type="text"
          id="last-name"
          className="w-64"
          value={lastName}
          onChange={(e) => setLastName(e.target.value)}
        />
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
        <label htmlFor="confirm-password">confirm password:</label>
        <input
          type="password"
          id="confirm-password"
          className="w-64"
          value={confirmPassword}
          onChange={(e) => setConfirmPassword(e.target.value)}
        />
        <button type="submit" className="mt-3">
          register
        </button>
      </form>
      <p>{isError && error.message}</p>
      <p>{isSuccess && "Successfully registered!"}</p>
    </Layout>
  );
}

export default RegisterPage;
