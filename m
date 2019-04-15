From: Tom Murphy <tmurphy@arista.com>
Subject: [PATCH] iommu/amd: Add allocated domain to global list earlier
Date: Mon, 15 Apr 2019 19:05:56 +0100
Message-ID: <20190415180556.5018-1-tmurphy@arista.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>, Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

dma_ops_domain_free() expects domain to be in a global list.
Arguably, could be called before protection_domain_init().

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 02b351834a3b..bfb021d656aa 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1801,8 +1801,12 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(domain))
-		goto free_domain;
+	if (protection_domain_init(domain)) {
+		kfree(domain);
+		return NULL;
+	}
+
+	add_domain_to_list(domain);
 
 	domain->mode = PAGE_MODE_3_LEVEL;
 	domain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
@@ -1824,8 +1828,6 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	/* Initialize reserved ranges */
 	iommu_dma_copy_reserved_iova(&reserved_iova_ranges, &domain->domain);
 
-	add_domain_to_list(domain);
-
 	return domain;
 
 free_cookie:
-- 
2.17.1
