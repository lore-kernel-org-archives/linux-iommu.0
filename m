From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 16/16] iommu: Remove domain_init and domain_free iommu_ops
Date: Thu, 26 Mar 2015 13:43:19 +0100
Message-ID: <1427373799-18662-17-git-send-email-joro@8bytes.org>
References: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427373799-18662-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Will Deacon <will.deacon@arm.com>, Kukjin Kim <kgene@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>, Hiroshi Doyu <hdoyu@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

All drivers have been converted to the new domain_alloc and
domain_free iommu-ops. So remove the old ones and get rid of
iommu_domain->priv too, as this is no longer needed when the
struct iommu_domain is embedded in the private structures of
the iommu drivers.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 30 ++----------------------------
 include/linux/iommu.h |  3 ---
 2 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 656b949..d4f527e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -900,51 +900,25 @@ EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
 struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
 {
-	const struct iommu_ops *ops;
 	struct iommu_domain *domain;
 
 	if (bus == NULL || bus->iommu_ops == NULL)
 		return NULL;
 
-	ops = bus->iommu_ops;
-
-	if (ops->domain_alloc)
-		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
-	else
-		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-
+	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
 	if (!domain)
 		return NULL;
 
 	domain->ops  = bus->iommu_ops;
 	domain->type = IOMMU_DOMAIN_UNMANAGED;
 
-	if (ops->domain_init && domain->ops->domain_init(domain))
-		goto out_free;
-
 	return domain;
-
-out_free:
-	if (ops->domain_free)
-		ops->domain_free(domain);
-	else
-		kfree(domain);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
-	const struct iommu_ops *ops = domain->ops;
-
-	if (likely(ops->domain_destroy != NULL))
-		ops->domain_destroy(domain);
-
-	if (ops->domain_free)
-		ops->domain_free(domain);
-	else
-		kfree(domain);
+	domain->ops->domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 72d03fe..0546b87 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -78,7 +78,6 @@ struct iommu_domain_geometry {
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_ops *ops;
-	void *priv;
 	iommu_fault_handler_t handler;
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
@@ -138,8 +137,6 @@ enum iommu_attr {
  */
 struct iommu_ops {
 	bool (*capable)(enum iommu_cap);
-	int (*domain_init)(struct iommu_domain *domain);
-	void (*domain_destroy)(struct iommu_domain *domain);
 
 	/* Domain allocation and freeing by the iommu driver */
 	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
-- 
1.9.1
