From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.2-rc4
Date: Fri, 31 Jul 2015 18:58:24 +0200
Message-ID: <20150731165824.GA26903@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4344521275210196451=="
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


--===============4344521275210196451==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit cbfe8fa6cd672011c755c3cd85c9ffd4e2d10a6f:

  Linux 4.2-rc4 (2015-07-26 12:26:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.2-rc4

for you to fetch changes up to 1c1cc454aa694a89572689515fdaaf27b8c9f42a:

  iommu/amd: Allow non-ATS devices in IOMMUv2 domains (2015-07-31 15:15:41 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.2-rc4

These fixes are all for the AMD IOMMU driver:

	* A regression with HSA caused by the conversion of the driver to
	  default domains. The fixes make sure that an HSA device can
	  still be attached to an IOMMUv2 domain and that these domains
	  also allow non-IOMMUv2 capable devices.

	* Fix iommu=pt mode which did not work because the dma_ops where
	  set to nommu_ops, which breaks devices that can only do 32bit
	  DMA.

	* Fix an issue with non-PCI devices not working, because there
	  are no dma_ops for them. This issue was discovered recently as
	  new AMD x86 platforms have non-PCI devices too.

----------------------------------------------------------------
Joerg Roedel (6):
      iommu/amd: Use iommu_attach_group()
      iommu/amd: Use iommu core for passthrough mode
      iommu/amd: Allow non-IOMMUv2 devices in IOMMUv2 domains
      iommu/amd: Use swiotlb in passthrough mode
      iommu/amd: Set global dma_ops if swiotlb is disabled
      iommu/amd: Allow non-ATS devices in IOMMUv2 domains

 drivers/iommu/amd_iommu.c      | 98 +++++++++++++-----------------------------
 drivers/iommu/amd_iommu_init.c | 10 +----
 drivers/iommu/amd_iommu_v2.c   | 24 +++++++++--
 3 files changed, 51 insertions(+), 81 deletions(-)

Please pull.

Thanks,

	Joerg


--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVu6kwAAoJECvwRC2XARrj+6EP/0KhMJAIS9pbq/6BsXAqQyFb
xOtCc5nyILxfO9ahU4Z2vHrOeh1RWGrjRx0SEprre/xBzLJDbbRWSTSYOZaELbGs
NLlOB5LEK5H4OqxY7fNpExYo60GsKLc7kATTQw6tIAV5WlzJcI2CQz3+OfP3PC0r
N6yIMPyIb51uNEqJQPJgoU+Tqd6A+FIVNiWuBE/uDcNuEN5ozuK4BlSnARnFdB1l
RNCiEHk78FTpnqGFsX3G/mGiWbpcUjNqwvdkscoYXbq5GR2MAsmR/oAM6xbOX9CJ
sWHvzhk7JGTYxVtrC8j2N/gUbLEDZjyX9DtP1zNEXKBHqihOVHUKv+1uIICIsEL7
Vw+3VkXUiD4QaudaQcVAKhZg+o9i/jDJWL+Y1P/vvTtMDl6wdoZR0+7f/kfbgTVk
VnFFzmJcUzN+JULpyjV7GzUgcWKxwTQkdVBZQg0GMmkvKp/Zy5oGoRyudki6ykIr
Yg92gTVQRK0GxZXdx/fRGs4clzzQt3heDnH7KGAUTSVah5KqU0Q4OzQisE8E2a+z
7MODEFANOkMB2dr3MOZRNLmvP/Ru2v1muFv2VywjlODO2LPnxg90swvjvzJ5BBsE
hrq0dVUpbjXK1p4KS2gi49e1RK1KV2fJS7FIvEX2Ya+tkxc3x9Z+jMa6wZAnFMvD
/O8PSGXTH8+6ep2iH3nY
=jam2
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--

--===============4344521275210196451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4344521275210196451==--
