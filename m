From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 22/29] iommu: exynos: add support for binding more than one
 sysmmu to master device
Date: Tue, 05 Aug 2014 12:47:50 +0200
Message-ID: <1407235677-26324-23-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
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
index 674d1fb..46e0edc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -187,7 +187,7 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 
 /* attached to dev.archdata.iommu of the master device */
 struct exynos_iommu_owner {
-	struct device *sysmmu;
+	struct list_head clients;
 };
 
 struct exynos_iommu_domain {
@@ -208,6 +208,7 @@ struct sysmmu_drvdata {
 	spinlock_t lock;
 	struct iommu_domain *domain;
 	struct list_head domain_node;
+	struct list_head owner_node;
 	phys_addr_t pgtable;
 	int version;
 };
@@ -695,8 +696,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	if (!has_sysmmu(dev))
 		return -ENODEV;
 
-	data = dev_get_drvdata(owner->sysmmu);
-	if (data) {
+	list_for_each_entry(data, &owner->clients, owner_node) {
 		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
@@ -724,7 +724,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 {
 	struct exynos_iommu_domain *priv = domain->priv;
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
-	struct sysmmu_drvdata *data;
+	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
 	int found = 0;
 
@@ -732,14 +732,13 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 		return;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	list_for_each_entry(data, &priv->clients, domain_node) {
+	list_for_each_entry_safe(data, next, &priv->clients, domain_node) {
 		if (data->master == dev) {
 			if (__sysmmu_disable(data)) {
 				data->master = NULL;
 				list_del_init(&data->domain_node);
 			}
 			found = true;
-			break;
 		}
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
-- 
1.9.2
