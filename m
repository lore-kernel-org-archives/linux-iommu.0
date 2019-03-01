From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/4] iommu/vt-d: Get domain ID before clear pasid entry
Date: Fri,  1 Mar 2019 11:23:13 +0800
Message-ID: <20190301032313.9311-5-baolu.lu@linux.intel.com>
References: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301032313.9311-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

After tearing down a pasid entry, the domain id is used to
invalidate the translation caches. Retrieve the domain id
from the pasid entry value before clearing the pasid entry.
Otherwise, we will always use domain id 0.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Fixes: 6f7db75e1c469 ("iommu/vt-d: Add second level page table interface")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-pasid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 53fe5248d8f1..03b12d2ee213 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -466,8 +466,8 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 	if (WARN_ON(!pte))
 		return;
 
-	intel_pasid_clear_entry(dev, pasid);
 	did = pasid_get_domain_id(pte);
+	intel_pasid_clear_entry(dev, pasid);
 
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
-- 
2.17.1
