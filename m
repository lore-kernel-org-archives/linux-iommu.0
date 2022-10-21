Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6EA7B
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 03:53:02 +0000 (UTC)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mtr5z6QqKz1P74j;
	Fri, 21 Oct 2022 11:48:07 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 11:52:51 +0800
Received: from huawei.com (10.67.164.66) by kwepemm600005.china.huawei.com
 (7.193.23.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 21 Oct
 2022 11:52:51 +0800
From: Longfang Liu <liulongfang@huawei.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<liulongfang@huawei.com>
Subject: [PATCH 1/2] iommu: fix memory leak of iopf
Date: Fri, 21 Oct 2022 11:51:46 +0800
Message-ID: <20221021035147.15292-2-liulongfang@huawei.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20221021035147.15292-1-liulongfang@huawei.com>
References: <20221021035147.15292-1-liulongfang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected

In arm_smmu_init_queues(), if ARM_SMMU_FEAT_SVA and ARM_SMMU_FEAT_STALLS
are enabled, iopf will be allocated a queue memory, and after
arm_smmu_init_one_queue() processing fails, this part of iopf
memory is not released, and there is a memory leak problem.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b788a38d8fdf..a1db07bed6a9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2939,9 +2939,13 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
 		return 0;
 
-	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, smmu->page1,
+	ret = arm_smmu_init_one_queue(smmu, &smmu->priq.q, smmu->page1,
 				       ARM_SMMU_PRIQ_PROD, ARM_SMMU_PRIQ_CONS,
 				       PRIQ_ENT_DWORDS, "priq");
+	if (ret)
+		iopf_queue_free(smmu->evtq.iopf);
+
+	return ret;
 }
 
 static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
-- 
2.24.0

