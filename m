From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 13/25] iommu/exynos: Add support for binding more than one
 sysmmu to master device
Date: Tue, 19 May 2015 15:20:33 +0200
Message-ID: <1432041645-11172-14-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds support for assigning more than one SYSMMU controller to
the master device. This has been achieved simply by chaning the struct
device pointer in struct exynos_iommu_owner into the list of struct
sysmmu_drvdata of all controllers assigned to the given master device.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index a5f0c99602c2..946f95ae46bc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -187,7 +187,7 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
  * pointer.
 */
 struct exynos_iommu_owner {
-	struct device *sysmmu;		/* sysmmu controller for given master */
+	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
 };
 
 /*
@@ -221,6 +221,7 @@ struct sysmmu_drvdata {
 	spinlock_t lock;		/* lock for modyfying state */
 	struct exynos_iommu_domain *domain; /* domain we belong to */
 	struct list_head domain_node;	/* node for domain clients list */
+	struct list_head owner_node;	/* node for owner controllers list */
 	phys_addr_t pgtable;		/* assigned page table structure */
 	unsigned int version;		/* our version */
 };
@@ -713,8 +714,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *iommu_domain,
 	if (!has_sysmmu(dev))
 		return -ENODEV;
 
-	data = dev_get_drvdata(owner->sysmmu);
-	if (data) {
+	list_for_each_entry(data, &owner->controllers, owner_node) {
 		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
@@ -742,7 +742,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 {
 	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
 	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
-	struct sysmmu_drvdata *data;
+	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
 	bool found = false;
 
@@ -750,14 +750,13 @@ static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
 		return;
 
 	spin_lock_irqsave(&domain->lock, flags);
-	list_for_each_entry(data, &domain->clients, domain_node) {
+	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
 		if (data->master == dev) {
 			if (__sysmmu_disable(data)) {
 				data->master = NULL;
 				list_del_init(&data->domain_node);
 			}
 			found = true;
-			break;
 		}
 	}
 	spin_unlock_irqrestore(&domain->lock, flags);
-- 
1.9.2
