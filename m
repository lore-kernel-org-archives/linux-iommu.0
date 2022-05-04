Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC773C433F5
	for <iommu@archiver.kernel.org>; Wed,  4 May 2022 15:57:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AEC440961;
	Wed,  4 May 2022 15:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CvO1tClQDpDT; Wed,  4 May 2022 15:57:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1DE59408F6;
	Wed,  4 May 2022 15:57:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E991AC0039;
	Wed,  4 May 2022 15:57:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D01DC002D
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EFA8E81CE9
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:57:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1HW-NmykFavv for <iommu@lists.linux-foundation.org>;
 Wed,  4 May 2022 15:57:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 105CB81C58
 for <iommu@lists.linux-foundation.org>; Wed,  4 May 2022 15:57:51 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A091F3FA; Wed,  4 May 2022 17:57:48 +0200 (CEST)
Date: Wed, 4 May 2022 17:57:47 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] IOMMU Fixes for Linux v5.18-rc5
Message-ID: <YnKie9R0RhJsGMz9@8bytes.org>
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
Content-Type: multipart/mixed; boundary="===============5848448297248965336=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============5848448297248965336==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dv9q/IqokSHqWzfx"
Content-Disposition: inline


--dv9q/IqokSHqWzfx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iomm-fixes-v5.18-rc5

for you to fetch changes up to 392bf51946c2463436a1ba237c1ec5865b234825:

  iommu: Make sysfs robust for non-API groups (2022-05-04 15:13:39 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.18-rc5

Including:

	- Fix for a regression in IOMMU core code which could cause NULL-ptr
	  dereferences

	- Arm SMMU fixes for 5.18
	  - Fix off-by-one in SMMUv3 SVA TLB invalidation
	  - Disable large mappings to workaround nvidia erratum

	- Intel VT-d fixes
	  - Handle PCI stop marker messages in IOMMU driver to meet the
	    requirement of I/O page fault handling framework.
	  - Calculate a feasible mask for non-aligned page-selective IOTLB
	    invalidation.

	- Two fixes for Apple DART IOMMU driver
	  - Fix potential NULL-ptr dereference
	  - Set module owner

----------------------------------------------------------------
Ashish Mhetre (1):
      iommu: arm-smmu: disable large page mappings for Nvidia arm-smmu

David Stevens (1):
      iommu/vt-d: Calculate mask for non-aligned flushes

Hector Martin (1):
      iommu/dart: Add missing module owner to ops structure

Joerg Roedel (1):
      Merge tag 'arm-smmu-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux into iommu/fixes

Lu Baolu (1):
      iommu/vt-d: Drop stop marker messages

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix size calculation in arm_smmu_mm_invalidate_range()

Robin Murphy (1):
      iommu: Make sysfs robust for non-API groups

Yang Yingliang (1):
      iommu/dart: check return value after calling platform_get_resource()

 drivers/iommu/apple-dart.c                      | 10 ++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c |  9 +++++++-
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c    | 30 +++++++++++++++++++++++++
 drivers/iommu/intel/iommu.c                     | 27 +++++++++++++++++++---
 drivers/iommu/intel/svm.c                       |  4 ++++
 drivers/iommu/iommu.c                           |  9 +++++++-
 6 files changed, 79 insertions(+), 10 deletions(-)

Please pull.

Thanks,

	Joerg

--dv9q/IqokSHqWzfx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAmJyonsACgkQK/BELZcB
GuN9mhAA3Ew/O0xkKnZ3nyHVoSXaTifytAc3kotV/KKKKjXrPUVoVQH2ggWZARvj
o2ntI+C8Wf5KkTdVV9KLzWRcPa39ycvgK5Yi1emaFvQuYfxJNVV4nBR3D4bv55AM
f3XdkpJgaRmbw0y/drxraLrennlGDd+aLtiAcJZeejfVkAW5CkOwJPVeOAI/5RqH
wuNgrGtoItdIsbxgW4Vx5vNbXApRS2iKzDwQt7vBTnvnVbxzogjU3WM+1kPjUMSb
ADM1/29Ujg4o2hX4CCeUdvyLhUX8NUXW3v9mhvVNNNf+XnW4rHwyTstMj/lC3DNy
yunf5XMA+o8WlZDcYRh29da9tTH7YRJmOVqwn5V8bOKa2OJSCH38Dm1n5XnDWNLl
yjlM6j2iPnz7fZf9lXzMxCAyxuoZ3YEmSQGILMZUYifvIpdumZ4ymcB5YtwJlYjn
7hffrNz0Bt/VptE/w2pU5boDveEpwFL03t5y5LdDhOf6cIW68ZP8Ut8wBlkbu+0K
YXxpdPn4FcieO2dW/IbXGr6IQ7cecMjAwJVOYX2Hmd1/725sSgCnFP2hwZPn21x6
1EDDiL107HC3y2p+K9R/6vKQuog1mp+ABFs4hXjRkpCJ3mFQI5GsfPgPeEhoirSk
638vDCX6tSvVxbi39DdfMtblbA/67y079JMJi5yH8FetsJ1vyng=
=GbgG
-----END PGP SIGNATURE-----

--dv9q/IqokSHqWzfx--

--===============5848448297248965336==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============5848448297248965336==--
