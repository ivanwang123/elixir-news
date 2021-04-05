import React, { useContext, useEffect, useState } from "react";
import Layout from "../components/Layout";
import Post from "../components/Post";
import Comment from "../components/Comment";
import { useLocation, useParams } from "react-router-dom";
import { useQuery } from "react-query";
import axios from "axios";
import { AuthContext } from "../contexts/auth";
import { UserType } from "../types/UserType";

const fetchUser = async (queryArgs: any) => {
  const userId = queryArgs.queryKey[1];

  try {
    const res = await axios.get(`/users/${userId}`);
    console.log(res);
    return res.data.user;
  } catch (e) {
    throw new Error(e.response.data.alert?.msg || "Unable to retrieve user");
  }
};

function UserPage(props: any) {
  const { id }: any = useParams();
  const auth = useContext(AuthContext);

  const { data, isError, error } = useQuery<any, Error, UserType>(
    ["user", id],
    fetchUser,
    {
      retry: 1,
    }
  );

  const [display, setDisplay] = useState<"" | "posts" | "comments" | "upvotes">(
    ""
  );
  const [isProfile, setIsProfile] = useState<boolean>(false);

  let displayBody = null;
  if (display === "posts") {
    // displayBody = <Post />;
  } else if (display === "comments") {
    displayBody = <Comment />;
  } else if (display === "upvotes") {
    // displayBody = <Post />;
  }

  useEffect(() => {
    if (auth.me?.id === data?.id) {
      setIsProfile(true);
    } else {
      setIsProfile(false);
    }
  }, [auth.me?.id, data?.id]);

  return (
    <Layout>
      <div className="ml-3">
        <section className="label-info-layout text-sm text-gray-500 mt-3">
          <span>user:</span>
          <span>{data?.full_name}</span>
          <span className="mr-2">created:</span>
          <span>{data?.inserted_at}</span>
          <span>about:</span>
          <span>{data?.about}</span>
          {isProfile && (
            <>
              <span>email:</span>
              <span>{data?.email}</span>
            </>
          )}
        </section>
        <section>
          <ul className="flex text-sm text-gray-500 mt-3 underline">
            <li
              className="mr-3 cursor-pointer"
              onClick={() => setDisplay("posts")}
            >
              posts
            </li>
            <li
              className="mr-3 cursor-pointer"
              onClick={() => setDisplay("comments")}
            >
              comments
            </li>
            <li
              className="mr-3 cursor-pointer"
              onClick={() => setDisplay("upvotes")}
            >
              upvotes
            </li>
          </ul>

          {displayBody}
        </section>
      </div>
    </Layout>
  );
}

export default UserPage;
