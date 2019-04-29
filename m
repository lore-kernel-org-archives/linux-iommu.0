From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Cleanup: no spaces at the start of a line
Date: Mon, 29 Apr 2019 09:16:02 +0800
Message-ID: <20190429011602.17625-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Replace the whitespaces at the start of a line with tabs. No
functional changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 53 +++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c1f2f83e25d2..e0c0febc6fa5 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2341,32 +2341,33 @@ static int __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
 }
 
 static int domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
-                         struct scatterlist *sg, unsigned long phys_pfn,
-                         unsigned long nr_pages, int prot)
-{
-       int ret;
-       struct intel_iommu *iommu;
-
-       /* Do the real mapping first */
-       ret = __domain_mapping(domain, iov_pfn, sg, phys_pfn, nr_pages, prot);
-       if (ret)
-               return ret;
-
-       /* Notify about the new mapping */
-       if (domain_type_is_vm(domain)) {
-	       /* VM typed domains can have more than one IOMMUs */
-	       int iommu_id;
-	       for_each_domain_iommu(iommu_id, domain) {
-		       iommu = g_iommus[iommu_id];
-		       __mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
-	       }
-       } else {
-	       /* General domains only have one IOMMU */
-	       iommu = domain_get_iommu(domain);
-	       __mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
-       }
+			  struct scatterlist *sg, unsigned long phys_pfn,
+			  unsigned long nr_pages, int prot)
+{
+	int ret;
+	struct intel_iommu *iommu;
+
+	/* Do the real mapping first */
+	ret = __domain_mapping(domain, iov_pfn, sg, phys_pfn, nr_pages, prot);
+	if (ret)
+		return ret;
 
-       return 0;
+	/* Notify about the new mapping */
+	if (domain_type_is_vm(domain)) {
+		/* VM typed domains can have more than one IOMMUs */
+		int iommu_id;
+
+		for_each_domain_iommu(iommu_id, domain) {
+			iommu = g_iommus[iommu_id];
+			__mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
+		}
+	} else {
+		/* General domains only have one IOMMU */
+		iommu = domain_get_iommu(domain);
+		__mapping_notify_one(iommu, domain, iov_pfn, nr_pages);
+	}
+
+	return 0;
 }
 
 static inline int domain_sg_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
@@ -4098,7 +4099,7 @@ static int init_iommu_hw(void)
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
-	
+
 		iommu_flush_write_buffer(iommu);
 
 		iommu_set_root_entry(iommu);
-- 
2.17.1
