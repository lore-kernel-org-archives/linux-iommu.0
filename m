From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v3.19-rc3
Date: Fri, 30 Jan 2015 15:23:40 +0100
Message-ID: <20150130142340.GA10152@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4751173090838498827=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============4751173090838498827==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 26bc420b59a38e4e6685a73345a0def461136dce:

  Linux 3.19-rc6 (2015-01-25 20:04:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.19-rc6

for you to fetch changes up to 35577079b9943e158c7032afe1dde6faf4385222:

  iommu/tegra: gart: Provide default ->map_sg() callback (2015-01-26 13:41:07 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v3.19-rc6

Two small fixes for the Tegra GART IOMMU driver:

	* Provide a .map_sg function for iommu_ops
	* Do not register Tegra GART driver as a workaround because of
	  issues with it when used from DRM code

----------------------------------------------------------------
Thierry Reding (2):
      iommu/tegra: gart: Do not register with bus
      iommu/tegra: gart: Provide default ->map_sg() callback

 drivers/iommu/tegra-gart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJUy5PsAAoJECvwRC2XARrjMJ0P/1nQo8oyOkHqmkHK5hFgz0fY
b4TW4MnBW6JlCWagKZi1l82D3K3a4ILI7jOJxKL0qSRzXDyGgZyAV+rKaq9YtPG9
6tc2PCfJU3KCREvAOF4Cu7hTtkjhxAgzA1QMntHhy1lwQr5zOXjMZNCfJqHrzBp/
bps7MQYPjbTuSZAKIcgwtu1cKRoKIg9M2uDhUnXDWHBmUq+BTu0yjqQ0qw84eWSg
Gry8bv+kTnSs1QnAn6wCKv8AKmCmKDEhJSX0zsipt926RSEJ+ZSl2zZ3gYcMHiYY
VziyLu4FpfJCd14OaQS5a0hB/IZLS0UdCgdOtx+pfxtJXbRihYPaXB+TUhofl4aS
3RsYf9tC040Gnm4l2TiUsbjdVEYNCtF2p5o7mcvBI4h7xj64GWBJhakykrFFhBUx
whBDJPesLPQ2wOLTaJxlx7q5wxo0wpanbQrZXuQWKlzoi4uhdzkct55GlY/203xr
eCSpq9iXVZXukLLT2ThrfyINPjfW4nNI2fsWZ2GVWeSgZotrto5DqvwT6wB51Hs8
H7JIq+ZAbj2AnrM/5rA/2sBqTXpr4NPvn9y7TYq0Pkny7RKea7LMsGrWD9jFOzsm
TgBeZdlrL2X1MEVPHX5atzlNiZcsXuK8XJ2//ZdkS0vM1NZzxqG/KhuUQb8HenWb
Kodp0FogTiYM/i9Q/LZK
=w/oy
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

--===============4751173090838498827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4751173090838498827==--
