Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C97C18C14
	for <iommu@lists.linux.dev>; Wed, 21 Jun 2023 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687380911; x=1718916911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3e3OFmQg7r8dzQcmVaorP5GcY9XosK0gMzuLCkej4As=;
  b=bbXevibOC2MmWe2vKWp7KdiYDRms4DTcr3Nxv2ZBXu756vqku0SYkYYg
   aSs2bNk++MPN6w03rSomLpdLcFpfC6wd3keOSSg/wfwEuaCEp/TaPpJPe
   GQKBoRMvCjpvzFol9+a1iAD/3YiMOml0B1w8omWhwQTBALGRGkVPGh3yz
   guKAK1Gk9wO6WuC+HfvV5MjqBajV+G261peOjCOTqZuG+Tqiqx5wO7y5F
   FZzPSB4HLUzpTax+w77JlyV9KNYF5+qj7Oz2CTH0EBfin4BYY2LQGERue
   Ltwg6e9okpZTwJsd+fmCkVgaFOO9FObdP5FuTIsEm40PPm4L/M4gBC9Te
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="359168948"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="359168948"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 13:55:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="827597924"
X-IronPort-AV: E=Sophos;i="6.00,261,1681196400"; 
   d="scan'208";a="827597924"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by fmsmga002.fm.intel.com with ESMTP; 21 Jun 2023 13:55:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	"Robin Murphy" <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	dmaengine@vger.kernel.org,
	vkoul@kernel.org
Cc: "Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	rex.zhang@intel.com,
	xiaochen.shen@intel.com,
	narayan.ranganathan@intel.com,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v9 5/7] iommu/vt-d: Make prq draining code generic
Date: Wed, 21 Jun 2023 13:59:45 -0700
Message-Id: <20230621205947.1327094-6-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230621205947.1327094-1-jacob.jun.pan@linux.intel.com>
References: <20230621205947.1327094-1-jacob.jun.pan@linux.intel.com>
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
index 3214990b69b7..8ea656446616 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4740,21 +4740,29 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
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

