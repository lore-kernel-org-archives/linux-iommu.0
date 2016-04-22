From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.6-rc3
Date: Fri, 22 Apr 2016 11:56:18 +0200
Message-ID: <20160422095609.GA18272@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7793747332937527516=="
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


--===============7793747332937527516==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit bf16200689118d19de1b8d2a3c314fc21f5dc7bb:

  Linux 4.6-rc3 (2016-04-10 17:58:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.6-rc4

for you to fetch changes up to 9800699c645952da6a7399194d3e762b84cde3cd:

  iommu/arm-smmu: Don't allocate resources for bypass domains (2016-04-21 16:47:32 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.6-rc4

The fixes include:

	* Two patches to revert the use of default domains in the ARM
	  SMMU driver. Enabling this caused regressions which need more
	  thorough fixing. So the regressions are fixed for now by
	  disabling the use of default domains.

	* A fix for a v4.4 regression in the AMD IOMMU driver which
	  broke devices behind invisible PCIe-to-PCI bridges with IOMMU
	  enabled.

----------------------------------------------------------------
Joerg Roedel (1):
      iommu/amd: Fix checking of pci dma aliases

Robin Murphy (1):
      iommu/arm-smmu: Don't allocate resources for bypass domains

Will Deacon (1):
      iommu/arm-smmu: Fix stream-match conflict with IOMMU_DOMAIN_DMA

 drivers/iommu/amd_iommu.c | 87 +++++++++++++++++++++++++++++++++++++++++------
 drivers/iommu/arm-smmu.c  | 22 ++++++++----
 2 files changed, 91 insertions(+), 18 deletions(-)

Please pull.

Thanks,

	Joerg

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXGfU5AAoJECvwRC2XARrjWvcP/RtQE4s4GM0BEU8E/m8up3RU
dVYlunexOS8e8YromHa5nQL0gOhj/YEQxolICFuzYLUxES7akbSnr1YEAqPVpdjl
fdMeYfWWeuC8AeNLrB4okURkWWz4z2CTHCUgV93uTvM6y6chB+9ocViRX7co6RlD
G60gl5wwTQMXrKwrmpV3lr79BMKQzL9eIgK0Gb0qdm03Q/sQAGU9py3yht5uSqtJ
+TUBw84MvKz0XnSgdqYg4ii5xTaZtWjI55fIFUj2A1G8dfP8mRRaCxEq9BfJUNNO
Oj3EADYvKnP+JBT0w8cJ1+FLoscb8VPXcAP/29aU0d1Coi7oAtYErdG/oZ/8s+DV
qwzjCUnkoxGhZgfl5Ip9yY7EBbLPSSlkDiERq8fBHzXTnBmaeM+fc22QUYUlwdQ9
Ei+t4N1OROHDvUhk7UUXMPKlLVOh3WYcqa0yUOBosQ8sPiKJ2k+agNzDAfWgfYPM
03/Gj9RA7ry11TY7F0p0Ls3oc1WWdgKuyiqoOvGnOygEzukHjv7gA+5iPPemJx64
hXngPeetU+9vCf86CqcrkJq5UtO1ixs/nMVbI8BrOtq2QzKmTROQ34mWmEhgW76Y
p2eOEYVHkpIAo4GCac943NKriDyb6CP7Nl1oG+Daj0sfkiWJmFCC8jbgjKL7kenR
4Ubhif5lJ43ujzeu5OiS
=xowM
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

--===============7793747332937527516==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7793747332937527516==--
