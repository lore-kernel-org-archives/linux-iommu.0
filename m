From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 06/10] iommu/vt-d: Add bounce buffer API for dma sync
Date: Wed, 27 Mar 2019 14:35:02 +0800
Message-ID: <20190327063506.32564-7-baolu.lu@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190327063506.32564-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alan.cox-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This adds the APIs for bounce buffer specified dma sync
ops.

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Tested-by: Xu Pengfei <pengfei.xu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-pgtable.c | 44 +++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h   |  4 ++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iommu/intel-pgtable.c b/drivers/iommu/intel-pgtable.c
index 1e56ea07f755..fbe1d0e073fd 100644
--- a/drivers/iommu/intel-pgtable.c
+++ b/drivers/iommu/intel-pgtable.c
@@ -242,6 +242,35 @@ bounce_sync(phys_addr_t orig_addr, phys_addr_t bounce_addr,
 	return 0;
 }
 
+static int
+bounce_sync_single(struct device *dev, struct dmar_domain *domain,
+		   dma_addr_t addr, phys_addr_t paddr, size_t size,
+		   enum dma_data_direction dir, unsigned long attrs,
+		   void *data)
+{
+	enum dma_sync_target *target = data;
+	struct bounce_cookie *cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bounce_lock, flags);
+	cookie = idr_find(&domain->bounce_idr, addr >> PAGE_SHIFT);
+	spin_unlock_irqrestore(&bounce_lock, flags);
+	if (!cookie)
+		return 0;
+
+	if (*target == SYNC_FOR_DEVICE) {
+		if (dir == DMA_BIDIRECTIONAL || dir == DMA_TO_DEVICE)
+			bounce_sync(cookie->original_phys, cookie->bounce_phys,
+				    size, DMA_TO_DEVICE);
+	} else {
+		if (dir == DMA_BIDIRECTIONAL || dir == DMA_FROM_DEVICE)
+			bounce_sync(cookie->original_phys, cookie->bounce_phys,
+				    size, DMA_FROM_DEVICE);
+	}
+
+	return 0;
+}
+
 static int bounce_map(struct device *dev, struct dmar_domain *domain,
 		      dma_addr_t addr, phys_addr_t paddr, size_t size,
 		      enum dma_data_direction dir, unsigned long attrs,
@@ -315,6 +344,11 @@ static const struct addr_walk walk_bounce_unmap = {
 	.high = bounce_unmap,
 };
 
+static const struct addr_walk walk_bounce_sync_single = {
+	.low = bounce_sync_single,
+	.high = bounce_sync_single,
+};
+
 static int
 domain_walk_addr_range(const struct addr_walk *walk, struct device *dev,
 		       struct dmar_domain *domain, dma_addr_t addr,
@@ -401,3 +435,13 @@ int domain_bounce_unmap(struct device *dev, dma_addr_t addr,
 	return domain_walk_addr_range(&walk_bounce_unmap, dev, domain,
 				      addr, 0, size, dir, attrs, data);
 }
+
+int domain_bounce_sync_single(struct device *dev, dma_addr_t addr,
+			      size_t size, enum dma_data_direction dir,
+			      void *data)
+{
+	struct dmar_domain *domain = get_valid_domain_for_dev(dev);
+
+	return domain_walk_addr_range(&walk_bounce_sync_single, dev,
+				      domain, addr, 0, size, dir, 0, data);
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 8fd1768f8729..58f192c1f26f 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -31,6 +31,7 @@
 #include <linux/iommu.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/dmar.h>
+#include <linux/swiotlb.h>
 
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
@@ -695,6 +696,9 @@ int domain_bounce_map(struct device *dev, dma_addr_t addr, phys_addr_t paddr,
 int domain_bounce_unmap(struct device *dev, dma_addr_t addr,
 			size_t size, enum dma_data_direction dir,
 			unsigned long attrs, void *data);
+int domain_bounce_sync_single(struct device *dev, dma_addr_t addr,
+			      size_t size, enum dma_data_direction dir,
+			      void *data);
 #ifdef CONFIG_INTEL_IOMMU_SVM
 int intel_svm_init(struct intel_iommu *iommu);
 extern int intel_svm_enable_prq(struct intel_iommu *iommu);
-- 
2.17.1
