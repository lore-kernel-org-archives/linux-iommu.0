From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for v3.6-rc2
Date: Mon, 20 Aug 2012 12:06:13 +0200
Message-ID: <20120820100613.GA2980@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4542435395009719938=="
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


--===============4542435395009719938==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 31fe943599b7e5870edb9decb7fbb9538b218f26:

  iommu/amd: Fix ACS path checking (2012-08-06 18:10:04 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.6-rc2

for you to fetch changes up to 2bd5ed002c0c493ac328f13a9e2a504261a7d48e:

  iommu/amd: Fix wrong check for ARRAY_SIZE() (2012-08-10 11:34:08 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v3.6-rc2

Two fixes are necessary. One patch fixes a boot crash on MacBook Air
with interrupt remapping enabled and the other patch fixes a regression
(which causes a boot crash on AMD IOMMUv2 systems too) in the init code
of the AMD IOMMU driver.

----------------------------------------------------------------
Joerg Roedel (1):
      iommu/amd: Fix wrong check for ARRAY_SIZE()

Seth Forshee (1):
      irq_remap: disable IRQ remapping if any IOAPIC lacks an IOMMU

 drivers/iommu/amd_iommu_init.c      |    2 +-
 drivers/iommu/intel_irq_remapping.c |   18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

Please pull.

Regards,

	Joerg


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJQMgwVAAoJECvwRC2XARrjBjAQAIKWbHYEGTuqkd4QvKfZ/Kts
xbyLgvc+P2wtVo4DEKZqz9/CskpO859xdzkY4lbf9NuEAQpggWCZIeVMGHf5Awbc
LRiAStRMe6MvdA0yDx9Kg/DjOni3RlfHPiy/wT+v+BiW5t73J8YKnfACKNhIZ/8w
KmLEqNvsbepqEbNw0FMdUhCb/BwUxHT2k1iP42TkCBbs99Lga/jGP8B5gSwz6TO8
DnZDFsynM/XgpRrEdJE9cFITakNn1+Ykij9Gk0hoSG/IUxNWZvyNcE1K4ZTdtCmb
j09pQJIch3qBdA6R5RsaYQs4Ti/bFhuJD/yz6CyPbQxgMYJ2WXRUWTmSrdDxIuB1
vPENmWP4nR50fO2zUKEIMUqnBP7eQVJLUWBBhJ+o5S6r9xdUMmHa627LLbH2UsUK
Ry1RZjq/ebMXdAd0p/jiqqoBed4gbE/RUos8DC3BX6B1IqF1Mlz++W4pdjhqVxHM
LIIoi7rtgCb3MGb5tBlBbxSLE6i5VeOKu0koZpV9y8aOzL2qyEz4c2V4jZPfbcw9
k5oGapV9j+XnjONSHmzWbNVZx7wJUcr7d0824rC970z9tNwjtKyhcVgLi/3IP0XB
0C/EiuhYNyZdpIKcz7d6eaYImvClCIV58aWsvP9sCaO1Qqtc49SMFGPENRgwqKx5
OtqXPsthJZjehBbxSTRa
=8jKX
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--



--===============4542435395009719938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4542435395009719938==--
