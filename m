Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8B620DC3
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hcb+1ql1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367577; x=1736903577;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tbu9HezXpGU4umvxCdb1cTrlTz/I/hFBPmKfJKmWj+I=;
  b=Hcb+1ql1KQTwCxUTIMngquXbAT0XEbDHQk5Aqa0ViGpvlNz27q5AxbQ9
   QfXpx5cZoCnu15zBXbqdmLydLkE80NqbOZ2V4yr2B5wClgIn8AJ4TYp58
   W7St54E015GoFnYrpY9vZAPrnpHkMIgHIsfjaCFuuSrDKko8nVJwB6OWR
   DPueNbpfwjfpMOLfnF9p8zUSWtvcW2ZHcm1JOW/4Aydydhw6w88zgs5xc
   6HtjaBuHEKYSmrxpBGAfz/cICFQF2qNBfih0AIX+1UCLmodjydI93G0V1
   WkLJ3Q+M1vIkfr1a6tjm5K9IBBtZQxwodaLDNwBrzr5o+qlh0WF6DBGjn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004391"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004391"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:12:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427238"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427238"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:12:55 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 03/11] iommu/vt-d: Refactor intel_svm_set_dev_pasid function
Date: Tue, 16 Jan 2024 09:11:38 +0800
Message-Id: <20240116011146.18645-4-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Refactor intel_svm_set_dev_pasid() by moving the logic from
intel_svm_bind_mm() into intel_svm_set_dev_pasid() and retire
intel_svm_bind_mm(). No functional change intended.

The motivation is to enable intel_iommu_set_dev_pasid() to serve for both
sva domain's and default domain's set_dev_pasid operations, instead of
duplicating code for them.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/svm.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 1a72b684baea..5b1331b174df 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -314,10 +314,11 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	return 0;
 }
 
-static int intel_svm_bind_mm(struct intel_iommu *iommu, struct device *dev,
-			     struct iommu_domain *domain, ioasid_t pasid)
+static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
 	struct mm_struct *mm = domain->mm;
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
@@ -794,15 +795,6 @@ int intel_svm_page_response(struct device *dev,
 	return ret;
 }
 
-static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
-				   struct device *dev, ioasid_t pasid)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
-
-	return intel_svm_bind_mm(iommu, dev, domain, pasid);
-}
-
 static void intel_svm_domain_free(struct iommu_domain *domain)
 {
 	kfree(to_dmar_domain(domain));
-- 
2.39.3

