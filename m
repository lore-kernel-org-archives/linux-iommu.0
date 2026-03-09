Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00234F47E
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036603; cv=none; b=ikygZkyNgzE6ZQfVQgNC/AdGYY7ohtbU1+5vU5Mstwx+KCIBAf3sQHCFBqLugsZBvfcsUnE8sPDleLIQYBPX60a4QxuflE5RBqqcSE3tmErp9Iyeb5HavVQvejUHM5bZsmAHvVw1eTEAGHv9M62EKQ67s4qZIvInkbSua1t20+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036603; c=relaxed/simple;
	bh=Ai3mLIr1aMxlF434+33AGSEqNokSCKdS5uiESmB7DFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZHNPIAW57hoozGNoE69stESTM4GZcEeGbNsNHSiodXNQgNtDzzpCgG2NWSiNnf9im8JT4G+KIadeKJmnRPhMTzywaWKsIpPCXa13x0Afiha3peQ1hDjMytHrDdw+Wy7yZuFanwSsabmxe/jlUnQaKr+GwC3MvHtRsM0Ed8mhCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k7x9YSMF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k7x9YSMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773036602; x=1804572602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ai3mLIr1aMxlF434+33AGSEqNokSCKdS5uiESmB7DFg=;
  b=k7x9YSMFf7QzsRfuyQveMSoazyqZAa04y6DHYvHgI2ww4u/Ot2aCFsTh
   P0ZM/lJLQeDuB1BipfCJPusFj/j+ZwcikUhICdKQELgi6e3hUi0pVQXf7
   DkdsqqfsKd+cmsaK4DjePEAdg7DPuDFvYoSC20Q3iY+s6m9ZNTtWyCzvB
   s3RNnyUwOhg8M+JzC/jyk4Xp/uR5TqpjJw53PdEZkW5Sy53J4YoPTRPUz
   KF6Qg4HFVTvndjgtiFh8TTTx6QLaeLSVkwji/FATWsGX+vJ+5d95zKT9J
   P7+d7WPzepJCKN59j1YxbDGUjTXCyjgs44w917RzMfZXSi5JVxgFC0VsZ
   g==;
X-CSE-ConnectionGUID: /l8FUg5mRWmLKQ/WsWKoHQ==
X-CSE-MsgGUID: 4/lCebmVSYCiOUBIbgFLuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73248315"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73248315"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:10:02 -0700
X-CSE-ConnectionGUID: nJm8H1PtToOSmPMBSvrzFQ==
X-CSE-MsgGUID: U1YReGvGR7Wjaas/4vYOEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="245669183"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2026 23:10:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 8/8] iommu/vt-d: Use intel_pasid_write() for nested setup
Date: Mon,  9 Mar 2026 14:06:48 +0800
Message-ID: <20260309060648.276762-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309060648.276762-1-baolu.lu@linux.intel.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor intel_pasid_setup_nested() to utilize the intel_pasid_write()
helper. Move the implementation to the entry_sync infrastructure, where
the nested PASID entry is constructed in a local buffer and committed
via the centralized intel_pasid_write() wrapper.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/nested.c | 13 +------------
 drivers/iommu/intel/pasid.c  | 27 +++++----------------------
 2 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 2b979bec56ce..1cebc1232f70 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -131,17 +131,6 @@ static int intel_nested_cache_invalidate_user(struct iommu_domain *domain,
 	return ret;
 }
 
-static int domain_setup_nested(struct intel_iommu *iommu,
-			       struct dmar_domain *domain,
-			       struct device *dev, ioasid_t pasid,
-			       struct iommu_domain *old)
-{
-	if (old)
-		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
-
-	return intel_pasid_setup_nested(iommu, dev, pasid, domain);
-}
-
 static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 				      struct device *dev, ioasid_t pasid,
 				      struct iommu_domain *old)
@@ -170,7 +159,7 @@ static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_remove_dev_pasid;
 
-	ret = domain_setup_nested(iommu, dmar_domain, dev, pasid, old);
+	ret = intel_pasid_setup_nested(iommu, dev, pasid, dmar_domain);
 	if (ret)
 		goto out_unwind_iopf;
 
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index cb55ff422d7d..5e0548dd8388 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -754,12 +754,8 @@ static void pasid_pte_config_nestd(struct intel_iommu *iommu,
 {
 	struct pt_iommu_vtdss_hw_info pt_info;
 
-	lockdep_assert_held(&iommu->lock);
-
 	pt_iommu_vtdss_hw_info(&s2_domain->sspt, &pt_info);
 
-	pasid_clear_entry(pte);
-
 	if (s1_cfg->addr_width == ADDR_WIDTH_5LEVEL)
 		pasid_set_flpm(pte, 1);
 
@@ -806,7 +802,9 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 	struct iommu_hwpt_vtd_s1 *s1_cfg = &domain->s1_cfg;
 	struct dmar_domain *s2_domain = domain->s2_domain;
 	u16 did = domain_id_iommu(domain, iommu);
-	struct pasid_entry *pte;
+	struct pasid_entry new_pte = {0};
+
+	iommu_group_mutex_assert(dev);
 
 	/* Address width should match the address width supported by hardware */
 	switch (s1_cfg->addr_width) {
@@ -837,23 +835,8 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 		return -EINVAL;
 	}
 
-	spin_lock(&iommu->lock);
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (!pte) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
-	if (pasid_pte_is_present(pte)) {
-		spin_unlock(&iommu->lock);
-		return -EBUSY;
-	}
-
-	pasid_pte_config_nestd(iommu, pte, s1_cfg, s2_domain, did);
-	spin_unlock(&iommu->lock);
-
-	pasid_flush_caches(iommu, pte, pasid, did);
-
-	return 0;
+	pasid_pte_config_nestd(iommu, &new_pte, s1_cfg, s2_domain, did);
+	return intel_pasid_write(iommu, dev, pasid, (u128 *)&new_pte);
 }
 
 /*
-- 
2.43.0

