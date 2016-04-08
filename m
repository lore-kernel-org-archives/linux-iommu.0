From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.6-rc2
Date: Fri, 8 Apr 2016 16:24:24 +0200
Message-ID: <20160408142414.GA12001@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2144137847779996917=="
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============2144137847779996917==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.6-rc2

for you to fetch changes up to 0b74ecdfbea893ae585bc694136a3f50f5856cfe:

  iommu/vt-d: Silence an uninitialized variable warning (2016-04-07 14:51:47 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.6-rc2 with:

 - Compile-time fixes (warnings and failures)

 - A bug in iommu core code which could cause the group->domain pointer
   to be falsly cleared

 - Fix in scatterlist handling of the ARM common DMA-API code

 - Stall detection fix for the Rockchip IOMMU driver

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu: provide of_xlate pointer unconditionally

Dan Carpenter (1):
      iommu/vt-d: Silence an uninitialized variable warning

Joerg Roedel (1):
      iommu: Don't overwrite domain pointer when there is no default_domain

John Keeping (1):
      iommu/rockchip: Fix "is stall active" check

Robin Murphy (1):
      iommu/dma: Restore scatterlist offsets correctly

 drivers/iommu/dma-iommu.c      | 4 ++--
 drivers/iommu/intel-iommu.c    | 2 +-
 drivers/iommu/iommu.c          | 3 ++-
 drivers/iommu/rockchip-iommu.c | 8 ++++----
 include/linux/iommu.h          | 2 --
 5 files changed, 9 insertions(+), 10 deletions(-)

Please pull.

Thanks,

	Joerg

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJXB78OAAoJECvwRC2XARrjZPUP/3y8MgCcdpbwoHTkGrLlbucx
WxgzEhV0Uj64VySBK4ftsu2Mm49pGtJlPr8LWtFNv/Jjp3jt6r/7sKrgTCQgcxg/
a5pdGTE+8FwzTqvd2jqC6vd/jp/VEe8X6xOyGUFSD8c9jEyrDCt8FVanQ3yZ0FxA
hwgbG+zihWb/jPg318opy7Ev5ur1vzfiR5SUCW58nenlsScctnWuoF9ZRwECILE3
XJwRqvxvSMarY8usJuLMvpNyWUI2JJyBIqeLALfs3XUE0/McQWHPYGnPhzYj2ioz
so60WTCGL6z/gcxC6MGRz0JBcw/Q0JLfXxQbJ1mUG+5FGUwHc272ScjaWA+z/Z0J
3tWNuWZ6ODZXqpsDXIqjAYDTLfMmJvFce+kgTG/oW9A4i0GSqRALr6wrbA5QGgzW
HgUr2SdKfutfCrcCzS5d4TkV/PCU4qX2vJs8RZdsnPVpngZDcoTZml9taEtwqWTu
9vAPHaKnkxTFKErEi83Y/hnnH/pEE/9TrY3+1aSiTZrcl+VABOG+zYSk4LRiIfD8
7vegrg/I2qtGzRh3VT8gw2E23SiQOYIp6QrtdnHzHlOg3PH3I0SZnPYGRvHenE5g
hjDqpFgtuaII1LdgXgcp1CjIkgZ5LlnYXMa04ByXHUzRsKq6i9fNPrDKYet5P+Dp
bI8HSJ4jf6sd5Zv1u3lS
=KtzD
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--

--===============2144137847779996917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2144137847779996917==--
