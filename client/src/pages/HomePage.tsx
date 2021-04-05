import axios from "axios";
import React, { useEffect, useState } from "react";
import { useQuery } from "react-query";
import { useLocation } from "react-router-dom";
import Layout from "../components/Layout";
import Post from "../components/Post";
import { PostType } from "../types/PostType";

type PathType = "/" | "/news" | "/newest" | "/ask" | "/show" | "/jobs";

const fetchPosts = async (queryArgs: any) => {
  const path: PathType = queryArgs.queryKey[1];
  let url = "/posts/top";

  if (path === "/newest") url = "/posts/new";
  else if (path === "/ask") url = "/posts/tag/ask";
  else if (path === "/show") url = "/posts/tag/show";
  else if (path === "/jobs") url = "/posts/tag/jobs";

  try {
    const res = await axios.get(url);
    console.log(res);
    return res.data;
  } catch (e) {
    throw new Error(e.response.data.alert?.msg || "Unable to retrieve posts");
  }
};

function HomePage() {
  const router = useLocation();

  const { data, error, isLoading, isError } = useQuery<any, Error>(
    ["users", router.pathname],
    fetchPosts,
    {
      retry: 1,
    }
  );
  const [title, setTitle] = useState<string>("Elixir News");

  useEffect(() => {
    switch (router.pathname) {
      case "/newest":
        setTitle("New | Elixir News");
        break;
      case "/ask":
        setTitle("Ask | Elixir News");
        break;
      case "/show":
        setTitle("Show | Elixir News");
        break;
      case "/jobs":
        setTitle("Jobs | Elixir News");
        break;
    }
  }, [router.pathname]);

  return (
    <Layout title={title}>
      {data?.posts.map((post: PostType, index: number) => (
        <Post rank={index + 1} post={post} />
      ))}
    </Layout>
  );
}

export default HomePage;
