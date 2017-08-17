From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 02/13] iommu: Introduce Interface for IOMMU TLB Flushing
Date: Thu, 17 Aug 2017 14:56:25 +0200
Message-ID: <1502974596-23835-3-git-send-email-joro@8bytes.org>
References: <1502974596-23835-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502974596-23835-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

With the current IOMMU-API the hardware TLBs have to be
flushed in every iommu_map(), iommu_map_sg(), and
iommu_unmap() call.

For unmapping large amounts of address space, like it
happens when a KVM domain with assigned devices is
destroyed, this causes thousands of unnecessary TLB flushes
in the IOMMU hardware because the unmap call-back runs for
every unmapped physical page.

With the TLB Flush Interface introduced here the need to
clean the hardware TLBs is removed from the iommu_map/unmap
functions. Users now have to explicitly call these functions
to sync the page-table changes to the hardware.

Three functions are introduced:

	* iommu_flush_tlb_all() - Flushes all TLB entries
	                          associated with that
				  domain. TLBs entries are
				  flushed when this function
				  returns.

	* iommu_tlb_range_add() - This will add a given
				  range to the flush queue
				  for this domain.

	* iommu_tlb_sync() - Flushes all queued ranges from
			     the hardware TLBs. Returns when
			     the flush is finished.

The semantic of this interface is intentionally similar to
the iommu_gather_ops from the io-pgtable code.

Additionally, this patch introduces synchronized versions of
the iommu_map(), iommu_map_sg(), and iommu_unmap()
functions. They will be used by current users of the
IOMMU-API, before they are optimized to the unsynchronized
versions.

Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 26 +++++++++++++++++
 include/linux/iommu.h | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3f6ea16..816e248 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -527,6 +527,8 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 
 	}
 
+	iommu_flush_tlb_all(domain);
+
 out:
 	iommu_put_resv_regions(dev, &mappings);
 
@@ -1556,6 +1558,18 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_map);
 
+int iommu_map_sync(struct iommu_domain *domain, unsigned long iova,
+		   phys_addr_t paddr, size_t size, int prot)
+{
+	int ret = iommu_map(domain, iova, paddr, size, prot);
+
+	iommu_tlb_range_add(domain, iova, size);
+	iommu_tlb_sync(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_map_sync);
+
 size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 {
 	size_t unmapped_page, unmapped = 0;
@@ -1608,6 +1622,18 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
+size_t iommu_unmap_sync(struct iommu_domain *domain,
+			unsigned long iova, size_t size)
+{
+	size_t ret = iommu_unmap(domain, iova, size);
+
+	iommu_tlb_range_add(domain, iova, size);
+	iommu_tlb_sync(domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_unmap_sync);
+
 size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			 struct scatterlist *sg, unsigned int nents, int prot)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54ad..7f9c114 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -167,6 +167,10 @@ struct iommu_resv_region {
  * @map: map a physically contiguous memory region to an iommu domain
  * @unmap: unmap a physically contiguous memory region from an iommu domain
  * @map_sg: map a scatter-gather list of physically contiguous memory chunks
+ * @flush_tlb_all: Synchronously flush all hardware TLBs for this domain
+ * @tlb_range_add: Add a given iova range to the flush queue for this domain
+ * @tlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
+ *            queue
  * to an iommu domain
  * @iova_to_phys: translate iova to physical address
  * @add_device: add device to iommu grouping
@@ -199,6 +203,10 @@ struct iommu_ops {
 		     size_t size);
 	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
 			 struct scatterlist *sg, unsigned int nents, int prot);
+	void (*flush_iotlb_all)(struct iommu_domain *domain);
+	void (*iotlb_range_add)(struct iommu_domain *domain,
+				unsigned long iova, size_t size);
+	void (*iotlb_sync)(struct iommu_domain *domain);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
@@ -285,8 +293,12 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
+extern int iommu_map_sync(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t paddr, size_t size, int prot);
 extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-		       size_t size);
+			  size_t size);
+extern size_t iommu_unmap_sync(struct iommu_domain *domain,
+			       unsigned long iova, size_t size);
 extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 				struct scatterlist *sg,unsigned int nents,
 				int prot);
@@ -343,6 +355,25 @@ extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
 			      unsigned long iova, int flags);
 
+static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
+{
+	if (domain->ops->flush_iotlb_all)
+		domain->ops->flush_iotlb_all(domain);
+}
+
+static inline void iommu_tlb_range_add(struct iommu_domain *domain,
+				       unsigned long iova, size_t size)
+{
+	if (domain->ops->iotlb_range_add)
+		domain->ops->iotlb_range_add(domain, iova, size);
+}
+
+static inline void iommu_tlb_sync(struct iommu_domain *domain)
+{
+	if (domain->ops->iotlb_sync)
+		domain->ops->iotlb_sync(domain);
+}
+
 static inline size_t iommu_map_sg(struct iommu_domain *domain,
 				  unsigned long iova, struct scatterlist *sg,
 				  unsigned int nents, int prot)
@@ -350,6 +381,20 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 	return domain->ops->map_sg(domain, iova, sg, nents, prot);
 }
 
+static inline size_t iommu_map_sg_sync(struct iommu_domain *domain,
+				       unsigned long iova,
+				       struct scatterlist *sg,
+				       unsigned int nents, int prot)
+{
+	size_t size = domain->ops->map_sg(domain, iova, sg, nents, prot);
+	if (size > 0) {
+		iommu_tlb_range_add(domain, iova, size);
+		iommu_tlb_sync(domain);
+	}
+
+	return size;
+}
+
 /* PCI device grouping function */
 extern struct iommu_group *pci_device_group(struct device *dev);
 /* Generic device grouping function */
@@ -430,12 +475,24 @@ static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
+static inline int iommu_map_sync(struct iommu_domain *domain, unsigned long iova,
+				 phys_addr_t paddr, int gfp_order, int prot)
+{
+	return -ENODEV;
+}
+
 static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 			      int gfp_order)
 {
 	return -ENODEV;
 }
 
+static inline int iommu_unmap_sync(struct iommu_domain *domain, unsigned long iova,
+				   int gfp_order)
+{
+	return -ENODEV;
+}
+
 static inline size_t iommu_map_sg(struct iommu_domain *domain,
 				  unsigned long iova, struct scatterlist *sg,
 				  unsigned int nents, int prot)
@@ -443,6 +500,27 @@ static inline size_t iommu_map_sg(struct iommu_domain *domain,
 	return -ENODEV;
 }
 
+static inline size_t iommu_map_sg_sync(struct iommu_domain *domain,
+				       unsigned long iova,
+				       struct scatterlist *sg,
+				       unsigned int nents, int prot)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_flush_tlb_all(struct iommu_domain *domain)
+{
+}
+
+static inline void iommu_tlb_range_add(struct iommu_domain *domain,
+				       unsigned long iova, size_t size)
+{
+}
+
+static inline void iommu_tlb_sync(struct iommu_domain *domain)
+{
+}
+
 static inline int iommu_domain_window_enable(struct iommu_domain *domain,
 					     u32 wnd_nr, phys_addr_t paddr,
 					     u64 size, int prot)
-- 
2.7.4
