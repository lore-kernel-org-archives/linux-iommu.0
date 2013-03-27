From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for v3.9-rc4
Date: Wed, 27 Mar 2013 10:46:35 +0100
Message-ID: <20130327094547.GA8513@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4043842398887322353=="
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


--===============4043842398887322353==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.9-rc4

for you to fetch changes up to c2a2876e863356b092967ea62bebdb4dd663af80:

  iommu/amd: Make sure dma_ops are set for hotplug devices (2013-03-27 09:59:50 +0100)

----------------------------------------------------------------
IOMMU fixes for Linux v3.9-rc4

Here are some fixes which have collected since Linux v3.9-rc1. The most
important one fixes a long-standing regressen which make re-hotplugged
devices unusable when AMD IOMMU is used. The other patches fix build
issues (build regression on OMAP and a section mismatch). One patch just
removes a duplicate header include.

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu: OMAP: build only on OMAP2+

Joerg Roedel (1):
      iommu/amd: Make sure dma_ops are set for hotplug devices

Nikola Pajkovsky (1):
      amd_iommu_init: remove __init from amd_iommu_erratum_746_workaround

Wei Yongjun (1):
      x86, io_apic: remove duplicated include from irq_remapping.c

 drivers/iommu/Kconfig          |    2 +-
 drivers/iommu/amd_iommu.c      |   22 ++++++++++------------
 drivers/iommu/amd_iommu_init.c |    2 +-
 drivers/iommu/irq_remapping.c  |    1 -
 4 files changed, 12 insertions(+), 15 deletions(-)

Please pull.

Regards,

	Joerg


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRUr/KAAoJECvwRC2XARrju6oP/inNCbmmpao4HPG3K5wYxCJJ
Tjfda0phxlaVZyaz1tpfZlWr7gtVshXw1YL4VRUKhVYqxNb7mDV33GvNz5cbU6Pe
keYP7WnF4MYMunrAa7B+jX+1rJkGaIDeD/cUUxjSGjvM3fySmYmJJc7GUBCXRjX8
Z6BuXSVjFaC0qqfD+IwUtpfwkvee9dgBnKHUBJdMoWLzkUmHwP0b/rb2H0pCT5sB
sYfuE1vZdCXbnQUKHmOARCXxDE8cc2EH8t4E9lCc76piEG0nDgIejRrfOJ2WkmyR
fiIwodGE3htN15WdOpO4LtOGBv8l50Lfe8mT6ErWPKnRKookPsqADVTbp+WmQLw+
W+adXocyxPbm3qH7OpYLfWjD3XZj8x85SQjRUdFY4ziJqeFyKv93CnFaalPwZTbN
EkNQhfS6QLemvbi0FPBmufXjIgUXJ3MlQolruGzr4p5va6+SqtssK61a0ewV4q05
H8RUbRsIFxp2uQWUwDQWj0uINwM2/M1Sp7zoEs1IRCnGIdDjc8XtO7sEzYSeOypG
7BsLvhU8bey5ott0Z7Skx7KMmIwzAH7DfiiPXmnZqiXK6Rt+lKrU00+DT07EJ09B
/glp1xCEPewTHpPOkdFYES0kIZDSASyDj6oXuWqqCymKekrnzcL1FcbTqF2R2jhf
y9pYgME+RBwkzs1M9uWW
=N4bp
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--



--===============4043842398887322353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4043842398887322353==--
