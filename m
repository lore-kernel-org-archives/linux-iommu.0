From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.11-rc1
Date: Tue, 28 Feb 2017 16:24:34 +0100
Message-ID: <20170228152428.GA26932@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1615568488142577796=="
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


--===============1615568488142577796==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 86292b33d4b79ee03e2f43ea0381ef85f077c760:

  Merge branch 'akpm' (patches from Andrew) (2017-02-27 23:09:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v4.11-rc0-2

for you to fetch changes up to b7a42b9d38063e58cdf201c575da75943f71051e:

  iommu/amd: Fix crash when accessing AMD-Vi sysfs entries (2017-02-28 15:48:23 +0100)

----------------------------------------------------------------
IOMMU Fixes:

	* Fix and issue introduced this merge window into the AMD and
	  Intel IOMMU drivers that causes an oops when the
	  vendor-specific sysfs-entries are accessed.
	  Reason for this issue is that I forgot to update the sysfs
	  code in the drivers when moving the iommu 'struct device' to
	  the iommu-core.

----------------------------------------------------------------
Joerg Roedel (2):
      iommu/vt-d: Fix crash when accessing VT-d sysfs entries
      iommu/amd: Fix crash when accessing AMD-Vi sysfs entries

 drivers/iommu/amd_iommu_init.c  |  4 ++--
 drivers/iommu/amd_iommu_types.h |  5 +++++
 drivers/iommu/intel-iommu.c     | 17 +++++++++++------
 3 files changed, 18 insertions(+), 8 deletions(-)

Please pull.

Thanks,

	Joerg

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJYtZYsAAoJECvwRC2XARrjuHMP/3JR93s+FzL8OQkVVm/6szp1
mvon6mBFFf5hjRVk7XHkTAT4Zrb52O4b4jB1jWCIa0sdUHhJ1zdDQ25UGWIoYNPs
ub+2o9X2ruGuGU9tC2pVaBIomapDyimNJVophdrTxWuqXApa3e3ORIOTJMitweDm
w2cK6snD1V3jqkMJhGTeHUGp1bXBO2MbNE1ggB+NNwSgyqOGGtu2nQhzlFRhc8My
T3VkEuNSuCSTmUEN0N44k6A5eCBghD5rwFmeOcZatCPRvtQgWaSshEXYy+UXuVX8
2XcK3C6MSn4/uscPFzLff45iX6+Mwn4Hg9PKrA29qNN6QAs7d0z6was0QelEj6xh
1a84zC8G5ld+E4XJsRUFH4zCuNyfpxQ+PgIdY8IbIvgofAoLOddBPDQnl2FYMDZ/
r3yYMnPzrIdbTD+npOxqbY7iWSS8p7o5cLDhpI/02A0bpu/zSvfsuv4AuIj48qtk
Rh9s0kpxiePvfuZL55Ywb6jvob3d29I0jNo06ekCwoPY9+/qYtt9dzk2owRcE12u
qbj7txmjzazMkSDCm4CxBpnrYF9zHOhWB3BFBlHeyVMHuKIjw0JBCHl/OfXixbNy
iNB65VcgwWunXGQ79TEbPwm0rgd4u6zADDxv4UVwn3w7JtNN9z9OVYg07SR1Qglh
XZqjaav/s0NkIon9gCQw
=tOdu
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--

--===============1615568488142577796==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1615568488142577796==--
