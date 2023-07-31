Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88BB81B
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 06:46:11 +0000 (UTC)
Received: from dggpemm500003.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RDp9w0QbxzNmbs;
	Mon, 31 Jul 2023 14:24:36 +0800 (CST)
Received: from localhost.localdomain (10.28.77.120) by
 dggpemm500003.china.huawei.com (7.185.36.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 14:28:00 +0800
From: wangwudi <wangwudi@hisilicon.com>
To: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Rui Zhu <zhurui3@huawei.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, Yicong Yang
	<yangyicong@hisilicon.com>, Tomas Krcka <krckatom@amazon.de>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 1/1] Revert "iommu/arm-smmu-v3: Set TTL invalidation hint better"
Date: Mon, 31 Jul 2023 14:21:22 +0800
Message-ID: <1690784482-30028-1-git-send-email-wangwudi@hisilicon.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.28.77.120]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500003.china.huawei.com (7.185.36.56)
X-CFilter-Loop: Reflected

From: Rui Zhu <zhurui3@huawei.com>

This reverts commit 6833b8f2e19945a41e4d5efd8c6d9f4cae9a5b7d.

This constraint violates the protocol. When tg is not 0 but ttl, scale,
and num are 0, the hardware reports the CERROR_IL gerror. In the
protocol, leaf is not a prerequisite for TTL.

Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Cc: Tomas Krcka <krckatom@amazon.de>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>
Cc: Rui Zhu <zhurui3@huawei.com>

Signed-off-by: Rui Zhu <zhurui3@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9b0dc3505601..098e84cfa82f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1898,13 +1898,8 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		/* Convert page size of 12,14,16 (log2) to 1,2,3 */
 		cmd->tlbi.tg = (tg - 10) / 2;
 
-		/*
-		 * Determine what level the granule is at. For non-leaf, io-pgtable
-		 * assumes .tlb_flush_walk can invalidate multiple levels at once,
-		 * so ignore the nominal last-level granule and leave TTL=0.
-		 */
-		if (cmd->tlbi.leaf)
-			cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
+		/* Determine what level the granule is at */
+		cmd->tlbi.ttl = 4 - ((ilog2(granule) - 3) / (tg - 3));
 
 		num_pages = size >> tg;
 	}
-- 
1.8.3.1

