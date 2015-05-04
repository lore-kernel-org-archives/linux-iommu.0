From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v6 14/25] iommu: exynos: use struct exynos_iommu_domain in
 internal structures
Date: Mon, 04 May 2015 10:16:09 +0200
Message-ID: <1430727380-10912-15-git-send-email-m.szyprowski@samsung.com>
References: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1430727380-10912-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: iommu@lists.linux-foundation.org

Replace all remaining usage of struct iommu_domain with struct
exynos_iommu_domain in all internal structures and functions.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a58f4a4c91d0..67e0633b8080 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -206,7 +206,7 @@ struct sysmmu_drvdata {
 	struct clk *clk_master;
 	int activations;
 	spinlock_t lock;
-	struct iommu_domain *domain;
+	struct exynos_iommu_domain *domain;
 	struct list_head domain_node;
 	struct list_head owner_node;
 	phys_addr_t pgtable;
@@ -338,7 +338,7 @@ static irqreturn_t exynos_sysmmu_irq(int irq, void *dev_id)
 		show_fault_information(dev_name(data->sysmmu),
 					itype, base, addr);
 		if (data->domain)
-			ret = report_iommu_fault(data->domain,
+			ret = report_iommu_fault(&data->domain->domain,
 					data->master, addr, itype);
 	}
 
@@ -437,7 +437,7 @@ static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
 }
 
 static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
-			   struct iommu_domain *iommu_domain)
+			   struct exynos_iommu_domain *domain)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -445,7 +445,7 @@ static int __sysmmu_enable(struct sysmmu_drvdata *data, phys_addr_t pgtable,
 	spin_lock_irqsave(&data->lock, flags);
 	if (set_sysmmu_active(data)) {
 		data->pgtable = pgtable;
-		data->domain = iommu_domain;
+		data->domain = domain;
 
 		__sysmmu_enable_nocount(data);
 
@@ -703,7 +703,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 
 	list_for_each_entry(data, &owner->clients, owner_node) {
 		pm_runtime_get_sync(data->sysmmu);
-		ret = __sysmmu_enable(data, pagetable, iommu_domain);
+		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
 
-- 
1.9.2
