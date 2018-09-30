From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v5 20/21] iommu/tegra: gart: Simplify clients-tracking code
Date: Mon,  1 Oct 2018 01:48:32 +0300
Message-ID: <20180930224833.28809-21-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

GART is a simple IOMMU provider that has single address space. There is
no need to setup global clients list and manage it for tracking of the
active domain, hence lot's of code could be safely removed and replaced
with a simpler alternative.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/tegra-gart.c | 155 ++++++++++---------------------------
 1 file changed, 40 insertions(+), 115 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 101ab3b40c2d..f7358b5547dc 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -21,7 +21,6 @@
 
 #include <linux/io.h>
 #include <linux/iommu.h>
-#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -44,30 +43,20 @@
 #define GART_PAGE_MASK						\
 	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
 
-struct gart_client {
-	struct device		*dev;
-	struct list_head	list;
-};
-
 struct gart_device {
 	void __iomem		*regs;
 	u32			*savedata;
 	u32			page_count;	/* total remappable size */
 	dma_addr_t		iovmm_base;	/* offset to vmm_area */
 	spinlock_t		pte_lock;	/* for pagetable */
-	struct list_head	client;
-	spinlock_t		client_lock;	/* for client list */
+	spinlock_t		dom_lock;	/* for active domain */
+	unsigned int		active_devices;	/* number of active devices */
 	struct iommu_domain	*active_domain;	/* current active domain */
 	struct device		*dev;
 
 	struct iommu_device	iommu;		/* IOMMU Core handle */
 };
 
-struct gart_domain {
-	struct iommu_domain domain;		/* generic domain handle */
-	struct gart_device *gart;		/* link to gart device   */
-};
-
 static struct gart_device *gart_handle; /* unique for a system */
 
 static bool gart_debug;
@@ -75,11 +64,6 @@ static bool gart_debug;
 #define GART_PTE(_pfn)						\
 	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
 
-static struct gart_domain *to_gart_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct gart_domain, domain);
-}
-
 /*
  * Any interaction between any block on PPSB and a block on APB or AHB
  * must have these read-back to ensure the APB/AHB bus transaction is
@@ -168,125 +152,70 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
 static int gart_iommu_attach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
 	struct gart_device *gart = gart_handle;
-	struct gart_client *client, *c;
-	int err = 0;
-
-	client = kzalloc(sizeof(*c), GFP_KERNEL);
-	if (!client)
-		return -ENOMEM;
-	client->dev = dev;
-
-	spin_lock(&gart->client_lock);
-	list_for_each_entry(c, &gart->client, list) {
-		if (c->dev == dev) {
-			dev_err(gart->dev,
-				"%s is already attached\n", dev_name(dev));
-			err = -EINVAL;
-			goto fail;
-		}
-	}
-	if (gart->active_domain && gart->active_domain != domain) {
-		dev_err(gart->dev, "Only one domain can be active at a time\n");
-		err = -EINVAL;
-		goto fail;
-	}
-	gart->active_domain = domain;
-	gart_domain->gart = gart;
-	list_add(&client->list, &gart->client);
-	spin_unlock(&gart->client_lock);
-	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
-	return 0;
+	int ret = 0;
 
-fail:
-	kfree(client);
-	spin_unlock(&gart->client_lock);
-	return err;
-}
+	spin_lock(&gart->dom_lock);
 
-static void __gart_iommu_detach_dev(struct iommu_domain *domain,
-				    struct device *dev)
-{
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
-	struct gart_client *c;
-
-	list_for_each_entry(c, &gart->client, list) {
-		if (c->dev == dev) {
-			list_del(&c->list);
-			kfree(c);
-			if (list_empty(&gart->client)) {
-				gart->active_domain = NULL;
-				gart_domain->gart = NULL;
-			}
-			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
-			return;
-		}
+	if (gart->active_domain && gart->active_domain != domain) {
+		ret = -EBUSY;
+	} else if (dev->archdata.iommu != domain) {
+		dev->archdata.iommu = domain;
+		gart->active_domain = domain;
+		gart->active_devices++;
 	}
 
-	dev_err(gart->dev, "Couldn't find %s to detach\n", dev_name(dev));
+	spin_unlock(&gart->dom_lock);
+
+	return ret;
 }
 
 static void gart_iommu_detach_dev(struct iommu_domain *domain,
 				  struct device *dev)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
+
+	spin_lock(&gart->dom_lock);
 
-	spin_lock(&gart->client_lock);
-	__gart_iommu_detach_dev(domain, dev);
-	spin_unlock(&gart->client_lock);
+	if (dev->archdata.iommu == domain) {
+		dev->archdata.iommu = NULL;
+
+		if (--gart->active_devices == 0)
+			gart->active_domain = NULL;
+	}
+
+	spin_unlock(&gart->dom_lock);
 }
 
 static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
 {
-	struct gart_domain *gart_domain;
-	struct gart_device *gart;
+	struct gart_device *gart = gart_handle;
+	struct iommu_domain *domain;
 
 	if (type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
-	gart = gart_handle;
-	if (!gart)
-		return NULL;
-
-	gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
-	if (!gart_domain)
-		return NULL;
-
-	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
-	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (domain) {
+		domain->geometry.aperture_start = gart->iovmm_base;
+		domain->geometry.aperture_end = gart->iovmm_base +
 					gart->page_count * GART_PAGE_SIZE - 1;
-	gart_domain->domain.geometry.force_aperture = true;
+		domain->geometry.force_aperture = true;
+	}
 
-	return &gart_domain->domain;
+	return domain;
 }
 
 static void gart_iommu_domain_free(struct iommu_domain *domain)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
-
-	if (gart) {
-		spin_lock(&gart->client_lock);
-		if (!list_empty(&gart->client)) {
-			struct gart_client *c, *tmp;
-
-			list_for_each_entry_safe(c, tmp, &gart->client, list)
-				__gart_iommu_detach_dev(domain, c->dev);
-		}
-		spin_unlock(&gart->client_lock);
-	}
-
-	kfree(gart_domain);
+	WARN_ON(gart_handle->active_domain == domain);
+	kfree(domain);
 }
 
 static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 			  phys_addr_t pa, size_t bytes, int prot)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long flags;
 	unsigned long pfn;
 	unsigned long pte;
@@ -317,8 +246,7 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			       size_t bytes)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long flags;
 
 	if (!gart_iova_range_valid(gart, iova, bytes))
@@ -333,8 +261,7 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 	unsigned long pte;
 	phys_addr_t pa;
 	unsigned long flags;
@@ -393,8 +320,7 @@ static int gart_iommu_of_xlate(struct device *dev,
 
 static void gart_iommu_sync(struct iommu_domain *domain)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
+	struct gart_device *gart = gart_handle;
 
 	FLUSH_GART_REGS(gart);
 }
@@ -487,8 +413,7 @@ struct gart_device *tegra_gart_probe(struct device *dev,
 	gart->dev = dev;
 	gart_regs = mc->regs + GART_REG_BASE;
 	spin_lock_init(&gart->pte_lock);
-	spin_lock_init(&gart->client_lock);
-	INIT_LIST_HEAD(&gart->client);
+	spin_lock_init(&gart->dom_lock);
 	gart->regs = gart_regs;
 	gart->iovmm_base = (dma_addr_t)res_remap->start;
 	gart->page_count = (resource_size(res_remap) >> GART_PAGE_SHIFT);
-- 
2.19.0
