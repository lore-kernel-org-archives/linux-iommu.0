Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBDF3D47A9
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780553133; cv=none; b=bRBQPrceWOxwDZCIuc2QF5VbOwqC0T0xO+f8Q3ndOfWS8srWKcN8CptbUmD89y/wDLMtv69bBGjFIWRW2infHsrSA1x7NbsQICYq5EnyCJpVIm2v5aQNAODroLrxXQpOeh4IMnHlqyixQuQlbNh887OEgzH4bYw35swFoufHMhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780553133; c=relaxed/simple;
	bh=xm53TpFRrN5dL4C2+v5j9/m5g0/qjhftnOUG7WU1TT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLzxraQfzZ+4h/nXEaRoj1A2yOa2w8WABr3oRtEGmQZoi1JSYMOTY8ej87Y0us9fzMB4AgKb86znyhJczMVZix5f83+IjIKEVmRn+oLuxYgFWiVeyCB2PXNrEeDqnRYh1p/k2tmTt22K/X8eHnjWQKZw0IH1Y/8Gbh7/mj9mNEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fS03G2si; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fS03G2si"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780553133; x=1812089133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xm53TpFRrN5dL4C2+v5j9/m5g0/qjhftnOUG7WU1TT0=;
  b=fS03G2siZgLsyc7656MI6LqMxeiyJQAp3UsumPmkVy4ADjJWOxKnFEfh
   NcywFl6E369NH34OAJ5yQPjdKiUBsIQ0tFXplgrVoS1q3twI4H1BL4BmO
   4vIG6ybICQi6TeTNRPX5uPPIQCixT7BXkuwCrSNHJzn2lmdJ6zoHwiSvV
   938KQBziW9gXvBLhLA2hr4noQqCV2TGcqJBWRb2iFGvU7MkdKHvE2jwkP
   PCbpt+WQhCEtlgWVLnVv7WSp4w7oiFYSqV2UuxRdD2H/GxebgF8FAZbzt
   e3LQzCplrGKhIopexgL1D7yaZ7qZgoYUSW5hK9qvSZ+pDa9fCXslS9uCD
   w==;
X-CSE-ConnectionGUID: bpsZlhpxS36CNF3mb+hkTQ==
X-CSE-MsgGUID: HGfL54JXSEGPgdCD+8m1nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81554235"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81554235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:05:33 -0700
X-CSE-ConnectionGUID: Ku4LxLOlS2CqEfM8umyqIA==
X-CSE-MsgGUID: IKkWEaOhRt2uftN5QLxqWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="268112151"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2026 23:05:30 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Pranjal Shrivastava <praan@google.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] iommu/vt-d: Avoid WARNING in sva unbind path
Date: Thu,  4 Jun 2026 14:03:06 +0800
Message-ID: <20260604060311.365074-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604060311.365074-1-baolu.lu@linux.intel.com>
References: <20260604060311.365074-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel IOMMU driver allows SVA on devices even if they do not support
PCI/PRI. Commit 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when
PRI is supported") modified the SVA bind path to allow this configuration
by skipping IOPF enablement when PRI is missing. However, it failed to
update the unbind path.

This creates an imbalance: the unbind path attempts to disable IOPF for
a device that never had it enabled, triggering a WARNING in
intel_iommu_disable_iopf():

 WARNING: drivers/iommu/intel/iommu.c:3475 at intel_iommu_disable_iopf+0x4f/0x90d
 Call Trace:
  <TASK>
  blocking_domain_set_dev_pasid+0x50/0x70
  iommu_detach_device_pasid+0x89/0xc0
  iommu_sva_unbind_device+0x73/0x150
  xe_vm_close_and_put+0x4d2/0x1200 [xe]

Fix this by bypassing IOPF operations for SVA domains on non-PRI hardware
in both the bind and unbind paths.

Fixes: 39c20c4e83b9 ("iommu/vt-d: Only handle IOPF for SVA when PRI is supported")
Cc: stable@vger.kernel.org
Reported-by: Nareshkumar Gollakoti <naresh.kumar.g@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260519052917.3729796-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 11 +++++++++++
 drivers/iommu/intel/svm.c   | 12 ++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ef145560aa98..775f1c4ae346 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1254,18 +1254,29 @@ void intel_iommu_disable_iopf(struct device *dev);
 static inline int iopf_for_domain_set(struct iommu_domain *domain,
 				      struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
 	if (!domain || !domain->iopf_handler)
 		return 0;
 
+	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
+	if (domain->type == IOMMU_DOMAIN_SVA && !info->pri_supported)
+		return 0;
+
 	return intel_iommu_enable_iopf(dev);
 }
 
 static inline void iopf_for_domain_remove(struct iommu_domain *domain,
 					  struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+
 	if (!domain || !domain->iopf_handler)
 		return;
 
+	if (domain->type == IOMMU_DOMAIN_SVA && !info->pri_supported)
+		return;
+
 	intel_iommu_disable_iopf(dev);
 }
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 57cd1db7207a..fea10acd4f02 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -164,12 +164,9 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	if (IS_ERR(dev_pasid))
 		return PTR_ERR(dev_pasid);
 
-	/* SVA with non-IOMMU/PRI IOPF handling is allowed. */
-	if (info->pri_supported) {
-		ret = iopf_for_domain_replace(domain, old, dev);
-		if (ret)
-			goto out_remove_dev_pasid;
-	}
+	ret = iopf_for_domain_replace(domain, old, dev);
+	if (ret)
+		goto out_remove_dev_pasid;
 
 	/* Setup the pasid table: */
 	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
@@ -184,8 +181,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 
 	return 0;
 out_unwind_iopf:
-	if (info->pri_supported)
-		iopf_for_domain_replace(old, domain, dev);
+	iopf_for_domain_replace(old, domain, dev);
 out_remove_dev_pasid:
 	domain_remove_dev_pasid(domain, dev, pasid);
 	return ret;
-- 
2.43.0

