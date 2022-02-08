Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDEFC433F5
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 01:27:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F32554043A;
	Tue,  8 Feb 2022 01:27:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Oqy3a81j6JZ; Tue,  8 Feb 2022 01:27:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DC25C4035C;
	Tue,  8 Feb 2022 01:27:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B96BBC001A;
	Tue,  8 Feb 2022 01:27:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02EB7C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:27:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DF962403ED
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:27:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d1MFRIwmFc8o for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 01:27:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5CFA4035C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644283646; x=1675819646;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Pctv2HrISmh5p/g3/+6/TjHP74MB5JcG7fy+BWZgOv8=;
 b=YMoXLBkPBT0rQ29/vABtbWxwRRzjvCdMg9BblD7Jw/wL5k6CGm2a91I0
 T+Uvo1h6ptrG7i5+SLWVq2ammrzIid1al4D5eG4ZtVzCtA/c7EdLAKMKA
 rFKODvedXmXshkM+iky4x4aKv8fA87nQ9r7SXJWp+zizZmm19nMgdrsIa
 WQFXnyUb5dnHK06Bm4i6eEsJ2jf1+F7HOKXbu6IT+4ATgtXoIdnuyJa6S
 Lf4PcAPLj/qhnKmp+mUfA9xFK03MlkyK7KG+XcizbBFnEryaWHGotZ6xE
 izyqKKfQVrjeti4Vs3+OP+dLaN8MNbzhIrD6F2+iaRhLlmvlyD5rg9Jvx w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="228816214"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="228816214"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 17:27:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="677948771"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 17:27:21 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Ben Skeggs <bskeggs@redhat.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 00/10] iommu cleanup and refactoring
Date: Tue,  8 Feb 2022 09:25:49 +0800
Message-Id: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
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
domain specific ops from iommu_ops to a new iommu_domain_ops. This makes
iommu_domain self-contained and represent the abstraction of an I/O
translation table in the IOMMU subsystem. With different type of
iommu_domain providing different set of ops, it's easier to support more
types of I/O translation tables.

Please help to review and comment.

Best regards,
baolu

Change log:
v1: https://lore.kernel.org/linux-iommu/20220124071103.2097118-1-baolu.lu@linux.intel.com/

v2:
 - Remove apply_resv_region callback.
 - Remove domain argument from is_attach_deferred callback.
 - Convert all feasible instances of dev->bus->iommu_ops to dev_iommu_ops().
 - Add the default_domain_ops (default iommu_domain_ops) in iommu_ops to
   avoid big churn in dozens of iommu drivers.
 - We discussed removing pgsize_bitmap in struct iommu_ops and
   initialize the domain field in domain_alloc(). Considering that
   domain_alloc() is being refactored, let's wait until the new domain_alloc()
   comes.
 - Various code/description refinement.
 - This version of series is available on github:
   https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-ops-v2

Lu Baolu (10):
  iommu/vt-d: Remove guest pasid related callbacks
  iommu: Remove guest pasid related interfaces and definitions
  iommu/vt-d: Remove aux-domain related callbacks
  iommu: Remove aux-domain related interfaces and iommu_ops
  iommu: Remove apply_resv_region
  drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
  iommu: Use right way to retrieve iommu_ops
  iommu: Remove unused argument in is_attach_deferred
  iommu: Use dev_iommu_ops() helper
  iommu: Split struct iommu_ops

 include/linux/intel-iommu.h                   |  27 -
 include/linux/intel-svm.h                     |  12 -
 include/linux/iommu.h                         | 184 +++---
 drivers/iommu/amd/amd_iommu.h                 |   3 +-
 drivers/iommu/intel/pasid.h                   |   4 -
 include/uapi/linux/iommu.h                    | 181 ------
 .../drm/nouveau/nvkm/engine/device/tegra.c    |   2 +-
 drivers/iommu/amd/iommu.c                     |  23 +-
 drivers/iommu/amd/iommu_v2.c                  |   2 +-
 drivers/iommu/apple-dart.c                    |  20 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  18 +-
 drivers/iommu/arm/arm-smmu/arm-smmu.c         |  20 +-
 drivers/iommu/arm/arm-smmu/qcom_iommu.c       |  18 +-
 drivers/iommu/exynos-iommu.c                  |  14 +-
 drivers/iommu/fsl_pamu_domain.c               |  10 +-
 drivers/iommu/intel/debugfs.c                 |   3 +-
 drivers/iommu/intel/iommu.c                   | 540 +-----------------
 drivers/iommu/intel/pasid.c                   | 161 ------
 drivers/iommu/intel/svm.c                     | 209 -------
 drivers/iommu/iommu.c                         | 326 ++---------
 drivers/iommu/ipmmu-vmsa.c                    |  18 +-
 drivers/iommu/msm_iommu.c                     |  30 +-
 drivers/iommu/mtk_iommu.c                     |  20 +-
 drivers/iommu/mtk_iommu_v1.c                  |  14 +-
 drivers/iommu/omap-iommu.c                    |  14 +-
 drivers/iommu/rockchip-iommu.c                |  14 +-
 drivers/iommu/s390-iommu.c                    |  14 +-
 drivers/iommu/sprd-iommu.c                    |  18 +-
 drivers/iommu/sun50i-iommu.c                  |  18 +-
 drivers/iommu/tegra-gart.c                    |  18 +-
 drivers/iommu/tegra-smmu.c                    |  14 +-
 drivers/iommu/virtio-iommu.c                  |  14 +-
 32 files changed, 303 insertions(+), 1680 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
