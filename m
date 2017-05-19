From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v4.12-rc1
Date: Fri, 19 May 2017 11:32:24 +0200
Message-ID: <20170519093218.GA6658@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3327733894776003941=="
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


--===============3327733894776003941==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v4.12-rc1

for you to fetch changes up to 745b6e74704782488dd875292bc49e24d23e81fd:

  iommu/mediatek: Include linux/dma-mapping.h (2017-05-17 14:51:54 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v4.12-rc1

Including:

	* Another compile-fix as a fallout of the recent header-file
	  cleanup

	* Add a missing IO/TLB flush to the Intel VT-d kdump code path

	* A fix for ARM64 dma code to only access initialized
	  iova_domain members

----------------------------------------------------------------
Arnd Bergmann (1):
      iommu/mediatek: Include linux/dma-mapping.h

KarimAllah Ahmed (1):
      iommu/vt-d: Flush the IOTLB to get rid of the initial kdump mappings

Robin Murphy (1):
      iommu/dma: Don't touch invalid iova_domain members

 drivers/iommu/dma-iommu.c    | 13 ++++++++-----
 drivers/iommu/intel-iommu.c  |  5 ++++-
 drivers/iommu/mtk_iommu_v1.c |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

Please pull.

Thanks,

	Joerg

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJZHruiAAoJECvwRC2XARrjbKgP+wSYD++A4DTZ2DoxFwIeeXtj
4XgN0uNN01uoiP3rvhH/EkTQmzuCioFRgM87xRPfb8v5mdSWkLJtLCaVgfcpEb2z
hxDkyGcMS14Zwfun/nqDF/fJRXUhpgQDQHedokZ7QM1bkPQ/isCZ3CVCFUQ1wMdV
jzulifLa5hFbynKni6bv9pYNVh5VGlUkHIVDKrWOj6OIHyQsM1cOnXQ4AUJx8LtJ
OIe09bHi4IbA7VK0RfaXshFevmmZr1jR8YzkLfg6gohHocQBe0dp/YO9Tq2RvX+O
Cm8OAQba0zU3RTtb8dNrOzPhJbbZfLTxIeb0eB8QqTv1B9ENjKQ79HcU/eKWO9x0
Iml+3uS4iNeOFkqthw74eTWQVonYVbk0qpg59UvdAybzZGQay3x3KhZ5sGnUiAXL
NlS4qt3H6DS9ZzqoVhJB8WbDvZCkkZqpFbKGZ9o2LvI5WiziOtTJWLtCCHbINLHJ
LDT8PB0eFTfxj/9WODSbA0SqclUgtBIOJAYF/WVVBhvbyBvl29kjpUtFZBBI33Ng
YMkSdpqKskB/Kw4a4xEMBHIu9ao/LOTB7TvUtIwaQEeebQV8CLB4b0hMEnAVMsCH
KfEQshN+MgGiGzxmrqe/RZ3NgC6QFeKmtpT4g9T7un04dFl1rO1f8eu8Yk4P4XLc
dHVb1x/RcCRjEwU3Buny
=yF9t
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--

--===============3327733894776003941==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3327733894776003941==--
