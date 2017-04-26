From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] iommu: Move report_iommu_fault() to iommu.c
Date: Wed, 26 Apr 2017 17:45:04 +0200
Message-ID: <1493221506-7651-3-git-send-email-joro@8bytes.org>
References: <1493221506-7651-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1493221506-7651-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

The function is in no fast-path, there is no need for it to
be static inline in a header file. This also removes the
need to include iommu trace-points in iommu.h.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h | 41 ++---------------------------------------
 2 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3b67144..f51e9c8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1652,6 +1652,48 @@ void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr)
 }
 EXPORT_SYMBOL_GPL(iommu_domain_window_disable);
 
+/**
+ * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
+ * @domain: the iommu domain where the fault has happened
+ * @dev: the device where the fault has happened
+ * @iova: the faulting address
+ * @flags: mmu fault flags (e.g. IOMMU_FAULT_READ/IOMMU_FAULT_WRITE/...)
+ *
+ * This function should be called by the low-level IOMMU implementations
+ * whenever IOMMU faults happen, to allow high-level users, that are
+ * interested in such events, to know about them.
+ *
+ * This event may be useful for several possible use cases:
+ * - mere logging of the event
+ * - dynamic TLB/PTE loading
+ * - if restarting of the faulting device is required
+ *
+ * Returns 0 on success and an appropriate error code otherwise (if dynamic
+ * PTE/TLB loading will one day be supported, implementations will be able
+ * to tell whether it succeeded or not according to this return value).
+ *
+ * Specifically, -ENOSYS is returned if a fault handler isn't installed
+ * (though fault handlers can also return -ENOSYS, in case they want to
+ * elicit the default behavior of the IOMMU drivers).
+ */
+int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
+		       unsigned long iova, int flags)
+{
+	int ret = -ENOSYS;
+
+	/*
+	 * if upper layers showed interest and installed a fault handler,
+	 * invoke it.
+	 */
+	if (domain->handler)
+		ret = domain->handler(domain, dev, iova, flags,
+						domain->handler_token);
+
+	trace_io_page_fault(dev, iova, flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(report_iommu_fault);
+
 static int __init iommu_init(void)
 {
 	iommu_group_kset = kset_create_and_add("iommu_groups",
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0232104..2a62593 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -338,46 +338,9 @@ extern int iommu_domain_window_enable(struct iommu_domain *domain, u32 wnd_nr,
 				      phys_addr_t offset, u64 size,
 				      int prot);
 extern void iommu_domain_window_disable(struct iommu_domain *domain, u32 wnd_nr);
-/**
- * report_iommu_fault() - report about an IOMMU fault to the IOMMU framework
- * @domain: the iommu domain where the fault has happened
- * @dev: the device where the fault has happened
- * @iova: the faulting address
- * @flags: mmu fault flags (e.g. IOMMU_FAULT_READ/IOMMU_FAULT_WRITE/...)
- *
- * This function should be called by the low-level IOMMU implementations
- * whenever IOMMU faults happen, to allow high-level users, that are
- * interested in such events, to know about them.
- *
- * This event may be useful for several possible use cases:
- * - mere logging of the event
- * - dynamic TLB/PTE loading
- * - if restarting of the faulting device is required
- *
- * Returns 0 on success and an appropriate error code otherwise (if dynamic
- * PTE/TLB loading will one day be supported, implementations will be able
- * to tell whether it succeeded or not according to this return value).
- *
- * Specifically, -ENOSYS is returned if a fault handler isn't installed
- * (though fault handlers can also return -ENOSYS, in case they want to
- * elicit the default behavior of the IOMMU drivers).
- */
-static inline int report_iommu_fault(struct iommu_domain *domain,
-		struct device *dev, unsigned long iova, int flags)
-{
-	int ret = -ENOSYS;
 
-	/*
-	 * if upper layers showed interest and installed a fault handler,
-	 * invoke it.
-	 */
-	if (domain->handler)
-		ret = domain->handler(domain, dev, iova, flags,
-						domain->handler_token);
-
-	trace_io_page_fault(dev, iova, flags);
-	return ret;
-}
+extern int report_iommu_fault(struct iommu_domain *domain, struct device *dev,
+			      unsigned long iova, int flags);
 
 static inline size_t iommu_map_sg(struct iommu_domain *domain,
 				  unsigned long iova, struct scatterlist *sg,
-- 
1.9.1
