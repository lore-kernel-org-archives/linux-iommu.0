Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778981CCEC2
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621128; cv=none; b=CgxpTmRrIW8qDarRWv+ayvIOxHFF0OQ3R76eMogedqdmh7bc2VCbsfyJsUepxb8SDEdjVcXfiPp8VR70Ow8ozw4y5CE8U4Iw+CTRu+TwgBqys5LCMbOZZZbn8qnXuJvjqu8wKUBGiu7Ea2byuLzdmKWOp9ONFkIZs3gaD2JPkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621128; c=relaxed/simple;
	bh=Rpe2Bmi9GBIWmSjY0Uca0kWikIc6QccAZcI5FDF+nls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnKDeBNWu7PHBgKnX9I4kELG+5gXJ1bDbPlX/fxe1t/PyBLswQwcfsZ2TTn5BTE98tmIlt6lVtDjDdrxY+S7VODYL3RqQoh6lwN99Ax8/M8TgZofsDbEbAEwbGEGOH3g0EV6CQmuREs7WZ4AiII0/smcp2Ynv9Ch/ucikE/tcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mARAPNSy; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mARAPNSy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621126; x=1760157126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rpe2Bmi9GBIWmSjY0Uca0kWikIc6QccAZcI5FDF+nls=;
  b=mARAPNSy0FaSjyt8QUsw5KxRSBc5u8HOWuTlXCDbLD2LUb+gqaXL2iLs
   RCRYT9xn5fLZ3drlFgALF+1rMUXwSdUxhLLaIUh1fewiAasu1ULXLQIO6
   S6emyprKdVvPwHKEMrBI6m/xA4siMhfjqoLgnaIqtMGN6GVILImfCYwDS
   bCYXb4OOOD+OJGnrXxRzBbbHxcOSk3DSaU5NVz6MGCetTnODgOQGVtd8J
   jeFNB2sE+wnflYNYXoa4PnrxF9DhmhYD6N4s6qn43nYthdlug3JidDcPS
   qUONNB3e+Tme98NgKqDa8la+HBOrIHHa83z3lte+ecAEqFZgef2ecORXG
   g==;
X-CSE-ConnectionGUID: BqxINFxCRl6mvDNccRPibg==
X-CSE-MsgGUID: igu1/wShQ3OqsK0V4jOHaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28101748"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28101748"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:32:06 -0700
X-CSE-ConnectionGUID: 0QQBpIGdRcqM6p603pqOfg==
X-CSE-MsgGUID: uxY3ydzKQaSLHRT688k7Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81412160"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 21:32:04 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/7] iommu/vt-d: Add domain_alloc_paging support
Date: Fri, 11 Oct 2024 12:27:16 +0800
Message-ID: <20241011042722.73930-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241011042722.73930-1-baolu.lu@linux.intel.com>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9f6b0780f2ef..4803e0cb8279 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4590,6 +4590,19 @@ static struct iommu_domain identity_domain = {
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
@@ -4599,6 +4612,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc		= intel_iommu_domain_alloc,
 	.domain_alloc_user	= intel_iommu_domain_alloc_user,
 	.domain_alloc_sva	= intel_svm_domain_alloc,
+	.domain_alloc_paging	= intel_iommu_domain_alloc_paging,
 	.probe_device		= intel_iommu_probe_device,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-- 
2.43.0

