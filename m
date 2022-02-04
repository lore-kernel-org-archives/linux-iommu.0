Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1142CC433FE
	for <iommu@archiver.kernel.org>; Fri,  4 Feb 2022 15:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B465680C29;
	Fri,  4 Feb 2022 15:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZX1iff_uCIJP; Fri,  4 Feb 2022 15:49:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F1B880C33;
	Fri,  4 Feb 2022 15:49:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66FC0C0011;
	Fri,  4 Feb 2022 15:49:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1FB4C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 15:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9114D600B4
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 15:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dnFuXapWNzqq for <iommu@lists.linux-foundation.org>;
 Fri,  4 Feb 2022 15:49:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D626C60A8C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Feb 2022 15:49:56 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id C014836A; Fri,  4 Feb 2022 16:49:54 +0100 (CET)
Date: Fri, 4 Feb 2022 16:49:53 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.17-rc2
Message-ID: <Yf1LITyFpv5yAUNJ@8bytes.org>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8695406257147315956=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8695406257147315956==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZbT9qK9E8AKZwGNr"
Content-Disposition: inline


--ZbT9qK9E8AKZwGNr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.17-rc2

for you to fetch changes up to 9b45a7738eec52bf0f5d8d3d54e822962781c5f2:

  iommu/amd: Fix loop timeout issue in iommu_ga_log_enable() (2022-02-04 12:57:26 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.17-rc2

Including:

	- Warning fixes and a fix for a potential use-after-free in
	  IOMMU core code

	- Another potential memory leak fix for the Intel VT-d driver

	- Fix for an IO polling loop timeout issue in the AMD IOMMU
	  driver

----------------------------------------------------------------
Guoqing Jiang (1):
      iommu/vt-d: Fix potential memory leak in intel_setup_irq_remapping()

Joerg Roedel (1):
      iommu/amd: Fix loop timeout issue in iommu_ga_log_enable()

John Garry (1):
      iommu: Fix some W=1 warnings

Vijayanand Jitta (1):
      iommu: Fix potential use-after-free during probe

 drivers/iommu/amd/init.c            |  2 ++
 drivers/iommu/intel/irq_remapping.c | 13 ++++++++++---
 drivers/iommu/ioasid.c              |  1 +
 drivers/iommu/iommu.c               | 33 +++++++++++++++++++--------------
 drivers/iommu/omap-iommu.c          |  2 +-
 5 files changed, 33 insertions(+), 18 deletions(-)

Please pull.

Thanks,

	Joerg

--ZbT9qK9E8AKZwGNr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmH9SyEACgkQK/BELZcB
GuOzRQ/+NruR8YEI/iqLztKrrEUvgn+TLtxe24qZC9GR9sCVqRpSy9u7xj/W4MpK
OQqyuJNhPqLd4i8NdToAmjOLhibjwV1Muv09/65Kvfw52I/JukPDat8mAqy5kwAf
XsKiiLmgxYIvlXsy5NTJEOUjaLC+2curn5pnDLvLVN6unOxsyUqMm1DzjyVR6jr+
+IivXrRVJT295WQNhI3lDPGEPPMxeABD/uFLNbBxS5LrEmMae5YFfAREvuV2HBxq
b2E/8nx+wFSE13nqMBg/8StkXgitsQ2mD9gzkX55sP/o1Jm65PN4/oG7BSxSAoJI
PrqtlYVAnxi16KeMZZF43XfGfdYJPAHQLPdWzF2t2SxEO52lv1N+iYpK+rgVTDcG
FiBsy901zE+3eBL8iDOAnsWB9ZLP78OqP7FEUu36zR2YPACBGw+6MZEbz6c/FZso
9HG0XGwVaXWWpvnx9tmg0B5mfPW2W4tektVF29ZRf8LlQGU5qcDCP8SK89dtUd8q
H4xhntVEFQhNVHowUvAtCJW8vXqsFXX9iCnclYIv5Jbir2nlo45JtJ4mUqjy7K1B
R3uPG4BtrBrANCrTkrdftggNqHUtrmGyhW8GPMGc2bh92VoB3LxXDxMMbCNw72EG
CpgA7BRRFLCD638ZgNV32tXEd67ZTWZytvPQlh9W2JKuklK1cjs=
=Baa5
-----END PGP SIGNATURE-----

--ZbT9qK9E8AKZwGNr--

--===============8695406257147315956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8695406257147315956==--
