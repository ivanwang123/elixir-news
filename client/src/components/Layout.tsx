import React, { ReactNode } from "react";
import Navbar from "./Navbar";
import { Helmet } from "react-helmet";

type PropType = {
  children?: ReactNode;
  title?: string;
};

function Layout({ children, title }: PropType) {
  return (
    <div className="h-full">
      <Helmet>
        <title>{title || "Elixir News"}</title>
      </Helmet>
      <div className="grid grid-cols-12 h-full">
        <main className="col-start-1 col-end-13 mt-2 bg-purple-100 md:col-start-2 md:col-end-12">
          <Navbar />
          {children}
        </main>
      </div>
    </div>
  );
}

export default Layout;
