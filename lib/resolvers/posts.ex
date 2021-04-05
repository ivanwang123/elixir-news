defmodule SocialMediaV3.Posts do
  import Ecto.Query, warn: false
  alias SocialMediaV3.Repo
  alias SocialMediaV3.Post

  def list_posts(_parent, _args, _resolution) do
    posts = Post
    |> order_by(desc: :inserted_at)
    |> Repo.all()
    {:ok, posts}
  end

  def get_posts_by_tag(cur_user, tag) do
    post_query = from p in Post, select: p

    (from p in post_query,
      left_join: u in assoc(p, :upvotes),
      where: p.tag == ^tag,
      preload: [:creator],
      group_by: p.id,
      order_by: [desc: fragment("ROUND(CAST(COUNT(?) / POWER(EXTRACT(EPOCH FROM timezone('UTC', now())-?)/3600+2, 1) AS NUMERIC), 3)", u.id, p.inserted_at)],
      select_merge: %{total_upvotes: count(u.id), did_upvote: fragment("exists(select 1 from upvotes u where u.post_id = ? and u.user_id = ?)", p.id, ^cur_user)}
    )
    |> Repo.all()
  end

  def get_posts_by_score(cur_user) do
    post_query = from p in Post, select: p

    (from p in post_query,
      left_join: u in assoc(p, :upvotes),
      preload: [:creator],
      group_by: p.id,
      order_by: [desc: fragment("ROUND(CAST(COUNT(?) / POWER(EXTRACT(EPOCH FROM timezone('UTC', now())-?)/3600+2, 1) AS NUMERIC), 3)", u.id, p.inserted_at)],
      select_merge: %{total_upvotes: count(u.id), did_upvote: fragment("exists(select 1 from upvotes u where u.post_id = ? and u.user_id = ?)", p.id, ^cur_user)}
    )
    |> Repo.all()
  end

  def get_posts_by_time(cur_user) do
    post_query = from p in Post, select: p

    (from p in post_query,
      left_join: u in assoc(p, :upvotes),
      preload: [:creator],
      group_by: p.id,
      order_by: [desc: p.inserted_at],
      select_merge: %{total_upvotes: count(u.id), did_upvote: fragment("exists(select 1 from upvotes u where u.post_id = ? and u.user_id = ?)", p.id, ^cur_user)}
    )
    |> Repo.all()
  end

  def get_post(id) do
    {:ok, Repo.get(Post, id)}
  end
  # def get_post(_id) do
  #   nil
  # end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end
end
