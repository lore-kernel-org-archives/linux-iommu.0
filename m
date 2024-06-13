Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456DE399
	for <iommu@lists.linux.dev>; Thu, 13 Jun 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289751; cv=none; b=FkQ2KyBnCUODALA5zfDwmdF4qeeff5f5IsRLIMvCeowZvIkBktLBbkV/yZiUcdquy783Q64GCNWwaM+VGhln4E+pSh54wTNjXYB4/OoKO+bEQ55GQUWBDkoRh5QMnvnJxG8fVj1rXDCyKIwjYWnj5mLLvkC9qdkrByEmGc/f89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289751; c=relaxed/simple;
	bh=Um62Rh9ml9tFr4S1urz2QqvOBDwmRiFmEKXH2Qhf6/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvzFJAL2x/0tpPksgkrBPGiSWuzv2xW16pUHZxCq8TMR193nmGOfS9ElnabOCu5Jr5A7nlslpk4j5q7TH3DDUKkaaoarnjk04gXFCFR8DzWqnzMiSoVjHFPI2+gswlNN5EeAYhC7DT3PDknFhnEC9QvCZlhnk/OfeMHlcLvqYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0Q7y23bzz6H7Fy;
	Thu, 13 Jun 2024 22:41:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 26127140A70;
	Thu, 13 Jun 2024 22:42:25 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 15:42:16 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <mark.rutland@arm.com>,
	<kevin.tian@intel.com>, <nicolinc@nvidia.com>, <mshavit@google.com>,
	<eric.auger@redhat.com>, <joao.m.martins@oracle.com>,
	<jiangkunkun@huawei.com>, <zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v6 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Date: Thu, 13 Jun 2024 15:41:43 +0100
Message-ID: <20240613144149.38672-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Hi,

v5 --> v6
 -Minor updates based on Nicolin's feedback.
 -Picked up R-by tags by Jason, Nicolin and Kevin(Thanks!)

Hi Will,

Not sure you got a chance to take a look at this series yet. Hopefully
this will make it for 6.11.

Please let me know.

Thanks,
Shameer

---
This is revisiting the earlier attempts [1, 2] to use SMMUv3 HTTU feature
for dirty page tracking. The Intel/AMD support is already mainline.

Basic sanity tests are done using an emulation setup and on a test
hardware setup. Block page split/merge(BBML) is not part of this
series. I am planning to send it separately.

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

Shameer Kolothum (3):
  iommu/arm-smmu-v3: Factor out a common domain alloc
  iommu/arm-smmu-v3: Add support for domain_alloc_user fn
  iommu/io-pgtable-arm: Add read_and_clear_dirty() support

 drivers/iommu/Kconfig                       |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 190 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   8 +
 drivers/iommu/io-pgtable-arm.c              | 119 +++++++++++-
 drivers/iommu/iommufd/hw_pagetable.c        |   3 +
 include/linux/io-pgtable.h                  |   3 +
 6 files changed, 289 insertions(+), 35 deletions(-)

-- 
2.34.1

