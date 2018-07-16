From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 05/10] iommu/vt-d: Setup pasid entry for RID2PASID support
Date: Mon, 16 Jul 2018 14:49:48 +0800
Message-ID: <1531723793-14607-6-git-send-email-baolu.lu@linux.intel.com>
References: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531723793-14607-1-git-send-email-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

when the scalable mode is enabled, there is no second level
page translation pointer in the context entry any more (for
DMA request without PASID). Instead, a new RID2PASID field
is introduced in the context entry. Software can choose any
PASID value to set RID2PASID and then setup the translation
in the corresponding PASID entry. Upon receiving a DMA request
without PASID, hardware will firstly look at this RID2PASID
field and then treat this request as a request with a pasid
value specified in RID2PASID field.

Though software is allowed to use any PASID for the RID2PASID,
we will always use the PASID 0 as a sort of design decision.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 drivers/iommu/intel-iommu.c | 10 ++++++++++
 drivers/iommu/intel-pasid.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a139a45..62e9579 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2421,12 +2421,22 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		dev->archdata.iommu = info;
 
 	if (dev && dev_is_pci(dev) && sm_supported(iommu)) {
+		bool pass_through;
+
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
 			__dmar_remove_one_dev_info(info);
 			spin_unlock_irqrestore(&device_domain_lock, flags);
 			return NULL;
 		}
+
+		/* Setup the PASID entry for requests without PASID: */
+		pass_through = hw_pass_through && domain_type_is_si(domain);
+		spin_lock(&iommu->lock);
+		intel_pasid_setup_second_level(iommu, domain, dev,
+					       PASID_RID2PASID,
+					       pass_through);
+		spin_unlock(&iommu->lock);
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
 
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 2fe40ff..80fc88e 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -10,6 +10,7 @@
 #ifndef __INTEL_PASID_H
 #define __INTEL_PASID_H
 
+#define PASID_RID2PASID			0x0
 #define PASID_MIN			0x1
 #define PASID_MAX			0x100000
 #define PASID_PTE_MASK			0x3F
-- 
2.7.4
