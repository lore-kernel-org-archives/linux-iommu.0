From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v8 2/7] iommu/dma: Add support for non-strict mode
Date: Thu, 20 Sep 2018 17:10:22 +0100
Message-ID: <bd0efe2b9a26e35cfd9b4157bea3e6f21f4c8adf.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1537458163.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, huawei.libin-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

With the flush queue infrastructure already abstracted into IOVA
domains, hooking it up in iommu-dma is pretty simple. Since there is a
degree of dependency on the IOMMU driver knowing what to do to play
along, we key the whole thing off a domain attribute which will be set
on default DMA ops domains to request non-strict invalidation. That way,
drivers can indicate the appropriate support by acknowledging the
attribute, and we can easily fall back to strict invalidation otherwise.

The flush queue callback needs a handle on the iommu_domain which owns
our cookie, so we have to add a pointer back to that, but neatly, that's
also sufficient to indicate whether we're using a flush queue or not,
and thus which way to release IOVAs. The only slight subtlety is
switching __iommu_dma_unmap() from calling iommu_unmap() to explicit
iommu_unmap_fast()/iommu_tlb_sync() so that we can elide the sync
entirely in non-strict mode.

Signed-off-by: Zhen Lei <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
[rm: convert to domain attribute, tweak comments and commit message]
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v8:
 - Rewrite commit message/comments
 - Don't initialise "attr" unnecessarily
 - Rename "domain" to "fq_domain" for clarity
 - Don't let init_iova_flush_queue() be called more than once

 drivers/iommu/dma-iommu.c | 32 +++++++++++++++++++++++++++++++-
 include/linux/iommu.h     |  1 +
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 511ff9a1d6d9..cc1bf786cfac 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -55,6 +55,9 @@ struct iommu_dma_cookie {
 	};
 	struct list_head		msi_page_list;
 	spinlock_t			msi_lock;
+
+	/* Domain for flush queue callback; NULL if flush queue not in use */
+	struct iommu_domain		*fq_domain;
 };
 
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
@@ -257,6 +260,20 @@ static int iova_reserve_iommu_regions(struct device *dev,
 	return ret;
 }
 
+static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
+{
+	struct iommu_dma_cookie *cookie;
+	struct iommu_domain *domain;
+
+	cookie = container_of(iovad, struct iommu_dma_cookie, iovad);
+	domain = cookie->fq_domain;
+	/*
+	 * The IOMMU driver supporting DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE
+	 * implies that ops->flush_iotlb_all must be non-NULL.
+	 */
+	domain->ops->flush_iotlb_all(domain);
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -275,6 +292,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long order, base_pfn, end_pfn;
+	int attr;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
 		return -EINVAL;
@@ -308,6 +326,13 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	}
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
+
+	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
+			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
+		cookie->fq_domain = domain;
+		init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all, NULL);
+	}
+
 	if (!dev)
 		return 0;
 
@@ -393,6 +418,9 @@ static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
 	/* The MSI case is only ever cleaning up its most recent allocation */
 	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
 		cookie->msi_iova -= size;
+	else if (cookie->fq_domain)	/* non-strict mode */
+		queue_iova(iovad, iova_pfn(iovad, iova),
+				size >> iova_shift(iovad), 0);
 	else
 		free_iova_fast(iovad, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad));
@@ -408,7 +436,9 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr,
 	dma_addr -= iova_off;
 	size = iova_align(iovad, size + iova_off);
 
-	WARN_ON(iommu_unmap(domain, dma_addr, size) != size);
+	WARN_ON(iommu_unmap_fast(domain, dma_addr, size) != size);
+	if (!cookie->fq_domain)
+		iommu_tlb_sync(domain);
 	iommu_dma_free_iova(cookie, dma_addr, size);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 87994c265bf5..decabe8e8dbe 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -124,6 +124,7 @@ enum iommu_attr {
 	DOMAIN_ATTR_FSL_PAMU_ENABLE,
 	DOMAIN_ATTR_FSL_PAMUV1,
 	DOMAIN_ATTR_NESTING,	/* two stages of translation */
+	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
 	DOMAIN_ATTR_MAX,
 };
 
-- 
2.19.0.dirty
