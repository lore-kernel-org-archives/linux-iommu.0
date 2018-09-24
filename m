From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 04/20] iommu: Introduce iotlb_sync_map callback
Date: Mon, 24 Sep 2018 03:41:37 +0300
Message-ID: <20180924004153.8232-5-digetx@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180924004153.8232-1-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Introduce iotlb_sync_map() callback that is invoked in the end of
iommu_map(). This new callback allows IOMMU drivers to avoid syncing
after mapping of each contiguous chunk and sync only when the whole
mapping is completed, optimizing performance of the mapping operation.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/iommu.c | 8 ++++++--
 include/linux/iommu.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..8979b16caf61 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1545,13 +1545,14 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	      phys_addr_t paddr, size_t size, int prot)
 {
+	const struct iommu_ops *ops = domain->ops;
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 	size_t orig_size = size;
 	phys_addr_t orig_paddr = paddr;
 	int ret = 0;
 
-	if (unlikely(domain->ops->map == NULL ||
+	if (unlikely(ops->map == NULL ||
 		     domain->pgsize_bitmap == 0UL))
 		return -ENODEV;
 
@@ -1580,7 +1581,7 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
 			 iova, &paddr, pgsize);
 
-		ret = domain->ops->map(domain, iova, paddr, pgsize, prot);
+		ret = ops->map(domain, iova, paddr, pgsize, prot);
 		if (ret)
 			break;
 
@@ -1589,6 +1590,9 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		size -= pgsize;
 	}
 
+	if (ops->iotlb_sync_map)
+		ops->iotlb_sync_map(domain);
+
 	/* unroll mapping in case something went wrong */
 	if (ret)
 		iommu_unmap(domain, orig_iova, orig_size - size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 87994c265bf5..4c488eb69752 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -202,6 +202,7 @@ struct iommu_ops {
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
 	void (*iotlb_range_add)(struct iommu_domain *domain,
 				unsigned long iova, size_t size);
+	void (*iotlb_sync_map)(struct iommu_domain *domain);
 	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
-- 
2.19.0
