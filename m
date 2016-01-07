From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.4-rc8
Date: Thu, 7 Jan 2016 20:28:06 +0100
Message-ID: <20160107192806.GA16147@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5860592323473128346=="
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


--===============5860592323473128346==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 74bf8efb5fa6e958d2d7c7917b8bb672085ec0c6:

  Linux 4.4-rc7 (2015-12-27 18:17:37 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.4-rc8

for you to fetch changes up to 164afb1d85b872907cfac048b46c094db596d529:

  iommu/dma: Use correct offset in map_sg (2016-01-07 13:36:41 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.4-rc8

The patches include fixes for:

	* Two build issues, one in the ipmmu-vmsa driver and one for the
	  new generic dma-api implemention used on arm64

	* A performance fix for said dma-api implemention

	* An issue caused by a wrong offset in map_sg in the same code
	  as above

----------------------------------------------------------------
Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Don't truncate ttbr if LPAE is not enabled

Robin Murphy (3):
      iommu/dma: Add some missing #includes
      iommu/dma: Avoid unlikely high-order allocations
      iommu/dma: Use correct offset in map_sg

 drivers/iommu/dma-iommu.c  | 11 ++++++++---
 drivers/iommu/ipmmu-vmsa.c |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg


--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWjrxGAAoJECvwRC2XARrjNWMP/j3hqvyxxqPTmxGcqFF15Gri
8slbwrwy5+rqCBYzw7Qv2BUbMT5VwiyHfFwQ3ws7PL5j9gQ1UzEhwlKehhgYcSW0
80ek4V7DNwXXvp7mKD8fIVvZTxLRD7Sa671k7TegHATk6GemQX6PglxYgfg2CgR/
0gmcDJpXTI37lx0APKPjRKWtWGXY5+ixiAJOJz8zfi+aNpZHGEgi9mx0+zN9nSi0
pQvCZmgvR/TusbY7Nvqoz3U0KdmKQtvncSGCs+Ur7QHqrfsS06oVH53vLygtWmLa
YqfsKVphzSHTXik5TL0erYr42LDGW5sR2ibDxOI6YtdX3UK9GaWpbZk59hPIFc0P
WIgyNAi8pJaI7YIZpNn81Tp9HzW9q+TnowD4QZTLg9b8n57Xe0sAnxGQe2gSWV8g
EurLURRgvp1H4UEbV3DGIoZojOTVlbuaXXroPMJPHcIgk79L4u9o/8P8s34oJ5L8
uZZ8Y08cs2Xm+3HGnkDY24i9VSbTliY/9UvPqBoQRcx97gq7OOsJLGU7fXjVRBd+
GL8pScxYG4RsbXE4m1HKIMQ4xzkEuiO4kVHQPg5jVTKriFpXUNN1ygW3jgXG6wiP
EBWqsya/uExk2cpNH8bENZxrLakOQ+BTP+pudZHfTd/bkCtzMpXKG5V0l11nl960
Jne6rFqdlxLhoUH+qlYT
=rlsu
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--

--===============5860592323473128346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5860592323473128346==--
