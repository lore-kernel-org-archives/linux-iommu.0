From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH] iommu: Correct iommu_map / iommu_unmap prototypes
Date: Wed,  5 Jul 2017 20:27:53 +0300
Message-ID: <20170705172753.24701-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Commit 7d3002cc8c16 ("iommu/core: split mapping to page sizes as supported
by the hardware") replaced 'int gfp_order' with a 'size_t size' of
iommu_map / iommu_unmap function arguments, but missed the function
prototypes for the disabled CONFIG_IOMMU_API case, let's correct them
for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/iommu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54adc4a33..f1ce8e517d8d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -425,13 +425,13 @@ static inline struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 }
 
 static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
-			    phys_addr_t paddr, int gfp_order, int prot)
+			    phys_addr_t paddr, size_t size, int prot)
 {
 	return -ENODEV;
 }
 
 static inline int iommu_unmap(struct iommu_domain *domain, unsigned long iova,
-			      int gfp_order)
+			      size_t size)
 {
 	return -ENODEV;
 }
-- 
2.13.2
