import axios from "axios";
import React, { createContext } from "react";
import { useMutation, useQuery } from "react-query";
import { resolveProjectReferencePath } from "typescript";
import { UserType } from "../types/UserType";

type ContextType = {
  authenticated: boolean;
  me: UserType | null | undefined;
  logout: () => void;
  refresh: () => void;
};

export const AuthContext = createContext<ContextType>({
  authenticated: false,
  me: null,
  logout: () => {},
  refresh: () => {},
});

const fetchMe = async () => {
  try {
    const res = await axios.get("/users/me");
    return res.data.user;
  } catch (e) {
    return null;
  }
};

export function AuthProvider({ children }: any) {
  const { data, isLoading, refetch } = useQuery<any, any, UserType | null>(
    "me",
    fetchMe,
    {
      retry: 1,
    }
  );

  const logout = () => {
    axios.post("/users/logout").then(() => refetch());
  };
  const refresh = () => {
    refetch();
  };

  return (
    <AuthContext.Provider
      value={{ authenticated: !!data, me: data, logout, refresh }}
    >
      {children}
    </AuthContext.Provider>
  );
}
