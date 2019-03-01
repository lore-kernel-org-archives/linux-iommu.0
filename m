From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Set context field after value initialized
Date: Fri,  1 Mar 2019 11:23:11 +0800
Message-ID: <20190301032313.9311-3-baolu.lu@linux.intel.com>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Otherwise, the translation type field of a context entry for
a PCI device will always be 0. All translated DMA requests
will be blocked by IOMMU. As the result, the PCI devices with
PCI ATS (device IOTBL) support won't work as expected.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Fixes: 7373a8cc38197 ("iommu/vt-d: Setup context and enable RID2PASID support")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index abdd165a829c..c968b3c7bae0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2056,7 +2056,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 		int agaw;
 
 		context_set_domain_id(context, did);
-		context_set_translation_type(context, translation);
 
 		if (translation != CONTEXT_TT_PASS_THROUGH) {
 			/*
@@ -2086,6 +2085,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			 */
 			context_set_address_width(context, iommu->msagaw);
 		}
+
+		context_set_translation_type(context, translation);
 	}
 
 	context_set_fault_enable(context);
-- 
2.17.1
