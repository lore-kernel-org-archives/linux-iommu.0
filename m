Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437F14F7D
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689179346; x=1720715346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t2kVs6eA1KDEBE5Cn7I5+ASHtTAITwPGEpLC2aVQejM=;
  b=PYxC4S/9o9ryReNCy+QDI/+2VqBIjltwUpik0qEEjqU5od1coJfwfn2i
   eJL0WhQLoijrwIu1Qp2XxRaoZaFMWhlt8ujqX82F5+dJiHCDL4BI+FDaR
   UNiwVTM6AGq9gA4gddYtpbohf1WbMWA0GnPvLE4USX8aqC9sDvWYjUHzb
   K0HGKeV0Cr0NoJ9x/6nfY5PaKYtSiEFo/nbcNibbqYjLR+n5Y4ZE63xMJ
   RAQLvLExm2sN4v5qbvJBbjY8LiCYwz/cc3FyGBWJJcsTD1CVue/E45okX
   gZnQS8PnXserdKT5H19zYxqvZPdHwKxi/9Mde/7+ZrNZsYLM7kJHdoOFI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="431072757"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="431072757"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 09:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="715639039"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="715639039"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga007.jf.intel.com with ESMTP; 12 Jul 2023 09:29:02 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Robin Murphy" <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"Will Deacon" <will@kernel.org>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v10 5/7] iommu/vt-d: Make prq draining code generic
Date: Wed, 12 Jul 2023 09:33:53 -0700
Message-Id: <20230712163355.3177511-6-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

Currently draining page requests and responses for a pasid is part of SVA
implementation. This is because the driver only supports attaching an SVA
domain to a device pasid. As we are about to support attaching other types
of domains to a device pasid, the prq draining code becomes generic.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 30 +++++++++++++++++++-----------
 drivers/iommu/intel/iommu.h |  2 ++
 drivers/iommu/intel/svm.c   |  8 ++------
 3 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 40685cbfaf0e..4b54a56831b4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4733,21 +4733,29 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct iommu_domain *domain;
 
-	/* Domain type specific cleanup: */
 	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
-	if (domain) {
-		switch (domain->type) {
-		case IOMMU_DOMAIN_SVA:
-			intel_svm_remove_dev_pasid(dev, pasid);
-			break;
-		default:
-			/* should never reach here */
-			WARN_ON(1);
-			break;
-		}
+	if (!domain)
+		goto out_tear_down;
+
+	/*
+	 * The SVA implementation needs to handle its own stuffs like the mm
+	 * notification. Before consolidating that code into iommu core, let
+	 * the intel sva code handle it.
+	 */
+	if (domain->type == IOMMU_DOMAIN_SVA) {
+		intel_svm_remove_dev_pasid(dev, pasid);
+		goto out_tear_down;
 	}
 
+	/*
+	 * Should never reach here until we add support for attaching
+	 * non-SVA domain to a pasid.
+	 */
+	WARN_ON(1);
+
+out_tear_down:
 	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+	intel_drain_pasid_prq(dev, pasid);
 }
 
 const struct iommu_ops intel_iommu_ops = {
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1c5e1d88862b..6d94a29f5d52 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -844,6 +844,7 @@ int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(void);
 void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+void intel_drain_pasid_prq(struct device *dev, u32 pasid);
 
 struct intel_svm_dev {
 	struct list_head list;
@@ -862,6 +863,7 @@ struct intel_svm {
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
+static inline void intel_drain_pasid_prq(struct device *dev, u32 pasid) {}
 static inline struct iommu_domain *intel_svm_domain_alloc(void)
 {
 	return NULL;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2a82864e9d57..588367a9e9b5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -26,8 +26,6 @@
 #include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
-static void intel_svm_drain_prq(struct device *dev, u32 pasid);
-#define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
 
 static DEFINE_XARRAY_ALLOC(pasid_private_array);
 static int pasid_private_add(ioasid_t pasid, void *priv)
@@ -391,8 +389,6 @@ void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 		 * large and has to be physically contiguous. So it's
 		 * hard to be as defensive as we might like.
 		 */
-		intel_pasid_tear_down_entry(iommu, dev, svm->pasid, false);
-		intel_svm_drain_prq(dev, svm->pasid);
 		kfree_rcu(sdev, rcu);
 
 		if (list_empty(&svm->devs)) {
@@ -449,7 +445,7 @@ static bool is_canonical_address(u64 addr)
 }
 
 /**
- * intel_svm_drain_prq - Drain page requests and responses for a pasid
+ * intel_drain_pasid_prq - Drain page requests and responses for a pasid
  * @dev: target device
  * @pasid: pasid for draining
  *
@@ -463,7 +459,7 @@ static bool is_canonical_address(u64 addr)
  * described in VT-d spec CH7.10 to drain all page requests and page
  * responses pending in the hardware.
  */
-static void intel_svm_drain_prq(struct device *dev, u32 pasid)
+void intel_drain_pasid_prq(struct device *dev, u32 pasid)
 {
 	struct device_domain_info *info;
 	struct dmar_domain *domain;
-- 
2.25.1

