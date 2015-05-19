From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v7 06/25] iommu/exynos: Remove useless members from
 exynos_iommu_owner structure
Date: Tue, 19 May 2015 15:20:26 +0200
Message-ID: <1432041645-11172-7-git-send-email-m.szyprowski@samsung.com>
References: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1432041645-11172-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, David Wodhouse <dwmw2@infradead.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch removes useless spinlocks and other unused members from
struct exynos_iommu_owner. There is no point is protecting this
structure by spinlock because content of this structure doesn't change
and other structures have their own spinlocks.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c9806868c14f..4f6090361af1 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -189,9 +189,6 @@ struct exynos_iommu_owner {
 	struct list_head client; /* entry of exynos_iommu_domain.clients */
 	struct device *dev;
 	struct device *sysmmu;
-	struct iommu_domain *domain;
-	void *vmm_data;         /* IO virtual memory manager's data */
-	spinlock_t lock;        /* Lock to preserve consistency of System MMU */
 };
 
 struct exynos_iommu_domain {
@@ -477,44 +474,34 @@ static int __exynos_sysmmu_enable(struct device *dev, phys_addr_t pgtable,
 				  struct iommu_domain *domain)
 {
 	int ret = 0;
-	unsigned long flags;
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct sysmmu_drvdata *data;
 
 	BUG_ON(!has_sysmmu(dev));
 
-	spin_lock_irqsave(&owner->lock, flags);
-
 	data = dev_get_drvdata(owner->sysmmu);
 
 	ret = __sysmmu_enable(data, pgtable, domain);
 	if (ret >= 0)
 		data->master = dev;
 
-	spin_unlock_irqrestore(&owner->lock, flags);
-
 	return ret;
 }
 
 static bool exynos_sysmmu_disable(struct device *dev)
 {
-	unsigned long flags;
 	bool disabled = true;
 	struct exynos_iommu_owner *owner = dev->archdata.iommu;
 	struct sysmmu_drvdata *data;
 
 	BUG_ON(!has_sysmmu(dev));
 
-	spin_lock_irqsave(&owner->lock, flags);
-
 	data = dev_get_drvdata(owner->sysmmu);
 
 	disabled = __sysmmu_disable(data);
 	if (disabled)
 		data->master = NULL;
 
-	spin_unlock_irqrestore(&owner->lock, flags);
-
 	return disabled;
 }
 
@@ -762,10 +749,8 @@ static int exynos_iommu_attach_device(struct iommu_domain *domain,
 	spin_lock_irqsave(&priv->lock, flags);
 
 	ret = __exynos_sysmmu_enable(dev, pagetable, domain);
-	if (ret == 0) {
+	if (ret == 0)
 		list_add_tail(&owner->client, &priv->clients);
-		owner->domain = domain;
-	}
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
@@ -793,10 +778,8 @@ static void exynos_iommu_detach_device(struct iommu_domain *domain,
 
 	list_for_each_entry(owner, &priv->clients, client) {
 		if (owner == dev->archdata.iommu) {
-			if (exynos_sysmmu_disable(dev)) {
+			if (exynos_sysmmu_disable(dev))
 				list_del_init(&owner->client);
-				owner->domain = NULL;
-			}
 			break;
 		}
 	}
-- 
1.9.2
