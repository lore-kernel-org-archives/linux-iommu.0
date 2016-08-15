From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.8-rc2
Date: Mon, 15 Aug 2016 12:01:30 +0200
Message-ID: <20160815100121.GA15241@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5201861222144043933=="
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


--===============5201861222144043933==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.8-rc2

for you to fetch changes up to c987ff0d3cb37d7fe1ddaa370811dfd9f73643fa:

  iommu/dma: Respect IOMMU aperture when allocating (2016-08-10 12:02:02 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.8-rc2

Including:

	* Some functions defined in a header file for the mediatek
	  driver were not marked inline. Fix that oversight.

	* Fix a potential crash in the ARM64 dma-mapping code when
	  freeing a partially initialized domain.

	* Another fix for ARM64 dma-mapping to respect IOMMU mapping
	  constraints when allocating IOVA addresses.

----------------------------------------------------------------
Joerg Roedel (1):
      iommu/mediatek: Mark static functions in headers inline

Robin Murphy (2):
      iommu/dma: Don't put uninitialised IOVA domains
      iommu/dma: Respect IOMMU aperture when allocating

 drivers/iommu/dma-iommu.c | 14 +++++++++-----
 drivers/iommu/mtk_iommu.h |  6 +++---
 2 files changed, 12 insertions(+), 8 deletions(-)

Please pull.

Thanks,

	Joerg

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXsZLxAAoJECvwRC2XARrjyFkP+wQcNJwpV6njClt6Q3pzPR4e
y56+OgcFLkR1w74qH5IEPeuQhBmZPRKjHnj80p7Me1aFpSB9CzDKncV7FWJZsojE
oLM50ZGKLyjZ51FjjO00GDkto79tpVSAGV9qftaEA+u6FWY9up1TK84jL6Ase7Nx
dU9G9wvUN7fWzAS6dL87trBgoyZ9LG9JfjI/hQc1HP3IKLC9ZXFBn+mrmg4jMZlL
7CpbiSbYdcelWQf0wMuzH4Jnuu9OUV/xOXcRL1wG2kokEhrfEzg2Gd/l3YBXduOo
KHmjhtgXW1udBx8DDU+Rq4TIbcEZgjxAADxyP5fbk7t2CFxZQxZ22KsqyMdkwekG
r+6iGgRnS1MKJwW+SfTY/PciOChKWYjXHqBtn5dm+SUO03v3krpOAaR+Sbb6l5L5
un4j46c0TdVry/swTjk2+SvwuWTSmFnsKbEtGmKIK4YKk8HEYKHvlDdpJ0Uv+E/u
gu/gj53/QXeii/4/r4c9+mMYOywGogoMC+KwArWB54+4+DN7sOqN+vXxMizXdJxV
IUHEeBFJb0orEawe+wKUwWi1QRfFged77tBjsz6f+d3DrpsOKXyv2FlpUevDCCvk
8FboG3hyDKAVO9n6SGXHBNVud7RMbaHPw7SsmZSy486yPpLAMW5cndH+vPr08I/K
eWukDeHIP+CY+HQrpQnj
=ufff
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--===============5201861222144043933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5201861222144043933==--
