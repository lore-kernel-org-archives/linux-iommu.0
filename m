From: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 2/3] intel-iommu: generalize __mapping_notify_one()
Date: Wed, 18 Apr 2018 16:39:52 +0800
Message-ID: <20180418083953.21492-3-peterx@redhat.com>
References: <20180418083953.21492-1-peterx@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180418083953.21492-1-peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Linux IOMMU Mailing List <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Alexander Witte <alexander.witte-eh6l0D9wmvKB+jHODAdFcQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jintack Lim <jintack-eQaUEPhvms7ENvBUuze7eA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Generalize this new helper to notify one newly created mapping on one
single IOMMU.  We can further leverage this helper in the next patch.

Signed-off-by: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a64da83e867c..bf111e60857c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1607,6 +1607,18 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
 		iommu_flush_dev_iotlb(domain, addr, mask);
 }
 
+/* Notification for newly created mappings */
+static inline void __mapping_notify_one(struct intel_iommu *iommu,
+					struct dmar_domain *domain,
+					unsigned long pfn, unsigned int pages)
+{
+	/* It's a non-present to present mapping. Only flush if caching mode */
+	if (cap_caching_mode(iommu->cap))
+		iommu_flush_iotlb_psi(iommu, domain, pfn, pages, 0, 1);
+	else
+		iommu_flush_write_buffer(iommu);
+}
+
 static void iommu_flush_iova(struct iova_domain *iovad)
 {
 	struct dmar_domain *domain;
@@ -3626,13 +3638,7 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 	if (ret)
 		goto error;
 
-	/* it's a non-present to present mapping. Only flush if caching mode */
-	if (cap_caching_mode(iommu->cap))
-		iommu_flush_iotlb_psi(iommu, domain,
-				      mm_to_dma_pfn(iova_pfn),
-				      size, 0, 1);
-	else
-		iommu_flush_write_buffer(iommu);
+	__mapping_notify_one(iommu, domain, mm_to_dma_pfn(iova_pfn), size);
 
 	start_paddr = (phys_addr_t)iova_pfn << PAGE_SHIFT;
 	start_paddr += paddr & ~PAGE_MASK;
@@ -3851,11 +3857,7 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 		return 0;
 	}
 
-	/* it's a non-present to present mapping. Only flush if caching mode */
-	if (cap_caching_mode(iommu->cap))
-		iommu_flush_iotlb_psi(iommu, domain, start_vpfn, size, 0, 1);
-	else
-		iommu_flush_write_buffer(iommu);
+	__mapping_notify_one(iommu, domain, start_vpfn, size);
 
 	return nelems;
 }
-- 
2.14.3
