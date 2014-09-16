From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 12/18] iommu: exynos: add support for binding more than one
 sysmmu to master device
Date: Tue, 16 Sep 2014 13:54:39 +0200
Message-ID: <1410868485-4143-13-git-send-email-m.szyprowski@samsung.com>
References: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1410868485-4143-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
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
index 1b3f00726cd4..cf36cdecf335 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -186,7 +186,7 @@ static char *sysmmu_fault_name[SYSMMU_FAULTS_NUM] = {
 
 /* attached to dev.archdata.iommu of the master device */
 struct exynos_iommu_owner {
-	struct device *sysmmu;
+	struct list_head clients;
 };
 
 struct exynos_iommu_domain {
@@ -207,6 +207,7 @@ struct sysmmu_drvdata {
 	spinlock_t lock;
 	struct iommu_domain *domain;
 	struct list_head domain_node;
+	struct list_head owner_node;
 	phys_addr_t pgtable;
 	int version;
 };
@@ -694,8 +695,7 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	if (!has_sysmmu(dev))
 		return -ENODEV;
 
-	data = dev_get_drvdata(owner->sysmmu);
-	if (data) {
+	list_for_each_entry(data, &owner->clients, owner_node) {
 		ret = __sysmmu_enable(data, pagetable, domain);
 		if (ret >= 0) {
 			data->master = dev;
@@ -723,7 +723,7 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 {
 	struct exynos_iommu_domain *priv = domain->priv;
 	phys_addr_t pagetable = virt_to_phys(priv->pgtable);
-	struct sysmmu_drvdata *data;
+	struct sysmmu_drvdata *data, *next;
 	unsigned long flags;
 	int found = 0;
 
@@ -731,14 +731,13 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
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
