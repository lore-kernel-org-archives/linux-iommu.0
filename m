Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0D1F171
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484698; cv=none; b=WITyr+4TVUvMUDpoN9iOz1VJBcFhb4ySWdlwH3IitTuCMyGMfBBk0prijTbyeyw5DRC04L09qAHGnvtCWMebk6Nj9JRgqhgUah0dcOC84f2a3u0Mt1XRSVV5XIe0GQDujDbnRE+KMHCpFFmTSWIG9XnQJiwMuJhX0QKIrqW0xYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484698; c=relaxed/simple;
	bh=0rwriOyTibpxPBrTFMRsdUFy71bmP/Hor09fQg0mD1Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VN/BXH9MO6glrjiOOCX0uQjyn6WtPdHZdw+m/MqVZ8yDA2O3HNS4fgEYQg8ro7i6LfHmpVK2yzhydtUuDZoQSBq/jBb0QT4+9bVu0k1Td12suSmwimodM/n1mWxVTqnb/wcsg7Rz+3i3w6qW/cZSpzvOS6HzDOR/chrPMeZfN38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTLwP0lN6z6J7JY;
	Tue, 30 Apr 2024 21:42:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CD759140A08;
	Tue, 30 Apr 2024 21:44:53 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.126.175.159) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 14:44:43 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <eric.auger@redhat.com>,
	<joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v3 0/4] iommu/smmuv3: Add IOMMUFD dirty tracking support for SMMUv3 
Date: Tue, 30 Apr 2024 14:43:04 +0100
Message-ID: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
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

Hi

v2 --> v3

 -Rebased on top of the latest of Jason's refactor series git[3].
 -Addressed comments from Ryan and Jason(patch 2 & 3, Thanks!)
 -Added R-by tags  to 1 & 4.

Please take a look and let me know your feedback.
Thanks,
Shameer

---
This is revisiting the earlier attempts [1, 2] to use SMMUv3 HTTU feature
for dirty page tracking. The Intel/AMD support is already mainline.

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

 drivers/iommu/Kconfig                       |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 129 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   8 ++
 drivers/iommu/io-pgtable-arm.c              | 110 ++++++++++++++++-
 include/linux/io-pgtable.h                  |   4 +
 5 files changed, 226 insertions(+), 26 deletions(-)

-- 
2.34.1

