Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3E37715
	for <iommu@lists.linux.dev>; Thu, 22 Feb 2024 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595438; cv=none; b=OEsHDa7wSoWrw18M38LAas0U+eB6Q+q/q330iLkWquyW0c183Asonb2F1hbsskUNFPu+M86J09OoesZ03XmHsyLkjKiTgDVJOJr6T2I5O6IDRrWGhWsc0xENjXgaz55Tz+QApcimAMHEUSpvb7t40AK16xKP6Ib45biyZXMxCR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595438; c=relaxed/simple;
	bh=7YnMhsYIDtre6870juBTBJpvg8DNkBogMFTY2KA/4Bo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JzSLufoo4qt+BPdyVGV/CEGwyayToD4lL0BriCdrrmIwld/Ehv5wVDKjs5jSMnZGBzpK4wD17wTmaohIbaEX6LJ53bRwrA0UB8njytv1EKWkbl1AWXyxNWFS5eKSn0Hn3B3PIkexzQdcccfrUl8JqYVOCzQ9EiGf+uHOV8bMr1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TgSwC3GQCz6H8D1;
	Thu, 22 Feb 2024 17:46:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C742D140119;
	Thu, 22 Feb 2024 17:50:28 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:50:22 +0000
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v2 0/4] iommu/smmuv3: Add IOMMUFD dirty tracking support for SMMUv3
Date: Thu, 22 Feb 2024 09:49:19 +0000
Message-ID: <20240222094923.33104-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Hi,

This is revisiting the earlier attempts [1, 2] to use SMMUv3 HTTU feature
for dirty page tracking. The Intel/AMD support is already mainline.

The code is now based on the new IOMMUFD APIs and is rebased on
Jason's SMMUv3 driver refactor series[3].

Basic sanity tests are done using an emulation setup and on a test
hardware setup. Block page split/merge(BBML) is not part of this
series. I am planning to send it separately.

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

Please take a look and let me know your feedback.
Thanks,
Shameer

1. https://lore.kernel.org/lkml/20210413085457.25400-1-zhukeqian1@huawei.com/
2. https://lore.kernel.org/linux-iommu/20230518204650.14541-1-joao.m.martins@oracle.com/
3. https://github.com/jgunthorpe/linux/commits/smmuv3_newapi

Jean-Philippe Brucker (1):
  iommu/arm-smmu-v3: Add feature detection for HTTU

Joao Martins (1):
  iommu/arm-smmu-v3: Add support for dirty tracking in domain alloc

Kunkun Jiang (1):
  iommu/arm-smmu-v3: Enable HTTU for stage1 with io-pgtable mapping

Shameer Kolothum (1):
  iommu/io-pgtable-arm: Add read_and_clear_dirty() support

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 142 +++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   8 ++
 drivers/iommu/io-pgtable-arm.c              | 133 +++++++++++++++++-
 include/linux/io-pgtable.h                  |   4 +
 4 files changed, 263 insertions(+), 24 deletions(-)

-- 
2.34.1

