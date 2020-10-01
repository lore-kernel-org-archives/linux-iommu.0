Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A11C4727E
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 18:50:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22A620882
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 18:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22A620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6715A8736A;
	Thu,  1 Oct 2020 18:50:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LXX85wtRysdh; Thu,  1 Oct 2020 18:50:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E14298735C;
	Thu,  1 Oct 2020 18:50:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5691C0889;
	Thu,  1 Oct 2020 18:50:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71ACBC0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 18:50:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5B8808736A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 18:50:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MRV+1LUEUzWx for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 18:50:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 432EA8735C
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 18:50:34 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 76EA02C3; Thu,  1 Oct 2020 20:50:31 +0200 (CEST)
Date: Thu, 1 Oct 2020 20:50:30 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.9-rc7
Message-ID: <20201001185024.GA3327@8bytes.org>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============6353679198961321062=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6353679198961321062==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ba4f184e126b751d1bffad5897f263108befc780:

  Linux 5.9-rc6 (2020-09-20 16:33:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc7

for you to fetch changes up to 1a3f2fd7fc4e8f24510830e265de2ffb8e3300d2:

  iommu/vt-d: Fix lockdep splat in iommu_flush_dev_iotlb() (2020-10-01 14:54:17 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.9-rc7

Including:

	- Fix a device reference counting bug in the Exynos IOMMU
	  driver.

	- Lockdep fix for the Intel VT-d driver.

	- Fix a bug in the AMD IOMMU driver which caused corruption of
	  the IVRS ACPI table and caused IOMMU driver initialization
	  failures in kdump kernels.

----------------------------------------------------------------
Adrian Huang (1):
      iommu/amd: Fix the overwritten field in IVMD header

Lu Baolu (1):
      iommu/vt-d: Fix lockdep splat in iommu_flush_dev_iotlb()

Yu Kuai (1):
      iommu/exynos: add missing put_device() call in exynos_iommu_of_xlate()

 drivers/iommu/amd/init.c     | 56 ++++++++------------------------------------
 drivers/iommu/exynos-iommu.c |  8 +++++--
 drivers/iommu/intel/iommu.c  |  4 ++--
 3 files changed, 18 insertions(+), 50 deletions(-)

Please pull.

Thanks,

	Joerg

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl92JPAACgkQK/BELZcB
GuMIhg/9GctD/xz7BHZMIkJKRrc71epdmDSh6+5ruSv3V/dzW1EU17Pv0IWjeOdF
dOpKUZzCCYYM6ra+4QHQ2CChHSWREj1kFKnilRV4E3DGXRY51lJCzIMjSOU4Prv1
frgx+3h1sVkigLjP9s+xXM9LsM72FO8p7eW+Bylr4s4lES4TX7V5uIiVdIY0900j
EtE7MeFK1cu/oONqVaNT5Wrqx6OaCH4DuPoOiyc/FhHQB/VVWckoto8Hbh2VxtTV
gWwzD++XyM8Vz+TkcxG0caIYNeplDmknIIVN9zqqprYrbsy8CO5hByNMGXjJmITd
HDIPuB64Ev8EeY2iWO5xQeBMXkP2Tf373Jqu34q8fe/Wfn8m97/1hYvFuJAEZqhv
+jvDvdYnaeUPnLNKfgK/vGIsJlW+JQjtJhQbfkCSP6flzPhsSxF6QF7ckkfuiX+c
vIiMLifggcT94ZLCl9/KAbx/axCBAvgmxvN+Cp3KD021frNMLLMuC9VmcgFYfixU
GS2akMdxWphS2d0rOjWm4S3H9RxO5+rPRRCQ+yzm/PtWCec0961kWyu66NEMc0W1
bTxcWV3HnSHKut8qbg/EAeFBAoWcpgMZig8AhyacKDQT52s9YTGK3iCRoBythFr3
Hu21BUfjspw/7bcvm8772AhS3fHKFyyGijAcAguFLlfTwf/IDO4=
=ChUR
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--

--===============6353679198961321062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6353679198961321062==--
