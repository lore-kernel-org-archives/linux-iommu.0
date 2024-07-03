Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811DC17DA08
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003088; cv=none; b=In1nEus6y7lds4AhVTnLrO327dmm9egJzjavtfGtc0dprxQ4wPAfw76ChYs12U6BTrFbKxuE3j74ZGPwu9s4hhuZnQRfgk591D40mOiTI+Psw+AbaPgiXVs8bUDvQ6/nGsDRd0uYKel5zd1kLeh9bqlZi0n/6QQfqKu9ctSSuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003088; c=relaxed/simple;
	bh=970z0TpVCxBfV6TI6v1qRbV/BtE6ynX76EWEmh4dgxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MyxzaARSBJA0k3cU+TRzE2e+ev2EpZ/0/8vAQnDccY7dzbnNwXmAxN7p2+ZAYzMEDtKNqYERf5rdqr+0SxppXPdatO9WCUx/DPPolCVekVGpp2zweb4rbKTkzd/k9F0catAsS8ZzOgCeYdS0EAWZiP6RUPYE8zzwoBmsuC7CvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WDbKF2dkkz6K99Z;
	Wed,  3 Jul 2024 18:16:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E37A3140B2F;
	Wed,  3 Jul 2024 18:18:09 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 11:18:00 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<ryan.roberts@arm.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<mshavit@google.com>, <eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v7 0/5] Add IOMMUFD dirty tracking support for SMMUv3
Date: Wed, 3 Jul 2024 11:15:59 +0100
Message-ID: <20240703101604.2576-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


Hi,

v6 --> v7
 -Rebased to kernel/git/will/linux.git for-joerg/smmu/updates branch
 -Dropped patch #1 as already addressed by Jason's series.
 -Picked up R-by tag by Nicolin for patch #2

Thanks,
Shameer

---

This is revisiting the earlier attempts [1, 2] to use SMMUv3 HTTU feature
for dirty page tracking. The Intel/AMD support is already mainline.

Basic sanity tests are done using an emulation setup and on a test
hardware setup. Block page split/merge(BBML) is not part of this
series. I am planning to send it separately.

v5 --> v6
 -Minor updates based on Nicolin's feedback.
 -Picked up R-by tags by Jason, Nicolin and Kevin(Thanks!)

v4 --> v5

 -Dropped arm_smmu_sva_domain_alloc() related changes from this
  series as suggested by Jason.
 -Added R-by tags.

v3 --> v4

 -Re-based on top of 6.10-rc1
 -Added patches (1, 2 & 3) on top of v3 to make this series independent
  of Jason's SMMUv3 refactor series.
 -Addressed comments received on v3 and added tags.

v2 --> v3

 -Rebased on top of the latest of Jason's refactor series git[3].
 -Addressed comments from Ryan and Jason(patch 2 & 3, Thanks!)
 -Added R-by tags  to 1 & 4.

v1 --> v2:
https://lore.kernel.org/linux-iommu/20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com/

Addressed review comments from Jason and Joao(Thanks)
   -Moved dirty_ops setting to domain finalise(patch #3)
   -Only enable DBM for stage 1 if domain_alloc_user() requests it.
   -Changed IO page table walker(patch #2) and tested with 4KB/16KB/64KB
    with l1/l2/l3 traversal.(The earlier one had a bug where it fails to
    walk L3 level).
   -Rearranged patches a bit to improve bi-sectability.
   -Rebased on top of Jason's v5 of SMMUv3 new API series git.

1. https://lore.kernel.org/lkml/20210413085457.25400-1-zhukeqian1@huawei.com/
2. https://lore.kernel.org/linux-iommu/20230518204650.14541-1-joao.m.martins@oracle.com/
3. https://github.com/jgunthorpe/linux/commits/smmuv3_newapi

Jean-Philippe Brucker (1):
  iommu/arm-smmu-v3: Add feature detection for HTTU

Joao Martins (1):
  iommu/arm-smmu-v3: Add support for dirty tracking in domain alloc

Kunkun Jiang (1):
  iommu/arm-smmu-v3: Enable HTTU for stage1 with io-pgtable mapping

Shameer Kolothum (2):
  iommu/arm-smmu-v3: Add support for domain_alloc_user fn
  iommu/io-pgtable-arm: Add read_and_clear_dirty() support

 drivers/iommu/Kconfig                       |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 160 +++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   8 +
 drivers/iommu/io-pgtable-arm.c              | 119 ++++++++++++++-
 drivers/iommu/iommufd/hw_pagetable.c        |   3 +
 include/linux/io-pgtable.h                  |   3 +
 6 files changed, 268 insertions(+), 26 deletions(-)

-- 
2.34.1

