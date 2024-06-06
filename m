Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DA12A1C2
	for <iommu@lists.linux.dev>; Thu,  6 Jun 2024 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680829; cv=none; b=N/VP3Apfi8QFAWAZPrU6mg9hc4DMlvli1Fo32e5rStUZW0+htcSX9YhMQ1+chjDPy3TM7i220Iq8Gj4kIoPLxB42YTOeuf/rkxUvNuiMHlWNqJdP2ugmlKEE62V7VeQI6gZKxB0tX94gLmWtiD33yQKE0ZbfVRftv7ibYvn8h+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680829; c=relaxed/simple;
	bh=S+LD17G69XUIMT/RwB596hoEaoivTHzCVjA51E/2idU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XdVXGVO3tWN0dQhBHhYZ+70/f+jzeGzTCJtrgF16wRSsvX9EVYrX83LRisyt6vLxoO3GNRyJmGakrKNP6zqPiGcAkoDpIkOWyn9yUO3z7AzR81YRy6bmX54qXu6H+thjQRTKpV4OBNtMaYMFWaNXXAQ02F9qeFhA3eWRCh7ww64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vw4t84Tr5z67WPF;
	Thu,  6 Jun 2024 21:29:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EC00D1408F9;
	Thu,  6 Jun 2024 21:33:43 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Jun 2024 14:33:35 +0100
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: <robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <ryan.roberts@arm.com>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <mshavit@google.com>, <eric.auger@redhat.com>,
	<joao.m.martins@oracle.com>, <jiangkunkun@huawei.com>,
	<zhukeqian1@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH v5 0/6] Add IOMMUFD dirty tracking support for SMMUv3
Date: Thu, 6 Jun 2024 14:32:56 +0100
Message-ID: <20240606133302.17540-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Hi,

v4 --> v5

 -Dropped arm_smmu_sva_domain_alloc() related changes from this
  series as suggested by Jason.
 -Added R-by tags.

Please take a look and let me know your feedback.

Thanks,
Shameer

---
This is revisiting the earlier attempts [1, 2] to use SMMUv3 HTTU feature
for dirty page tracking. The Intel/AMD support is already mainline.

Basic sanity tests are done using an emulation setup and on a test
hardware setup. Block page split/merge(BBML) is not part of this
series. I am planning to send it separately.

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
 include/linux/io-pgtable.h                  |   4 +
 6 files changed, 290 insertions(+), 35 deletions(-)

-- 
2.34.1

