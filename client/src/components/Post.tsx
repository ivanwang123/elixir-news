import axios from "axios";
import React, { useContext, useState } from "react";
import { Link } from "react-router-dom";
import { AuthContext } from "../contexts/auth";
import { PostType } from "../types/PostType";

type PropType = {
  rank?: number | string;
  post: PostType;
};

function Post({ rank, post }: PropType) {
  const auth = useContext(AuthContext);
  console.log("POST", post);

  const [didUpvote, setDidUpvote] = useState<boolean>(post.did_upvote);
  const [totalUpvotes, setTotalUpvotes] = useState<number>(post.total_upvotes);

  const handleUpvote = async () => {
    if (auth.authenticated) {
      if (didUpvote) {
        axios.post("/upvotes/unvote", {
          post_id: post.id,
          user_id: auth.me!.id,
        });
        if (post.did_upvote) setTotalUpvotes(post.total_upvotes - 1);
        else setTotalUpvotes(post.total_upvotes);
      } else {
        axios.post("/upvotes", {
          post_id: post.id,
          user_id: auth.me!.id,
        });
        if (post.did_upvote) setTotalUpvotes(post.total_upvotes);
        else setTotalUpvotes(post.total_upvotes + 1);
      }
      setDidUpvote(!didUpvote);
    }
  };

  return (
    <article className="w-100 flex my-2">
      {/* SIDE INFO */}
      <div className="flex mr-1 text-sm text-gray-500">
        <pre> {rank ? `${rank}.` : ""}</pre>
        <img
          className="w-4 h-4 cursor-pointer"
          src={`/res/${didUpvote ? "upvoted" : "upvote"}.svg`}
          onClick={handleUpvote}
        />
      </div>

      {/* MAIN CONTENT */}
      <div className="w-full">
        {/* TITLE */}
        <h2 className="text-sm">
          <a href={post.link}>{post.title}</a>
          <span className="text-xs text-gray-500 ml-1">
            (
            <Link to="/from" className="hover:underline">
              {post.link}
            </Link>
            )
          </span>
        </h2>
        {/* SUB INFO */}
        <div className="text-xs text-gray-500">
          {totalUpvotes} points by{" "}
          <Link to={`/user/${post.creator.id}`} className="hover:underline">
            {post.creator.full_name}
          </Link>{" "}
          1 hour ago |{" "}
          <Link to={`/post/${post.id}`} className="hover:underline">
            13 comments
          </Link>
        </div>
      </div>
    </article>
  );
}

export default Post;
