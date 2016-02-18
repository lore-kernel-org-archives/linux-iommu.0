From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 13/13] iommu: exynos: support multiple attach_device calls
Date: Thu, 18 Feb 2016 15:13:00 +0100
Message-ID: <1455804780-9616-14-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

IOMMU core calls attach_device callback without detaching device from
the previous domain. This patch adds support for such unballanced calls.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 72 ++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 9c8ce951158d..b0665042bf29 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -201,6 +201,7 @@ static const struct sysmmu_fault_info sysmmu_v5_faults[] = {
 */
 struct exynos_iommu_owner {
 	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
+	struct iommu_domain *domain;	/* domain this device is attached */
 };
 
 /*
@@ -825,6 +826,41 @@ static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
 	kfree(domain);
 }
 
+static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
+				    struct device *dev)
+{
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
+	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
+	struct sysmmu_drvdata *data, *next;
+	unsigned long flags;
+	bool found = false;
+
+	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
+		return;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
+		if (data->master == dev) {
+			if (__sysmmu_disable(data)) {
+				data->master = NULL;
+				list_del_init(&data->domain_node);
+			}
+			pm_runtime_put(data->sysmmu);
+			found = true;
+		}
+	}
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	owner->domain = NULL;
+
+	if (found)
+		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
+					__func__, &pagetable);
+	else
+		dev_err(dev, "%s: No IOMMU is attached\n", __func__);
+}
+
 static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 				   struct device *dev)
 {
@@ -838,6 +874,9 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	if (!has_sysmmu(dev))
 		return -ENODEV;
 
+	if (owner->domain)
+		exynos_iommu_detach_device(owner->domain, dev);
+
 	list_for_each_entry(data, &owner->controllers, owner_node) {
 		pm_runtime_get_sync(data->sysmmu);
 		ret = __sysmmu_enable(data, pagetable, domain);
@@ -856,44 +895,13 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 		return ret;
 	}
 
+	owner->domain = iommu_domain;
 	dev_dbg(dev, "%s: Attached IOMMU with pgtable %pa %s\n",
 		__func__, &pagetable, (ret == 0) ? "" : ", again");
 
 	return ret;
 }
 
-static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
-				    struct device *dev)
-{
-	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
-	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
-	struct sysmmu_drvdata *data, *next;
-	unsigned long flags;
-	bool found = false;
-
-	if (!has_sysmmu(dev))
-		return;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
-		if (data->master == dev) {
-			if (__sysmmu_disable(data)) {
-				data->master = NULL;
-				list_del_init(&data->domain_node);
-			}
-			pm_runtime_put(data->sysmmu);
-			found = true;
-		}
-	}
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	if (found)
-		dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n",
-					__func__, &pagetable);
-	else
-		dev_err(dev, "%s: No IOMMU is attached\n", __func__);
-}
-
 static sysmmu_pte_t *alloc_lv2entry(struct exynos_iommu_domain *domain,
 		sysmmu_pte_t *sent, sysmmu_iova_t iova, short *pgcounter)
 {
-- 
1.9.2
