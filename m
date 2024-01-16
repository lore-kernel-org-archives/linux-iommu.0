Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF5421103
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gj5nO5C7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367591; x=1736903591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=A1Z9gOm8Jc+cnWnmpbIRY+G6Tj+OQyFBnMpzEZ9v7NY=;
  b=Gj5nO5C733T3zyoisgR6jJS6c61kpIIxbJpvwS0F4o1A8MAYFqCfJigM
   h253qpVFVzILhijAWLpzhnSODRCg/xJJsDSxx6vfxNg99EdXbJEfNGFNZ
   9k/ZDNtatY/SeQV3mZ8fxu34oUmvzoKQjqFZxSRYcMCCMB3LlTkUPTMbQ
   hFvz+nnmB5qYIjvnvFXXG3cd/mti+8GWUWMuRCebKKhyE0/o8SsXt6mN5
   6yjvuyQZS0+Gj28ILu2oCBpaRp75rnGq5TmfTUAGqfigfBjXjLwzmC8VL
   UcG/3OiABlkIpS3C0y8yfyZ2aA6fjtj66BvzeXgc9sVXRTOTX0QCtn35C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004460"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004460"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:13:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427402"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427402"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:13:06 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 08/11] iommu/vt-d: Add domain_type_is_sva helper function
Date: Tue, 16 Jan 2024 09:11:43 +0800
Message-Id: <20240116011146.18645-9-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Introduce a helper function to tell if the type of a dmar_domain is sva
or not. In general, comparing with normal iommu_domain, a sva domain
shouldn't be special other than having a different source for the page
table. Thus, this helper function should be used as little as possible
(i.e. only in the cases related to handling page table source).

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/intel/iommu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0eec5d971315..af466ba301b7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -244,6 +244,11 @@ static int domain_type_is_si(struct dmar_domain *domain)
 	return domain->domain.type == IOMMU_DOMAIN_IDENTITY;
 }
 
+static inline bool domain_type_is_sva(struct dmar_domain *domain)
+{
+	return domain->domain.type == IOMMU_DOMAIN_SVA;
+}
+
 static int domain_pfn_supported(struct dmar_domain *domain, unsigned long pfn)
 {
 	int addr_width = agaw_to_width(domain->agaw) - VTD_PAGE_SHIFT;
@@ -4544,7 +4549,7 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	 * notification. Before consolidating that code into iommu core, let
 	 * the intel sva code handle it.
 	 */
-	if (domain->type == IOMMU_DOMAIN_SVA) {
+	if (domain_type_is_sva(dmar_domain)) {
 		intel_svm_remove_dev_pasid(dev, pasid);
 		goto out_tear_down;
 	}
-- 
2.39.3

