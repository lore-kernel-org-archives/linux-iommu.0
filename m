From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 18/20] iommu/amd: Handle IOMMU_DOMAIN_DMA in ops->domain_free call-back
Date: Fri,  8 Jul 2016 13:45:09 +0200
Message-ID: <1467978311-28322-19-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Vincent.Wan@amd.com, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This domain type is not yet handled in the
iommu_ops->domain_free() call-back. Fix that.

Fixes: 0bb6e243d7fb ('iommu/amd: Support IOMMU_DOMAIN_DMA type allocation')
Cc: stable@vger.kernel.org # v4.2+
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 4b17148..dc3dbb4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2836,9 +2836,7 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned type)
 static void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
-
-	if (!dom)
-		return;
+	struct dma_ops_domain *dma_dom;
 
 	domain = to_pdomain(dom);
 
@@ -2847,13 +2845,24 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 
 	BUG_ON(domain->dev_cnt != 0);
 
-	if (domain->mode != PAGE_MODE_NONE)
-		free_pagetable(domain);
+	if (!dom)
+		return;
 
-	if (domain->flags & PD_IOMMUV2_MASK)
-		free_gcr3_table(domain);
+	switch (dom->type) {
+	case IOMMU_DOMAIN_DMA:
+		dma_dom = domain->priv;
+		dma_ops_domain_free(dma_dom);
+		break;
+	default:
+		if (domain->mode != PAGE_MODE_NONE)
+			free_pagetable(domain);
 
-	protection_domain_free(domain);
+		if (domain->flags & PD_IOMMUV2_MASK)
+			free_gcr3_table(domain);
+
+		protection_domain_free(domain);
+		break;
+	}
 }
 
 static void amd_iommu_detach_device(struct iommu_domain *dom,
-- 
1.9.1
