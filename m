From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.7-rc3
Date: Fri, 17 Jun 2016 16:38:58 +0200
Message-ID: <20160617143845.GA25478@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5077237496355729758=="
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


--===============5077237496355729758==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5edb56491d4812c42175980759da53388e5d86f5:

  Linux 4.7-rc3 (2016-06-12 07:20:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.7-rc3

for you to fetch changes up to a4c34ff1c029e90e7d5f8dd8d29b0a93b31c3cb2:

  iommu/vt-d: Enable QI on all IOMMUs before setting root entry (2016-06-17 11:29:48 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.7-rc3

Three patches queued up:

	* Fix for ARM-SMMU to add a missing iommu-ops callback which is
	  required by common iommu code

	* Fix for the rockchip iommu where the wrong MMUs got the
	  commands

	* A regression fix for the Intel VT-d driver. The regression
	  only showed up on X58 chipsets with more than one iommu. These
	  chipsets seem to require that QI is enabled on all IOMMUs
	  before it can be used.

----------------------------------------------------------------
Jean-Philippe Brucker (1):
      iommu/arm-smmu: Wire up map_sg for arm-smmu-v3

Joerg Roedel (1):
      iommu/vt-d: Enable QI on all IOMMUs before setting root entry

John Keeping (1):
      iommu/rockchip: Fix zap cache during device attach

 drivers/iommu/arm-smmu-v3.c    |  1 +
 drivers/iommu/intel-iommu.c    | 17 ++++++++++++-----
 drivers/iommu/rockchip-iommu.c |  2 +-
 3 files changed, 14 insertions(+), 6 deletions(-)

Please pull.

Thanks,

	Joerg

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJXZAt1AAoJECvwRC2XARrj8IgP/RAPHphtmZhSd2vgdiUJSC8G
v/Xq9ttdJQwL+W223B5r7iDppFD19QMMsmEJWFRS7mnpT8ljlfxacHII4c7GyV4G
yfNG/ueLTPmNa8reKDlpsOaFfuWcSTBG5p0c5DzspNUDeTqP8LMWANA57TUfQZ8d
55uncvuKq/2MIIaZ7Y/712HxlXhw6rWKHeca2wjKah1c3SNdtZUVs7OZ+bZW0wx9
3owfNAuJ01Bd98QtWEHeDpMCcFZb1eeNCSgYVqN/LALGh36w3KZLYuE+tIWjthB+
gJ8tqEz+zNc4YY1F1qJGRzLcpo+R8yezVdojLF4iyLhQP9Y1GOWC3I+iKsSWJ0+2
hDQYhVk2xAqrYHf4jyTroEknHi0sE1iL/OhKN/LrvJouXd5Tan31Iqw6wViFVGte
0ITxei4Rj8t3nbzZRK74OR04zD8tLWdIPF8r5Oj1n+1PEqDEBWyrAQnoxCt1zTX1
R8P7JmQL8XW70xYSPeSEPYvD2JpIkTyKppsz+dxUCd8X9+KYsOvVmo0gCikOyXYs
uzNQgrz3VOm0PQEC1V2/tqNZeVY6ltUkHOSiwZ8E/eueKHQ2vHcB9A+PppVO/oru
xKAs4QmPhQq4e72OGaSaxJMPvrep2k+lKIlLkC2Px1qHxTXzKNLgVJesTPHKNAot
4TTxRrh/cmZ6tSmyDNd7
=XPte
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

--===============5077237496355729758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5077237496355729758==--
