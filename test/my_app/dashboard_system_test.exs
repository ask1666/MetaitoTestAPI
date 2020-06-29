defmodule MyApp.DashboardSystemTest do
  use MyApp.DataCase

  alias MyApp.DashboardSystem

  describe "dashboards" do
    alias MyApp.DashboardSystem.Dashboard

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def dashboard_fixture(attrs \\ %{}) do
      {:ok, dashboard} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DashboardSystem.create_dashboard()

      dashboard
    end

    test "list_dashboards/0 returns all dashboards" do
      dashboard = dashboard_fixture()
      assert DashboardSystem.list_dashboards() == [dashboard]
    end

    test "get_dashboard!/1 returns the dashboard with given id" do
      dashboard = dashboard_fixture()
      assert DashboardSystem.get_dashboard!(dashboard.id) == dashboard
    end

    test "create_dashboard/1 with valid data creates a dashboard" do
      assert {:ok, %Dashboard{} = dashboard} = DashboardSystem.create_dashboard(@valid_attrs)
      assert dashboard.title == "some title"
    end

    test "create_dashboard/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DashboardSystem.create_dashboard(@invalid_attrs)
    end

    test "update_dashboard/2 with valid data updates the dashboard" do
      dashboard = dashboard_fixture()
      assert {:ok, %Dashboard{} = dashboard} = DashboardSystem.update_dashboard(dashboard, @update_attrs)
      assert dashboard.title == "some updated title"
    end

    test "update_dashboard/2 with invalid data returns error changeset" do
      dashboard = dashboard_fixture()
      assert {:error, %Ecto.Changeset{}} = DashboardSystem.update_dashboard(dashboard, @invalid_attrs)
      assert dashboard == DashboardSystem.get_dashboard!(dashboard.id)
    end

    test "delete_dashboard/1 deletes the dashboard" do
      dashboard = dashboard_fixture()
      assert {:ok, %Dashboard{}} = DashboardSystem.delete_dashboard(dashboard)
      assert_raise Ecto.NoResultsError, fn -> DashboardSystem.get_dashboard!(dashboard.id) end
    end

    test "change_dashboard/1 returns a dashboard changeset" do
      dashboard = dashboard_fixture()
      assert %Ecto.Changeset{} = DashboardSystem.change_dashboard(dashboard)
    end
  end

  describe "notes" do
    alias MyApp.DashboardSystem.Note

    @valid_attrs %{html_saved: true, markdown: true, text: "some text", title: "some title"}
    @update_attrs %{html_saved: false, markdown: false, text: "some updated text", title: "some updated title"}
    @invalid_attrs %{html_saved: nil, markdown: nil, text: nil, title: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DashboardSystem.create_note()

      note
    end

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert DashboardSystem.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert DashboardSystem.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = DashboardSystem.create_note(@valid_attrs)
      assert note.html_saved == true
      assert note.markdown == true
      assert note.text == "some text"
      assert note.title == "some title"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DashboardSystem.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, %Note{} = note} = DashboardSystem.update_note(note, @update_attrs)
      assert note.html_saved == false
      assert note.markdown == false
      assert note.text == "some updated text"
      assert note.title == "some updated title"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = DashboardSystem.update_note(note, @invalid_attrs)
      assert note == DashboardSystem.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = DashboardSystem.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> DashboardSystem.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = DashboardSystem.change_note(note)
    end
  end

  describe "links" do
    alias MyApp.DashboardSystem.Link

    @valid_attrs %{title: "some title", url: "some url"}
    @update_attrs %{title: "some updated title", url: "some updated url"}
    @invalid_attrs %{title: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> DashboardSystem.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert DashboardSystem.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert DashboardSystem.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = DashboardSystem.create_link(@valid_attrs)
      assert link.title == "some title"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = DashboardSystem.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, %Link{} = link} = DashboardSystem.update_link(link, @update_attrs)
      assert link.title == "some updated title"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = DashboardSystem.update_link(link, @invalid_attrs)
      assert link == DashboardSystem.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = DashboardSystem.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> DashboardSystem.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = DashboardSystem.change_link(link)
    end
  end
end
