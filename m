From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer register
Date: Mon, 23 Jul 2018 20:56:58 +0800
Message-ID: <1532350618-16486-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: Miao Zhong <zhongmiao@hisilicon.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

From: Miao Zhong <zhongmiao@hisilicon.com>

When PRI queue occurs overflow, driver should update the OVACKFLG to
the PRIQ consumer register, otherwise subsequent PRI requests will not
be processed.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com> 
Signed-off-by: Miao Zhong <zhongmiao@hisilicon.com>
---
 drivers/iommu/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 1d64710..deacc15 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1301,6 +1301,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	q->cons = Q_OVF(q, q->prod) | Q_WRP(q, q->cons) | Q_IDX(q, q->cons);
+	writel(q->cons, q->cons_reg);
 	return IRQ_HANDLED;
 }
 
-- 
2.7.4
