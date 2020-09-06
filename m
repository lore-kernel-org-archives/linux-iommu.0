Return-Path: <SRS0=6KmI=CP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF544C43461
	for <iommu@archiver.kernel.org>; Sun,  6 Sep 2020 15:01:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543FA20714
	for <iommu@archiver.kernel.org>; Sun,  6 Sep 2020 15:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543FA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 08CBD86864;
	Sun,  6 Sep 2020 15:01:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gu3EGlEVEN-I; Sun,  6 Sep 2020 15:01:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5DD8781AD1;
	Sun,  6 Sep 2020 15:01:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48013C0859;
	Sun,  6 Sep 2020 15:01:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCDC1C0051
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 15:01:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B50168560C
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 15:01:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gQFfW57S5Cl5 for <iommu@lists.linux-foundation.org>;
 Sun,  6 Sep 2020 15:01:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6BD468560B
 for <iommu@lists.linux-foundation.org>; Sun,  6 Sep 2020 15:01:24 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 6E14839B; Sun,  6 Sep 2020 17:01:21 +0200 (CEST)
Date: Sun, 6 Sep 2020 17:01:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.9-rc3
Message-ID: <20200906150115.GA29365@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============5440895937591338522=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5440895937591338522==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.9-rc3

for you to fetch changes up to 29aaebbca4abc4cceb38738483051abefafb6950:

  iommu/vt-d: Handle 36bit addressing for x86-32 (2020-09-04 12:14:28 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.9-rc3

Including:

	- Three Intel VT-d fixes to fix address handling on 32bit, fix a
	  NULL pointer dereference bug and serialize a hardware register
	  access as required by the VT-d spec.

	- Two patches for AMD IOMMU to force AMD GPUs into translation mode
	  when memory encryption is active and disallow using IOMMUv2
	  functionality. This makes the AMDGPU driver working when
	  memory encryption is active.

	- Two more fixes for AMD IOMMU to fix updating the Interrupt
	  Remapping Table Entries.

	- MAINTAINERS file update for the Qualcom IOMMU driver.

----------------------------------------------------------------
Chris Wilson (1):
      iommu/vt-d: Handle 36bit addressing for x86-32

Joerg Roedel (2):
      iommu/amd: Do not force direct mapping when SME is active
      iommu/amd: Do not use IOMMUv2 functionality when SME is active

Lu Baolu (2):
      iommu/vt-d: Serialize IOMMU GCMD register modifications
      iommu/vt-d: Fix NULL pointer dereference in dev_iommu_priv_set()

Lukas Bulwahn (1):
      MAINTAINERS: Update QUALCOMM IOMMU after Arm SMMU drivers move

Suravee Suthikulpanit (2):
      iommu/amd: Restore IRTE.RemapEn bit after programming IRTE
      iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE

 MAINTAINERS                         |   2 +-
 drivers/iommu/amd/Kconfig           |   2 +-
 drivers/iommu/amd/init.c            |  21 ++++++-
 drivers/iommu/amd/iommu.c           |  26 ++++++--
 drivers/iommu/amd/iommu_v2.c        |   7 +++
 drivers/iommu/intel/iommu.c         | 114 ++++++++++++++++++++----------------
 drivers/iommu/intel/irq_remapping.c |  10 +++-
 7 files changed, 119 insertions(+), 63 deletions(-)

Please pull.

Thanks,

	Joerg

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl9U+bsACgkQK/BELZcB
GuOQFA/9FEF/OAEBiLBSlFtyFVNEoVadWTs2RrTmOnXUfufE8dnHCKA3/7qKKDD4
WwwDZbdPueRQbo/G7REbDkKNrUr+UkRieMWnlpEhXD7w8dV94oVpwKSBHQhR/RZ6
uzfKHUPth8ttozSxA5PaHdLsxcOB9MMO+wF1JKTURIa1P/5dXmmc3H2Uqmpf6uuG
GOjlWqTx5lvrnhqGkCIj4TYJiILk2dwbIKcMPCz3FSbvstU9nIXXlJtKAFfDv2m3
xW+r4M5NXgISI/8Tu8ihAJrP94in2qxauCcbUw+6IMaEtsLhct60PRDf/rPjtQbO
f8a/EIZPttsfAgkWOxxDT0GtBAzzYtNpcEOEOSDhEBQL68WpTr+nUM3VJp+ZahVa
fkLM461BonEY4Pqb6PBe2lSWCuMuP2KmpUiZf8Z6hbUOhOB6Z2k4IdDy+Th55Ag3
AcDbVAVmQ+nG1H0GhRVbKmIvD4wSvYqIqj2nDqpR8gTugz0XfzS2eHoGKm3EJFOJ
TkjZunRUcHk+H3MMexjZfMSnFVheGB1KAXcbhPfXg8qmcKgnk8QdxHtwkqB3yXs0
KaqQdzoAIT4Ti7kj6LHlMEw1xbU64NmE9JWqWaMQ3yG98oLAQVD9sO6QZBAzyv83
e4A782NG0EZ2jNXkPivcfRgfvDetY3tlBfOMuW+rqMQYljRM/ZQ=
=8Q1t
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--

--===============5440895937591338522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5440895937591338522==--
