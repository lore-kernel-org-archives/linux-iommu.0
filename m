From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [git pull] IOMMU Fixes for Linux v3.17-rc4
Date: Fri, 12 Sep 2014 15:48:04 +0200
Message-ID: <20140912134804.GA15033@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0836103601400942137=="
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
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org


--===============0836103601400942137==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v3.17-rc4

for you to fetch changes up to 5a9137a66b521d667236e95c307b92af532fe600:

  iommu/fsl: Fix warning resulting from adding PCI device twice (2014-09-05 16:01:46 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v3.17-rc4

Including:

	* Two fixes for issues found by Coverity
	* Various fixes for the ARM SMMU driver
	* A warning fix for the FSL PAMU driver

----------------------------------------------------------------
Hans Wennborg (1):
      iommu/arm-smmu: fix decimal printf format specifiers prefixed with 0x

Joerg Roedel (3):
      iommu/core: Make iommu_group_get_for_dev() more robust
      iommu/vt-d: Check return value of acpi_bus_get_device()
      Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/.../will/linux into iommu/fixes

Mitchel Humpherys (1):
      iommu/arm-smmu: avoid calling request_irq in atomic context

Olav Haugan (2):
      iommu/arm-smmu: fix programming of SMMU_CBn_TCR for stage 1
      iommu/arm-smmu: Do not access non-existing S2CR registers

Varun Sethi (1):
      iommu/fsl: Fix warning resulting from adding PCI device twice

Vladimir Murzin (1):
      iommu/arm-smmu: remove pgtable_page_{c,d}tor()

Will Deacon (2):
      iommu/arm-smmu: fix s2cr and smr teardown on device detach from domain
      iommu/arm-smmu: fix corner cases in address size calculations

 drivers/iommu/arm-smmu.c        | 127 +++++++++++++++++++++++-----------------
 drivers/iommu/dmar.c            |   3 +-
 drivers/iommu/fsl_pamu_domain.c |  10 +++-
 drivers/iommu/iommu.c           |   8 ++-
 4 files changed, 87 insertions(+), 61 deletions(-)

Please pull.

Thanks,

	Joerg


--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJUEvmTAAoJECvwRC2XARrjIewP/jCwy/VwfwJ2r5mwDBNOtfiY
86o09Uy80Svs1H6sc/SfQ8Ad2FUa2Js/xAR2HPU/Goj7UAE3uhrIk7WNwUqMhAPP
i/LSW9JmlMARVk2VL4d1LMvXtHcqvWx5OAL8kOX/SxAvJdZ9p2DB3WlVQ8XEvJQd
9HcnZO20KNaG3bms3SrgZ0Ha6IAOYybcqP5fPiaAKY1fvdOJxReA88U1RCTE8L8J
BENmuGkbkukb4XRRaH7C7ASfgDePBR5C/kn4egZV3brQz2qO/otHDhC8c9ng8K6q
L5faNTGtJmgRitRzuNiYDUmHgsA+n9g9N6YVv6jF3bjWV27WbDzPQL4RFE2MDb66
YADZB4ppZboHWVFRfpYF9Xxxc86EHzeCdE6hJkrLpgdMpQcRe/uRAAN0PKA1bOPY
5UTWn5yWQiSElGGtnXj/MUvVwT3xN/ERtPuX8bTOZjBA0uSapkM/onIgBzMBFxRm
NC57KS1L3LeaggUpfhAKbKRnWXZC2Y/F9hzZWpCEtp7rqIErjO54U4pA/4PzIQTP
sDv4slQcybzy+Xl4WQaS1aeugarfNxQki7YGXf/1ciPzZg1MoOLfQs/uTvUk/GbR
B3iFv6//X2G2Q7liol5yYHslgSY7MQWXO/El/Al6KlV2OcPsvMJdasi3eZLwcw73
ZWfGI1wnKH6qrGygTeUa
=Hmbl
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--

--===============0836103601400942137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0836103601400942137==--
