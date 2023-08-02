Received: from mgamail.intel.com (unknown [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A7125AB
	for <iommu@lists.linux.dev>; Wed,  2 Aug 2023 21:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691011166; x=1722547166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tvap/bP4frIrjwhw5ezK85sfojLa+kIMDMriKn0x2mM=;
  b=TYATSVcbHfLccd2HO9SB8rSGt0o2FAOGBJH6rMvPM+0O3OEcjpYXroeL
   N7Q2eTr7IG0tex8KZ/lrrbBQC16evlNMZE7g4UCPcNIZMqSFJsUdkyL6X
   PNXUIdFYDH8VJf8/RmVkGa7770374jovB0BHP3RKAukQa6wK/KixdRmSm
   5ygtAccA+NCoYTkZ23pHozdqVG8UYPiIVys8Izoguz68/ocKIDCi3Dkx2
   nZWICA7MksFaFMnd+FCO6fbDiWOlG1P8QYd3Z92XvXqIko7KHurRjYtiJ
   oUN01r6E3JqcqVLtozy9hINQEKcRmW4Ig5+gUTAIj5Km0J/0rv+USsywb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372436156"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372436156"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729290787"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="729290787"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 14:19:22 -0700
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
Subject: [PATCH v12 4/8] iommu/vt-d: Remove pasid_mutex
Date: Wed,  2 Aug 2023 14:24:23 -0700
Message-Id: <20230802212427.1497170-5-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
References: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Baolu <baolu.lu@linux.intel.com>

The pasid_mutex was used to protect the paths of set/remove_dev_pasid().
It's duplicate with iommu_sva_lock. Remove it to avoid duplicate code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/svm.c | 45 +++++----------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index e95b339e9cdc..2a82864e9d57 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -259,8 +259,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.invalidate_range = intel_invalidate_range,
 };
 
-static DEFINE_MUTEX(pasid_mutex);
-
 static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 			     struct intel_svm **rsvm,
 			     struct intel_svm_dev **rsdev)
@@ -268,10 +266,6 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	struct intel_svm_dev *sdev = NULL;
 	struct intel_svm *svm;
 
-	/* The caller should hold the pasid_mutex lock */
-	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
-		return -EINVAL;
-
 	if (pasid == IOMMU_PASID_INVALID || pasid >= PASID_MAX)
 		return -EINVAL;
 
@@ -371,22 +365,19 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 	return ret;
 }
 
-/* Caller must hold pasid_mutex */
-static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
+void intel_svm_remove_dev_pasid(struct device *dev, u32 pasid)
 {
 	struct intel_svm_dev *sdev;
 	struct intel_iommu *iommu;
 	struct intel_svm *svm;
 	struct mm_struct *mm;
-	int ret = -EINVAL;
 
 	iommu = device_to_iommu(dev, NULL, NULL);
 	if (!iommu)
-		goto out;
+		return;
 
-	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
-	if (ret)
-		goto out;
+	if (pasid_to_svm_sdev(dev, pasid, &svm, &sdev))
+		return;
 	mm = svm->mm;
 
 	if (sdev) {
@@ -418,8 +409,6 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
 			kfree(svm);
 		}
 	}
-out:
-	return ret;
 }
 
 /* Page request queue descriptor */
@@ -520,19 +509,7 @@ static void intel_svm_drain_prq(struct device *dev, u32 pasid)
 		goto prq_retry;
 	}
 
-	/*
-	 * A work in IO page fault workqueue may try to lock pasid_mutex now.
-	 * Holding pasid_mutex while waiting in iopf_queue_flush_dev() for
-	 * all works in the workqueue to finish may cause deadlock.
-	 *
-	 * It's unnecessary to hold pasid_mutex in iopf_queue_flush_dev().
-	 * Unlock it to allow the works to be handled while waiting for
-	 * them to finish.
-	 */
-	lockdep_assert_held(&pasid_mutex);
-	mutex_unlock(&pasid_mutex);
 	iopf_queue_flush_dev(dev);
-	mutex_lock(&pasid_mutex);
 
 	/*
 	 * Perform steps described in VT-d spec CH7.10 to drain page
@@ -827,26 +804,14 @@ int intel_svm_page_response(struct device *dev,
 	return ret;
 }
 
-void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
-{
-	mutex_lock(&pasid_mutex);
-	intel_svm_unbind_mm(dev, pasid);
-	mutex_unlock(&pasid_mutex);
-}
-
 static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
-	int ret;
 
-	mutex_lock(&pasid_mutex);
-	ret = intel_svm_bind_mm(iommu, dev, mm);
-	mutex_unlock(&pasid_mutex);
-
-	return ret;
+	return intel_svm_bind_mm(iommu, dev, mm);
 }
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
-- 
2.25.1

