Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5610EDE
	for <iommu@lists.linux.dev>; Fri, 27 Oct 2023 00:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enaESdaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698365166; x=1729901166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KhGsLPqcLdYBHRjixMBCo4I5kFXzGXLaiyOCHceWDKU=;
  b=enaESdaq4h19WcflcBrvkIyyC06eWdq/KTdayG6nmcoWNv+IlT2q5DTk
   tRyTkNRPRb+d+c2Y/KKAWludXT2zBHaoTdFMHVoGyiHcz66lwJemKlu1d
   Fp5vXDANUqIWmGZMYIghGdUfqRlX2X+rdusPnEmlGyOlIMbwUHANOT1OH
   hwMrvdlgmf5ci1LjgD0KPQ674C+DnpzOi0gnRuAftTYD5pfUFGXWqkj6J
   0s2xijrKnV5qpO/64XylqXPAxusd9c67rGjadGkqVnn+LmxW9qkF2dGq9
   Rq0Jd0k+5/HbTap+dx/NUDvLaeawcOGfMULZ04gAzNhI1vVuxUwwuxrOA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="390535942"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="390535942"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 17:06:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="883017483"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="883017483"
Received: from sqa-gate.sh.intel.com (HELO spr-2s5.tsp.org) ([10.239.48.212])
  by orsmga004.jf.intel.com with ESMTP; 26 Oct 2023 17:06:03 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Tina Zhang <tina.zhang@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v10 2/6] iommu/vt-d: Remove mm->pasid in intel_sva_bind_mm()
Date: Fri, 27 Oct 2023 08:05:21 +0800
Message-Id: <20231027000525.1278806-3-tina.zhang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231027000525.1278806-1-tina.zhang@intel.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pasid is passed in as a parameter through .set_dev_pasid() callback.
Thus, intel_sva_bind_mm() can directly use it instead of retrieving the
pasid value from mm->pasid.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/intel/svm.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 50a481c895b8..3c531af58658 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -290,21 +290,22 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 }
 
 static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
-			     struct mm_struct *mm)
+			     struct iommu_domain *domain, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct mm_struct *mm = domain->mm;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
 	unsigned long sflags;
 	int ret = 0;
 
-	svm = pasid_private_find(mm->pasid);
+	svm = pasid_private_find(pasid);
 	if (!svm) {
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm)
 			return -ENOMEM;
 
-		svm->pasid = mm->pasid;
+		svm->pasid = pasid;
 		svm->mm = mm;
 		INIT_LIST_HEAD_RCU(&svm->devs);
 
@@ -342,7 +343,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
+	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, pasid,
 					    FLPT_DEFAULT_DID, sflags);
 	if (ret)
 		goto free_sdev;
@@ -356,7 +357,7 @@ static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
 free_svm:
 	if (list_empty(&svm->devs)) {
 		mmu_notifier_unregister(&svm->notifier, mm);
-		pasid_private_remove(mm->pasid);
+		pasid_private_remove(pasid);
 		kfree(svm);
 	}
 
@@ -796,9 +797,8 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
-	struct mm_struct *mm = domain->mm;
 
-	return intel_svm_bind_mm(iommu, dev, mm);
+	return intel_svm_bind_mm(iommu, dev, domain, pasid);
 }
 
 static void intel_svm_domain_free(struct iommu_domain *domain)
-- 
2.39.3

