defmodule Fingerprint.Plugins.Linux.Filesystem do
  @moduledoc """
  Linux Filesystem
  """

  @behaviour Fingerprint.Filesystem

  @doc """
  Return all filesystem info in MB

  ## Examples


      iex> Fingerprint.Plugins.Linux.Filesystem.all
      [%{"available" => 101132, "device" => "tmpfs", "mount" => "/run/user/1000",
         "percent_used" => "1%", "size" => 101200, "used" => 68},
        %{"available" => 0, "device" => "MobileBackups",
          "mount" => "/media/psf/MobileBackups", "percent_used" => "100%",
          "size" => 487372928, "used" => 487372928},
        %{"available" => 0, "device" => "Firefox", "mount" => "/media/psf/Firefox",
          "percent_used" => "100%", "size" => 120664, "used" => 120664},
        %{"available" => 112000632, "device" => "Dropbox for Business",
          "mount" => "/media/psf/Dropbox for Business", "percent_used" => "78%",
          "size" => 487372928, "used" => 375372296},
        %{"available" => 112000632, "device" => "Dropbox",
          "mount" => "/media/psf/Dropbox", "percent_used" => "78%",
          "size" => 487372928, "used" => 375372296},
        %{"available" => 112000632, "device" => "Photo Library",
          "mount" => "/media/psf/Photo Library", "percent_used" => "78%",
          "size" => 487372928, "used" => 375372296},
        %{"available" => 112000632, "device" => "iCloud",
          "mount" => "/media/psf/iCloud", "percent_used" => "78%", "size" => 487372928,
          "used" => 375372296},
          %{"available" => 112000632, "device" => "Home", "mount" => "/media/psf/Home",
          "percent_used" => "78%", "size" => 487372928, "used" => 375372296},
        %{"available" => 505996, "device" => "tmpfs", "mount" => "/sys/fs/cgroup",
          "percent_used" => "0%", "size" => 505996, "used" => 0},
        %{"available" => 5116, "device" => "tmpfs", "mount" => "/run/lock",
          "percent_used" => "1%", "size" => 5120, "used" => 4},
        %{"available" => 454216, "device" => "tmpfs", "mount" => "/dev/shm",
          "percent_used" => "11%", "size" => 505996, "used" => 51780},
        %{"available" => 56211408, "device" => "/dev/sda1", "mount" => "/",
          "percent_used" => "9%", "size" => 64891708, "used" => 5360956},
        %{"available" => 89872, "device" => "tmpfs", "mount" => "/run",
          "percent_used" => "12%", "size" => 101200, "used" => 11328},
        %{"available" => 485576, "device" => "udev", "mount" => "/dev",
          "percent_used" => "0%", "size" => 485576, "used" => 0}]


  """

  def all(:human) do
    Enum.map(all(), fn(fs) ->
       %{ fs | "size" => kb_to_mb(fs["size"]), "used" => kb_to_mb(fs["used"]), "available" => kb_to_mb(fs["available"])}
    end)
  end

  @doc """
  Return all filesystem info in KB

  ## Examples


      iex> Fingerprint.Plugins.Linux.Filesystem.all
      [%{"available" => 101132, "device" => "tmpfs", "mount" => "/run/user/1000",
         "percent_used" => "1%", "size" => 101200, "used" => 68},
        %{"available" => 0, "device" => "MobileBackups",
          "mount" => "/media/psf/MobileBackups", "percent_used" => "100%",
          "size" => 487372928, "used" => 487372928},
        %{"available" => 0, "device" => "Firefox", "mount" => "/media/psf/Firefox",
          "percent_used" => "100%", "size" => 120664, "used" => 120664},
        %{"available" => 112000632, "device" => "Dropbox for Business",
          "mount" => "/media/psf/Dropbox for Business", "percent_used" => "78%",
          "size" => 487372928, "used" => 375372296},
        %{"available" => 112000632, "device" => "Dropbox",
          "mount" => "/media/psf/Dropbox", "percent_used" => "78%",
          "size" => 487372928, "used" => 375372296},
        %{"available" => 112000632, "device" => "Photo Library",
          "mount" => "/media/psf/Photo Library", "percent_used" => "78%",
          "size" => 487372928, "used" => 375372296},
        %{"available" => 112000632, "device" => "iCloud",
          "mount" => "/media/psf/iCloud", "percent_used" => "78%", "size" => 487372928,
          "used" => 375372296},
          %{"available" => 112000632, "device" => "Home", "mount" => "/media/psf/Home",
          "percent_used" => "78%", "size" => 487372928, "used" => 375372296},
        %{"available" => 505996, "device" => "tmpfs", "mount" => "/sys/fs/cgroup",
          "percent_used" => "0%", "size" => 505996, "used" => 0},
        %{"available" => 5116, "device" => "tmpfs", "mount" => "/run/lock",
          "percent_used" => "1%", "size" => 5120, "used" => 4},
        %{"available" => 454216, "device" => "tmpfs", "mount" => "/dev/shm",
          "percent_used" => "11%", "size" => 505996, "used" => 51780},
        %{"available" => 56211408, "device" => "/dev/sda1", "mount" => "/",
          "percent_used" => "9%", "size" => 64891708, "used" => 5360956},
        %{"available" => 89872, "device" => "tmpfs", "mount" => "/run",
          "percent_used" => "12%", "size" => 101200, "used" => 11328},
        %{"available" => 485576, "device" => "udev", "mount" => "/dev",
          "percent_used" => "0%", "size" => 485576, "used" => 0}]


  """

  def all do
    {data, 0} = System.cmd("df", ["-P"])
    split = String.split(data, "\n")
    Enum.reduce(split, [], fn(line, acc) ->
      case Regex.run(~r/^(.+?)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+\%)\s+(.+)$/, line) do
        nil -> acc
        [_, device, size, used, available, percent_used, mount] ->
          [%{"device" => device, "size" => to_integer(size), "used" => to_integer(used), "available" => to_integer(available), "percent_used" => percent_used, "mount" => mount} | acc]
      end
    end)
  end

  defp to_integer(str) do
    String.to_integer(str)
  end

  defp kb_to_mb(0), do: 0
  defp kb_to_mb(int) when int > 0 do
    Float.round(int / 1024, 2)
  end

end

