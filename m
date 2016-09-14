From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] iommu/exynos: Improve page fault debug message
Date: Wed, 14 Sep 2016 14:44:43 +0200
Message-ID: <1473857083-1078-1-git-send-email-m.szyprowski@samsung.com>
References: <CGME20160914124448eucas1p2b5d1cac9d4af5dc594c012007b21c3c4@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Add master device name to default IOMMU fault message to make easier to
find which device triggered the fault. While at it, move printing some
information (like page table base and first level entry addresses) to
dev_dbg(), because those are typically not very useful for typical device
driver user/developer not equipped with hardware debugging tools.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 30808e9..47f0d67 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -368,13 +368,14 @@ static void show_fault_information(struct sysmmu_drvdata *data,
 {
 	sysmmu_pte_t *ent;
 
-	dev_err(data->sysmmu, "%s FAULT occurred at %#x (page table base: %pa)\n",
-		finfo->name, fault_addr, &data->pgtable);
+	dev_err(data->sysmmu, "%s: %s FAULT occurred at %#x\n",
+		dev_name(data->master), finfo->name, fault_addr);
+	dev_dbg(data->sysmmu, "Page table base: %pa\n", &data->pgtable);
 	ent = section_entry(phys_to_virt(data->pgtable), fault_addr);
-	dev_err(data->sysmmu, "\tLv1 entry: %#x\n", *ent);
+	dev_dbg(data->sysmmu, "\tLv1 entry: %#x\n", *ent);
 	if (lv1ent_page(ent)) {
 		ent = page_entry(ent, fault_addr);
-		dev_err(data->sysmmu, "\t Lv2 entry: %#x\n", *ent);
+		dev_dbg(data->sysmmu, "\t Lv2 entry: %#x\n", *ent);
 	}
 }
 
-- 
1.9.1
