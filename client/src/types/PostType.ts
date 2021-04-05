import { UserType } from "./UserType";

export type PostType = {
  id: number;
  title: string;
  link: string;
  tag: string;
  total_upvotes: number;
  did_upvote: boolean;
  inserted_at: Date;
  creator: UserType;
};
