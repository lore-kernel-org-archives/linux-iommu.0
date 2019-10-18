Return-Path: <SRS0=1rIG=YL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A43CA9EA0
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 15:54:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AE22064B
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 15:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AE22064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 625C1ACD;
	Fri, 18 Oct 2019 15:54:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F046E3EE
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 15:54:12 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7EFC2608
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 15:54:12 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 5576C367; Fri, 18 Oct 2019 17:54:10 +0200 (CEST)
Date: Fri, 18 Oct 2019 17:54:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.4-rc3
Message-ID: <20191018155403.GA9621@8bytes.org>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: multipart/mixed; boundary="===============2727210756687323987=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============2727210756687323987==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.4-rc3

for you to fetch changes up to 46ac18c347b00be29b265c28209b0f3c38a1f142:

  iommu/amd: Check PM_LEVEL_SIZE() condition in locked section (2019-10-18 16:52:37 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.4-rc3:

Including:

	- Fixes for page-table issues on Mali GPUs

	- Missing free in an error path for ARM-SMMU

	- PASID decoding in the AMD IOMMU Event log code

	- Another update for the locking fixes in the AMD IOMMU driver

	- Reduce the calls to platform_get_irq() in the IPMMU-VMSA and
	  Rockchip IOMMUs to get rid of the warning message added to this
	  function recently

----------------------------------------------------------------
Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Only call platform_get_irq() when interrupt is mandatory

Heiko Stuebner (1):
      iommu/rockchip: Don't use platform_get_irq to implicitly count irqs

Joerg Roedel (2):
      Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/.../will/linux into iommu/fixes
      iommu/amd: Check PM_LEVEL_SIZE() condition in locked section

Liu Xiang (1):
      iommu/arm-smmu: Free context bitmap in the err path of arm_smmu_init_domain_context

Robin Murphy (2):
      iommu/io-pgtable-arm: Correct Mali attributes
      iommu/io-pgtable-arm: Support all Mali configurations

Suthikulpanit, Suravee (1):
      iommu/amd: Fix incorrect PASID decoding from event log

 drivers/iommu/amd_iommu.c       | 12 +++++----
 drivers/iommu/amd_iommu_types.h |  4 +--
 drivers/iommu/arm-smmu.c        |  1 +
 drivers/iommu/io-pgtable-arm.c  | 58 ++++++++++++++++++++++++++++++++---------
 drivers/iommu/ipmmu-vmsa.c      |  3 +--
 drivers/iommu/rockchip-iommu.c  | 19 ++++++++++----
 6 files changed, 70 insertions(+), 27 deletions(-)

Please pull.

Thanks,

	Joerg

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl2p4BgACgkQK/BELZcB
GuO8sA/9HtDW6b8w/r2XJOcxP01hP59c9AveS1VNwR2KyBjZepprg9geSmLz921G
063ozZ02UJ4gIZ3R/7nJ9oisQ3C2UGZz8/apPVm+hLu3/ywYLLDucuXLGmzc4Yyj
62Ya2Mvu4InK6TunBxxARgWHBXEIJN915usyy9oAMTSZtlshvkwZU36SrArVAbCY
SXdF3lT8aHqRN2FTNQo4B1/kiW9lPWKnXmBqs/zt6kvOzxHQtiusdpYZK8nubm7B
J3a2vyWpflwsf9yxMI/3B1Nlb/+GQlodg1KEuK20hZc3V9Ov4MDEI6P2ZcTTUywR
qprVn7MERqtNHT9Pna2O4bj7ugPdp44p2dI4lXJBxdBIavYx0F+nCbvLh8qpoC2v
Lkz1kDqf1Cz5FrlYroOsFCZfTpLo3cgFomm/KyRZCD0rSJxxLd/irV8TsmLZe2GQ
6fKxoCMpkq4HaXdT0+nA5NclY9z/UWNS8KvhmsF9djhVmgiE/viZkFAnyBUncN0z
vpd0jfy5M6DHT1aqBEfciVo/plcNpyaR8OqgdkInILOMAAWL3BTpGDpUmvHEu6x0
rkOWSAcLXRTvb6EKxqOvSx3bwW2DnthPhqxa0nnuK/yrDSK/lrT0YOpL3Pl2hwsR
0p0iqqIeHYPaiW+anmnRlA7Jd50Su/CweuXGG6QBn4IdMhUUOfQ=
=2SpP
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--===============2727210756687323987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2727210756687323987==--
