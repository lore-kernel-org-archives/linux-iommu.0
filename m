From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.3-rc7
Date: Mon, 26 Oct 2015 17:19:59 +0900
Message-ID: <20151026081958.GA7672@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2655167470590666492=="
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


--===============2655167470590666492==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 5adad9915472e180712030d730cdc476c6f8a60b:

  iommu/amd: Fix NULL pointer deref on device detach (2015-10-09 17:59:33 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.3-rc7

for you to fetch changes up to cbf3ccd09d683abf1cacd36e3640872ee912d99b:

  iommu/amd: Don't clear DTE flags when modifying it (2015-10-21 11:29:06 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.3-rc7

Two late fixes for the AMD IOMMU driver:

	* One adds an additional check to the io page-fault handler to
	  avoid a BUG_ON being hit in handle_mm_fault()

	* Second patch fixes a problem with devices writing to the
	  system management area and were blocked by the IOMMU because
	  the driver wrongly cleared out the DTE flags allowing that
	  access.

----------------------------------------------------------------
Jay Cornwall (1):
      iommu/amd: Fix BUG when faulting a PROT_NONE VMA

Joerg Roedel (1):
      iommu/amd: Don't clear DTE flags when modifying it

 drivers/iommu/amd_iommu.c       | 4 ++--
 drivers/iommu/amd_iommu_types.h | 1 +
 drivers/iommu/amd_iommu_v2.c    | 7 +++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

Please pull.

Thanks,

	Joerg


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWLeIuAAoJECvwRC2XARrjQrMQAJzvCmZjaebuPV+NVgTNo57M
k0lq961i9cqPrEtr9GyzNnnVB2W6wT4n5SgSbbbfBF+rNI5YsmWNs6k78riHJw89
IBI2KF7WkMK3bah38A+kk94XYWtnmdNsuKAfl/5h949StCb2LW60jy8iKlKQonIi
F7EDm3WZwhBdQ3ix4dEjUpZZf0HstTlsuHujp2qfoilBbqTnLGSkuGrlJ707iSBL
PbdOuEVuSJ1JJ5VWvDxqVauLP+29ztzb7Sus6WhwKGth442XOWOAIQUAdur8rIAE
polRSW/MxanOYEJSVVkfT5ZZdLAsa7wj/HpQP6waXWtGeOI6eDeGPoGyewUYsYdx
Hmb92XdTzccz696LeIVSGQeW/SAOPlyQubfkTOfyemf8QzVlkZotEXnVkz287XZy
fPAbejiAEiQtxqWYwekzy7bAI0eR5FT/W6/eoGA0t2FcJxQ3e+M5MIOfdVAp6iLe
bE1mH6/IDryMDsiN/waBu0fsVwf6T95zdHBKpep3GpN30i8rRuaIYtYB3H6p8iYc
6TuY5gTJj+8rpDmbM4BUWF71ygH5BZhgAMbL9cyOu+A/2YYW9tVJfLQHJm35sBSJ
78GJmKVjAsxU87Z3AJvjmX+OmgFhnNr/7ToUr6T/d3Qlqhj7yiuN+nxUa1hmFRTk
jhZuHc+m7cMdRksGF68z
=wH7p
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============2655167470590666492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2655167470590666492==--
