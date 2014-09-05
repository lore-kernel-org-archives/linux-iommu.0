From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 02/12] iommu: Convert iommu-caps from define to enum
Date: Fri,  5 Sep 2014 12:52:54 +0200
Message-ID: <1409914384-21191-3-git-send-email-joro@8bytes.org>
References: <1409914384-21191-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1409914384-21191-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Allow compile-time type-checking.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c |  2 +-
 include/linux/iommu.h | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1bc882e..319d40e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -955,7 +955,7 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
 
 int iommu_domain_has_cap(struct iommu_domain *domain,
-			 unsigned long cap)
+			 enum iommu_cap cap)
 {
 	if (domain->ops->domain_has_cap != NULL)
 		return domain->ops->domain_has_cap(domain, cap);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d43146a..d5534d5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -57,8 +57,11 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 };
 
-#define IOMMU_CAP_CACHE_COHERENCY	0x1
-#define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
+enum iommu_cap {
+	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
+					   transactions */
+	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
+};
 
 /*
  * Following constraints are specifc to FSL_PAMUV1:
@@ -157,7 +160,7 @@ extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 		       size_t size);
 extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova);
 extern int iommu_domain_has_cap(struct iommu_domain *domain,
-				unsigned long cap);
+				enum iommu_cap cap);
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
 
@@ -312,7 +315,7 @@ static inline phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_ad
 }
 
 static inline int iommu_domain_has_cap(struct iommu_domain *domain,
-				       unsigned long cap)
+				       enum iommu_cap cap)
 {
 	return 0;
 }
-- 
1.9.1
