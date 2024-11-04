Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B55A1632CF
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684488; cv=none; b=YW1D6jrjZ4pHo6b93Ov0ViLgWXX2G/paAgh68RsLt5aCyCHyCJ8sKidOO6LQlsUps9jGvSreE3GMupfxt5EkwvoKQPVcKOu/DK1nHQPLVBj9In7pVR2Oq4IOu8CpslfIG9fCmgWkZS8W/eHz39VaAnoAZSLrqhF/MLUfPG1F+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684488; c=relaxed/simple;
	bh=F4PiXrrHRs83hqLk8G5Kmrjc2FLr4/K/QLXASX7YGS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bInHiw4MroILZFJRs+yOf14FM7ufp/1JaFuqtGuKrQatR4auxJq/KNivPZCtMVxA54v2x54uBMAzMB49alY9x2NaKBjs31mUcb81NvIQtIGql2tyaXuiREoFGhzqaAwvIvdmmOxZrmQ/OrLdJSvy5JIHegJ9mcVAGY3ltSzlENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARrYjA0J; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARrYjA0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684487; x=1762220487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F4PiXrrHRs83hqLk8G5Kmrjc2FLr4/K/QLXASX7YGS0=;
  b=ARrYjA0JgeF3OGaoNYzDfJ0foqi75LJqQnRwHaunBUFIFu9CJNsmvLGg
   5xTTLlFVKHO4UsrahPkubcXGH0h8uDCptHZWUEucIC7NFSySVmFzfbj2R
   aPZG80PUqgQjz3K+xRJA2cmASyA5CH8dmRUpDkomoIA2W0Sjn8MvR8+/b
   w//l/GO0vAvfuSGiE4cxm1Pg20AyS55QS3wNbEhYNiJEoiYgA03FMAOWV
   yB/LGBD7H5wRUBl1Nx2QAXJNBAxqpM+ejySHLjoEKqmodg2c/bjR3lzL6
   XoPunZcl7D4WhHlwTmj2IjBlP7wO8Nu5UQ2xmPFJGa/OV+Ee8eMXx8U38
   w==;
X-CSE-ConnectionGUID: XKbxCEuGROGDEoXjy5wDVQ==
X-CSE-MsgGUID: ZQesxNJVR+SOt+2F4EXUFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221912"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221912"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:25 -0800
X-CSE-ConnectionGUID: +FP2PK/tRW6vVYf9UeBlGg==
X-CSE-MsgGUID: SgqaaoxsRnSdJJTA9qn+yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020869"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:24 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/19] iommu/vt-d: Add domain_alloc_paging support
Date: Mon,  4 Nov 2024 09:40:21 +0800
Message-ID: <20241104014040.106100-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the domain_alloc_paging callback for domain allocation using the
iommu_paging_domain_alloc() interface.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20241021085125.192333-2-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index e860bc9439a2..0d2237b55b6b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4592,6 +4592,19 @@ static struct iommu_domain identity_domain = {
 	},
 };
 
+static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
+{
+	struct dmar_domain *dmar_domain;
+	bool first_stage;
+
+	first_stage = first_level_by_default(0);
+	dmar_domain = paging_domain_alloc(dev, first_stage);
+	if (IS_ERR(dmar_domain))
+		return ERR_CAST(dmar_domain);
+
+	return &dmar_domain->domain;
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
 	.release_domain		= &blocking_domain,
@@ -4601,6 +4614,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_sva	= intel_svm_domain_alloc,
+	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
 	.probe_device		= intel_iommu_probe_device,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-- 
2.43.0

