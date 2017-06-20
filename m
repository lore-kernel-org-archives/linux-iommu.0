From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] iommu/arm-smmu-v3: replace writel with writel_relaxed in queue_inc_prod
Date: Tue, 20 Jun 2017 19:04:54 +0800
Message-ID: <1497956694-11784-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

This function is protected by spinlock, and the latter will do memory
barrier implicitly. So that we can safely use writel_relaxed. In fact, the
dmb operation will lengthen the time protected by lock, which indirectly
increase the locking confliction in the stress scene.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969a..d2fbee3 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -728,7 +728,7 @@ static void queue_inc_prod(struct arm_smmu_queue *q)
 	u32 prod = (Q_WRP(q, q->prod) | Q_IDX(q, q->prod)) + 1;

 	q->prod = Q_OVF(q, q->prod) | Q_WRP(q, prod) | Q_IDX(q, prod);
-	writel(q->prod, q->prod_reg);
+	writel_relaxed(q->prod, q->prod_reg);
 }

 /*
--
2.5.0
