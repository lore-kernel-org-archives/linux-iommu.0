From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Subject: [PATCH v12 04/31] iommu/exynos: fix L2TLB invalidation
Date: Sun, 27 Apr 2014 13:07:36 +0530
Message-ID: <1398584283-22846-5-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: kgene.kim@samsung.com, prathyush.k@samsung.com, grundler@chromium.org, joro@8bytes.org, supash.ramaswamy@linaro.org, tomasz.figa@gmail.com, joshi@samsung.com, sachin.kamat@linaro.org, s.nawrocki@samsung.com, Varun.Sethi@freescale.com, a.motakis@virtualopensystems.com, pullip.cho@samsung.com, t.figa@samsung.com, rahul.sharma@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho@samsung.com>

L2TLB is 8-way set-associative TLB with 512 entries. The number of
sets is 64.
A single 4KB(small page) translation information is cached
only to a set whose index is the same with the lower 6 bits of the page
frame number.
A single 64KB(large page) translation information can be
cached to any 16 sets whose top two bits of their indices are the same
with the bit [5:4] of the page frame number.
A single 1MB(section) or larger translation information can be cached to
any set in the TLB.

It is required to invalidate entire sets that may cache the target
translation information to guarantee that the L2TLB has no stale data.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 drivers/iommu/exynos-iommu.c |   31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 84fc3b4..7ce44a8 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -224,9 +224,14 @@ static void __sysmmu_tlb_invalidate(void __iomem *sfrbase)
 }
 
 static void __sysmmu_tlb_invalidate_entry(void __iomem *sfrbase,
-						unsigned long iova)
+				unsigned long iova, unsigned int num_inv)
 {
-	__raw_writel((iova & SPAGE_MASK) | 1, sfrbase + REG_MMU_FLUSH_ENTRY);
+	unsigned int i;
+	for (i = 0; i < num_inv; i++) {
+		__raw_writel((iova & SPAGE_MASK) | 1,
+				sfrbase + REG_MMU_FLUSH_ENTRY);
+		iova += SPAGE_SIZE;
+	}
 }
 
 static void __sysmmu_set_ptbase(void __iomem *sfrbase,
@@ -476,7 +481,8 @@ static bool exynos_sysmmu_disable(struct device *dev)
 	return disabled;
 }
 
-static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
+static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova,
+					size_t size)
 {
 	unsigned long flags;
 	struct sysmmu_drvdata *data = dev_get_drvdata(dev->archdata.iommu);
@@ -486,9 +492,24 @@ static void sysmmu_tlb_invalidate_entry(struct device *dev, unsigned long iova)
 	if (is_sysmmu_active(data)) {
 		int i;
 		for (i = 0; i < data->nsfrs; i++) {
+			unsigned int maj;
+			unsigned int num_inv = 1;
+			maj = __raw_readl(data->sfrbases[i] + REG_MMU_VERSION);
+			/*
+			 * L2TLB invalidation required
+			 * 4KB page: 1 invalidation
+			 * 64KB page: 16 invalidation
+			 * 1MB page: 64 invalidation
+			 * because it is set-associative TLB
+			 * with 8-way and 64 sets.
+			 * 1MB page can be cached in one of all sets.
+			 * 64KB page can be one of 16 consecutive sets.
+			 */
+			if ((maj >> 28) == 2) /* major version number */
+				num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
 			if (sysmmu_block(data->sfrbases[i])) {
 				__sysmmu_tlb_invalidate_entry(
-						data->sfrbases[i], iova);
+					data->sfrbases[i], iova, num_inv);
 				sysmmu_unblock(data->sfrbases[i]);
 			}
 		}
@@ -998,7 +1019,7 @@ done:
 
 	spin_lock_irqsave(&priv->lock, flags);
 	list_for_each_entry(data, &priv->clients, node)
-		sysmmu_tlb_invalidate_entry(data->dev, iova);
+		sysmmu_tlb_invalidate_entry(data->dev, iova, size);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return size;
-- 
1.7.9.5
