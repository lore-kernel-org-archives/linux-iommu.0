From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 13/18] iommu/vt-d: Move domain helper to header
Date: Mon,  8 Apr 2019 16:59:28 -0700
Message-ID: <1554767973-30125-14-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Move domainer helper to header to be used by SVA code.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 6 ------
 include/linux/intel-iommu.h | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a38d774..6d3d426 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -427,12 +427,6 @@ static void init_translation_status(struct intel_iommu *iommu)
 		iommu->flags |= VTD_FLAG_TRANS_PRE_ENABLED;
 }
 
-/* Convert generic 'struct iommu_domain to private struct dmar_domain */
-static struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct dmar_domain, domain);
-}
-
 static int __init intel_iommu_setup(char *str)
 {
 	if (!str)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index bc09d80..650cf98 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -585,6 +585,12 @@ static inline void __iommu_flush_cache(
 		clflush_cache_range(addr, size);
 }
 
+/* Convert generic 'struct iommu_domain to private struct dmar_domain */
+static inline struct dmar_domain *to_dmar_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct dmar_domain, domain);
+}
+
 /*
  * 0: readable
  * 1: writable
-- 
2.7.4
