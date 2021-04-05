import React, { useState } from "react";
import { Link } from "react-router-dom";

type PropType = {
  nestedLevel?: number;
};

function Comment({ nestedLevel = 0 }: PropType) {
  const [hidden, setHidden] = useState<boolean>(false);
  const [padding, setPadding] = useState<string>(`pl-${nestedLevel * 6}`);

  return (
    <article className={`w-full flex my-2 ${padding}`}>
      {/* UPVOTE */}
      <div className="flex text-sm mr-1">
        <pre> </pre>
        <img className="w-4 h-4 ml-auto cursor-pointer" src="/res/upvote.svg" />
      </div>
      {/* MAIN */}
      <div className="w-full">
        {/* HEADER */}
        <div className="text-xs text-gray-500">
          <pre>
            <Link to="/user/1" className="hover:underline">
              SamuelAdams
            </Link>{" "}
            5 minutes ago{" "}
            <button
              type="button"
              className="hover:underline focus:outline-none"
              onClick={(e) => setHidden(!hidden)}
            >
              [-]
            </button>
          </pre>
        </div>
        {/* CONTENT */}
        <div className={`${hidden ? "hidden" : "block"}`}>
          <p className="text-sm">
            I used to work at a major multi-billion dollar retailer. One of the
            biggest complaints from customers was waiting at the check out line,
            especially for small, quick orders. This is the future of grocery
            stores, like it or not. Employees are expensive and make mistakes,
            whereas machines are cheap, don't take breaks, and work pretty
            reliably once you set them up correctly.
          </p>
          <button
            type="button"
            className="text-xs underline focus:outline-none"
          >
            reply
          </button>
        </div>
      </div>
    </article>
  );
}

export default Comment;
