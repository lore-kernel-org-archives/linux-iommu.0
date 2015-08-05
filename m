From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 19/26] iommu/vt-d: Establish domain<->iommu link in dmar_insert_one_dev_info
Date: Wed,  5 Aug 2015 17:18:50 +0200
Message-ID: <1438787937-7340-20-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This makes domain attachment more synchronous with domain
deattachment. The domain<->iommu link is released in
dmar_remove_one_dev_info.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/intel-iommu.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 90c3fa5..27762d7 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1916,14 +1916,16 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 				      struct intel_iommu *iommu,
 				      u8 bus, u8 devfn)
 {
+	u16 did = domain->iommu_did[iommu->seq_id];
 	int translation = CONTEXT_TT_MULTI_LEVEL;
 	struct device_domain_info *info = NULL;
 	struct context_entry *context;
 	unsigned long flags;
 	struct dma_pte *pgd;
-	int id;
 	int agaw;
 
+	WARN_ON(did == 0);
+
 	translation = CONTEXT_TT_MULTI_LEVEL;
 	if (hw_pass_through && domain_type_is_si(domain))
 		translation = CONTEXT_TT_PASS_THROUGH;
@@ -1946,15 +1948,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 
 	pgd = domain->pgd;
 
-	id = __iommu_attach_domain(domain, iommu);
-	if (id < 0) {
-		spin_unlock_irqrestore(&iommu->lock, flags);
-		pr_err("%s: No free domain ids\n", iommu->name);
-		return -EFAULT;
-	}
-
 	context_clear_entry(context);
-	context_set_domain_id(context, id);
+	context_set_domain_id(context, did);
 
 	/*
 	 * Skip top levels of page tables for iommu which has less agaw
@@ -2000,15 +1995,13 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 					   (((u16)bus) << 8) | devfn,
 					   DMA_CCMD_MASK_NOBIT,
 					   DMA_CCMD_DEVICE_INVL);
-		iommu->flush.flush_iotlb(iommu, id, 0, 0, DMA_TLB_DSI_FLUSH);
+		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
 	iommu_enable_dev_iotlb(info);
 	spin_unlock_irqrestore(&iommu->lock, flags);
 
-	domain_attach_iommu(domain, iommu);
-
 	return 0;
 }
 
@@ -2318,6 +2311,12 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		return found;
 	}
 
+	if (iommu_attach_domain(domain, iommu) < 0) {
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		return NULL;
+	}
+	domain_attach_iommu(domain, iommu);
+
 	list_add(&info->link, &domain->devices);
 	list_add(&info->global, &device_domain_list);
 	if (dev)
@@ -2381,11 +2380,6 @@ static struct dmar_domain *get_domain_for_dev(struct device *dev, int gaw)
 	domain = alloc_domain(0);
 	if (!domain)
 		return NULL;
-	if (iommu_attach_domain(domain, iommu) < 0) {
-		free_domain_mem(domain);
-		return NULL;
-	}
-	domain_attach_iommu(domain, iommu);
 	if (domain_init(domain, iommu, gaw)) {
 		domain_exit(domain);
 		return NULL;
-- 
1.9.1
