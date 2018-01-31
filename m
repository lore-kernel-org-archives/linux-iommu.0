From: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/2] iommu: Fix iommu_unmap and iommu_unmap_fast return type
Date: Tue, 30 Jan 2018 20:48:04 -0500
Message-ID: <1517363285-89304-2-git-send-email-suravee.suthikulpanit@amd.com>
References: <1517363285-89304-1-git-send-email-suravee.suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1517363285-89304-1-git-send-email-suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently, iommu_unmap and iommu_unmap_fast return unmapped
pages with size_t.  However, the actual value returned could
be error codes (< 0), which can be misinterpreted as large
number of unmapped pages. Therefore, change the return type to ssize_t.

Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>
---
 drivers/iommu/amd_iommu.c   |  6 +++---
 drivers/iommu/intel-iommu.c |  4 ++--
 drivers/iommu/iommu.c       | 16 ++++++++--------
 include/linux/iommu.h       | 20 ++++++++++----------
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 7d5eb00..3609f51 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3030,11 +3030,11 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	return ret;
 }
 
-static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
-			   size_t page_size)
+static ssize_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
+			       size_t page_size)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	size_t unmap_size;
+	ssize_t unmap_size;
 
 	if (domain->mode == PAGE_MODE_NONE)
 		return -EINVAL;
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4a2de34..15ba866 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5068,8 +5068,8 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	return ret;
 }
 
-static size_t intel_iommu_unmap(struct iommu_domain *domain,
-				unsigned long iova, size_t size)
+static ssize_t intel_iommu_unmap(struct iommu_domain *domain,
+				 unsigned long iova, size_t size)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct page *freelist = NULL;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3de5c0b..8f7da8a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1557,12 +1557,12 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 }
 EXPORT_SYMBOL_GPL(iommu_map);
 
-static size_t __iommu_unmap(struct iommu_domain *domain,
-			    unsigned long iova, size_t size,
-			    bool sync)
+static ssize_t __iommu_unmap(struct iommu_domain *domain,
+			     unsigned long iova, size_t size,
+			     bool sync)
 {
 	const struct iommu_ops *ops = domain->ops;
-	size_t unmapped_page, unmapped = 0;
+	ssize_t unmapped_page, unmapped = 0;
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
 
@@ -1617,15 +1617,15 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
 	return unmapped;
 }
 
-size_t iommu_unmap(struct iommu_domain *domain,
-		   unsigned long iova, size_t size)
+ssize_t iommu_unmap(struct iommu_domain *domain,
+		    unsigned long iova, size_t size)
 {
 	return __iommu_unmap(domain, iova, size, true);
 }
 EXPORT_SYMBOL_GPL(iommu_unmap);
 
-size_t iommu_unmap_fast(struct iommu_domain *domain,
-			unsigned long iova, size_t size)
+ssize_t iommu_unmap_fast(struct iommu_domain *domain,
+			 unsigned long iova, size_t size)
 {
 	return __iommu_unmap(domain, iova, size, false);
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 41b8c57..78df048 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -199,8 +199,8 @@ struct iommu_ops {
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot);
-	size_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
-		     size_t size);
+	ssize_t (*unmap)(struct iommu_domain *domain, unsigned long iova,
+			 size_t size);
 	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
 			 struct scatterlist *sg, unsigned int nents, int prot);
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
@@ -299,10 +299,10 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
-extern size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			  size_t size);
-extern size_t iommu_unmap_fast(struct iommu_domain *domain,
-			       unsigned long iova, size_t size);
+extern ssize_t iommu_unmap(struct iommu_domain *domain, unsigned long iova,
+			   size_t size);
+extern ssize_t iommu_unmap_fast(struct iommu_domain *domain,
+				unsigned long iova, size_t size);
 extern size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 				struct scatterlist *sg,unsigned int nents,
 				int prot);
@@ -465,14 +465,14 @@ static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return -ENODEV;
 }
 
-static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			      size_t size)
+static inline ssize_t iommu_unmap(struct iommu_domain *domain,
+				  unsigned long iova, size_t size)
 {
 	return -ENODEV;
 }
 
-static inline int iommu_unmap_fast(struct iommu_domain *domain, unsigned long iova,
-				   int gfp_order)
+static inline ssize_t iommu_unmap_fast(struct iommu_domain *domain,
+				       unsigned long iova, int gfp_order)
 {
 	return -ENODEV;
 }
-- 
1.8.3.1
