import React from "react";
import { Link } from "react-router-dom";
import Layout from "../components/Layout";
import Post from "../components/Post";
import Comment from "../components/Comment";

function PostPage() {
  return (
    <Layout>
      {/* <Post /> */}
      <form className="ml-5 text-sm">
        <textarea
          className="block w-1/2 border border-black rounded-sm"
          rows={5}
        ></textarea>
        <button type="submit">add comment</button>
      </form>
      <Comment nestedLevel={0} />
      <Comment nestedLevel={1} />
    </Layout>
  );
}

export default PostPage;
