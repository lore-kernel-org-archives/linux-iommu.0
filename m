From: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [Patch Part3 V3 12/21] iommu/vt-d: introduce helper function
	iova_size() to improve code readability
Date: Wed, 25 Jun 2014 17:02:38 +0800
Message-ID: <1403686967-10887-13-git-send-email-jiang.liu@linux.intel.com>
References: <1403686967-10887-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403686967-10887-1-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hotplug-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |    7 +++----
 include/linux/iova.h        |    5 +++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0d34f33bea34..d94468ae2947 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3117,10 +3117,10 @@ static void flush_unmaps(void)
 			/* On real hardware multiple invalidations are expensive */
 			if (cap_caching_mode(iommu->cap))
 				iommu_flush_iotlb_psi(iommu, domain->id,
-					iova->pfn_lo, iova->pfn_hi - iova->pfn_lo + 1,
+					iova->pfn_lo, iova_size(iova),
 					!deferred_flush[i].freelist[j], 0);
 			else {
-				mask = ilog2(mm_to_dma_pfn(iova->pfn_hi - iova->pfn_lo + 1));
+				mask = ilog2(mm_to_dma_pfn(iova_size(iova)));
 				iommu_flush_dev_iotlb(deferred_flush[i].domain[j],
 						(uint64_t)iova->pfn_lo << PAGE_SHIFT, mask);
 			}
@@ -3921,8 +3921,7 @@ static int intel_iommu_memory_notifier(struct notifier_block *nb,
 			rcu_read_lock();
 			for_each_active_iommu(iommu, drhd)
 				iommu_flush_iotlb_psi(iommu, si_domain->id,
-					iova->pfn_lo,
-					iova->pfn_hi - iova->pfn_lo + 1,
+					iova->pfn_lo, iova_size(iova),
 					!freelist, 0);
 			rcu_read_unlock();
 			dma_free_pagelist(freelist);
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 3277f4711349..19e81d5ccb6d 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -34,6 +34,11 @@ struct iova_domain {
 	unsigned long	dma_32bit_pfn;
 };
 
+static inline unsigned long iova_size(struct iova *iova)
+{
+	return iova->pfn_hi - iova->pfn_lo + 1;
+}
+
 struct iova *alloc_iova_mem(void);
 void free_iova_mem(struct iova *iova);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
-- 
1.7.10.4
