Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE619C433EF
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 07:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A5C640919;
	Mon, 24 Jan 2022 07:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oqB77FqfAORk; Mon, 24 Jan 2022 07:12:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 49F9040912;
	Mon, 24 Jan 2022 07:12:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DDBEC0031;
	Mon, 24 Jan 2022 07:12:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 443B8C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 07:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28EE140116
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 07:12:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hqxDD7dYhB6Z for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 07:12:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 52B53400F1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 07:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643008345; x=1674544345;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Uz8nnVAfjL27meYo3jRGFNPYe6YwRskFjRkD9zDxGkk=;
 b=PLOTZlfaVHuODGNizVoOVJ6hs1w913xLxMsliPqI6aoGtsYMJE67s1fb
 IClVeAzo255FFNYGfCGuVI9D3FeYrZxq2RPCwwI5/3PFnMat/C7Sy+W7P
 oHxenuvBWqzDKX0SjwBYjEfz3W7WKhVmcPG0tIzyTbam6Q01ms1iuMgd/
 4m9DTJppqg5g9jHIVXdA1mz634PpnORya8mnssBg7qsn6H6wOGs6vHHVC
 Y96sfAdjJQ6oXJZQ18b15GUxIoVsKQy+yP88LvR8dI6Sj/tXyjH0FeL3l
 Yu1HZ25QfUZURjVpcJ0Tj4GZGn1wzp+8TFMP8SkWvFoQj5rD5YYfN9j1z w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245925882"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="245925882"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2022 23:12:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; d="scan'208";a="627387741"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga004.jf.intel.com with ESMTP; 23 Jan 2022 23:12:20 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 0/7] iommu cleanup and refactoring
Date: Mon, 24 Jan 2022 15:10:55 +0800
Message-Id: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

The guest pasid and aux-domain related code are dead code in current
iommu subtree. As we have reached a consensus that all these features
should be based on the new iommufd framework (which is under active
development), the first part of this series removes and cleanups all
the dead code.

The second part of this series refactors the iommu_domain by moving all
domain-specific ops from iommu_ops to a new domain_ops. This makes an
iommu_domain self-contained and represent the abstraction of an I/O
translation table in the IOMMU subsystem. With different type of
iommu_domain providing different set of ops, it's easier to support more
types of I/O translation tables.

Please help to review and comment.

Best regards,
baolu

Lu Baolu (7):
  iommu/vt-d: Remove guest pasid related callbacks
  iommu: Remove guest pasid related interfaces and definitions
  iommu/vt-d: Remove aux-domain related callbacks
  iommu: Remove aux-domain related interfaces and iommu_ops
  drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
  iommu: Use right way to retrieve iommu_ops
  iommu: Add iommu_domain::domain_ops

 include/linux/intel-iommu.h                   |  27 -
 include/linux/intel-svm.h                     |  12 -
 include/linux/iommu.h                         | 174 ++----
 drivers/iommu/intel/pasid.h                   |   4 -
 include/uapi/linux/iommu.h                    | 181 ------
 .../drm/nouveau/nvkm/engine/device/tegra.c    |   2 +-
 drivers/iommu/amd/iommu.c                     |  21 +-
 drivers/iommu/apple-dart.c                    |  24 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  22 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  23 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  17 +-
 drivers/iommu/exynos-iommu.c                  |  17 +-
 drivers/iommu/fsl_pamu_domain.c               |  13 +-
 drivers/iommu/intel/debugfs.c                 |   3 +-
 drivers/iommu/intel/iommu.c                   | 542 +-----------------
 drivers/iommu/intel/pasid.c                   | 161 ------
 drivers/iommu/intel/svm.c                     | 209 -------
 drivers/iommu/iommu.c                         | 296 +---------
 drivers/iommu/ipmmu-vmsa.c                    |  21 +-
 drivers/iommu/msm_iommu.c                     |  17 +-
 drivers/iommu/mtk_iommu.c                     |  24 +-
 drivers/iommu/mtk_iommu_v1.c                  |  19 +-
 drivers/iommu/omap-iommu.c                    |  15 +-
 drivers/iommu/rockchip-iommu.c                |  17 +-
 drivers/iommu/s390-iommu.c                    |  15 +-
 drivers/iommu/sprd-iommu.c                    |  19 +-
 drivers/iommu/sun50i-iommu.c                  |  18 +-
 drivers/iommu/tegra-gart.c                    |  15 +-
 drivers/iommu/tegra-smmu.c                    |  16 +-
 drivers/iommu/virtio-iommu.c                  |  18 +-
 30 files changed, 331 insertions(+), 1631 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
