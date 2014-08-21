From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v3.17-rc1
Date: Fri, 22 Aug 2014 00:05:59 +0200
Message-ID: <20140821220559.GA29498@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0538437527695773577=="
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


--===============0538437527695773577==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.17-rc1

for you to fetch changes up to 9db4ad9183aad0e9567f6afb23db1bdc9aa6c2a9:

  iommu/core: Check for the right function pointer in iommu_map() (2014-08-19 00:19:26 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v3.17-rc1

The fixes include:

	* A patch to fix a crash in the VT-d driver when devices with a
	  driver attached are hot-unplugged

	* A patch for the AMD IOMMU driver to fix a crash with device
	  assignment of 32 bit PCI devices to KVM guests

	* Fix for a copy&paste error in generic IOMMU code. Now the
	  right function pointer is checked before calling.

----------------------------------------------------------------
Joerg Roedel (3):
      iommu/vt-d: Defer domain removal if device is assigned to a driver
      iommu/amd: Fix cleanup_domain for mass device removal
      iommu/core: Check for the right function pointer in iommu_map()

 drivers/iommu/amd_iommu.c   | 10 ++++++----
 drivers/iommu/intel-iommu.c |  8 ++++++++
 drivers/iommu/iommu.c       |  2 +-
 3 files changed, 15 insertions(+), 5 deletions(-)

Please pull.

Thanks,

	Joerg


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJT9m1HAAoJECvwRC2XARrjl1cP+wdMLzrxWlta4G36vYaPXQC8
VAz/CJ34H3py9yT65iDp5WoxWrdpGOEpOxG+xp0YQsd4LrDJN1AhK5cGg/6MmsKd
T2B4gG8I979DnFegQSHzsxxv0lR6n3GpCO3bQjAQrWj6RSxNC3tjgU5Bs70p5SEd
L2DU/h0KLdhstULsGsQ1uDeQc6kPsHpfMvBqRqsDZlHMxSGRBq45As/T0ldoychC
ucP2hjuCM2N/uyYmtlmAVBrxW7gz2AI96zNydaPs+NkwttrblRD8DJkRS0JaDuOo
Z8i/WQkxCp5YNonfl1f/U8oS+cRa3NBH2BJe97ExGr4qJBJeAfArSuGy3KLmMet1
6MYiSKVAAB79L05k7RmdbY7E5IiUavTugBKV60OZsWCi24/ymXoRIWSJi4huolZe
AVka8VpYaKzXLC8WVm81upCJp7xM890VXx0+ZI6B7Fx8wdPi+JnsewyxXbcRjPf4
5OY74+WAlThDNLHqLTjLi+fOM0Pn281vuFtxfUJVUmHWWHoyhPZb3JJl5LEcl4dd
dJgDQgpj1LNwRSNZtZVF46LnnOvYXl2tTX98GY5usWlinksLEDkpNMZ/aISEXD93
qYxFPW9YfT4dsTdx4Z0peAG1U3cjGScnor2CTAGDhcPaSj3how1ZcJzYo1wfwNQI
/lkLKSAg0JCqBwfhWN4/
=csGW
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

--===============0538437527695773577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0538437527695773577==--
