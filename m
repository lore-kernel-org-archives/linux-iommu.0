From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 16/18] iommu: add max num of cache and granu types
Date: Mon,  8 Apr 2019 16:59:31 -0700
Message-ID: <1554767973-30125-17-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 9344cbb..59569d6 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -197,6 +197,7 @@ struct iommu_inv_addr_info {
 	__u64	granule_size;
 	__u64	nb_granules;
 };
+#define NR_IOMMU_CACHE_INVAL_GRANU	(3)
 
 /**
  * First level/stage invalidation information
@@ -228,6 +229,7 @@ struct iommu_cache_invalidate_info {
 		struct iommu_inv_addr_info addr_info;
 	};
 };
+#define NR_IOMMU_CACHE_TYPE		(3)
 /**
  * struct gpasid_bind_data - Information about device and guest PASID binding
  * @gcr3:	Guest CR3 value from guest mm
-- 
2.7.4
