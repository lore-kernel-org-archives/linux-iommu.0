Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A2185B72
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684493; cv=none; b=u3mjiuF3dvR3JvMlc8gdPtzLgg7jEVc5gZP7KQoBhLaBe2FHeG8lzIcC3lskRjMAOhQjjKT9IdH2zzFdH90N3iZCRi5WXSZvv9jOCRu8ZWy8rnh6niYNWhFlxgxg5OjnjRFhgY5IwafeEMEcmzMpXUHyLUphqEryvUDifJx9QUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684493; c=relaxed/simple;
	bh=lKbxzYPLOMl2d5uZw3sK2WSdhynpYg32+aQMrm+8LkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RASsjHsQxSBT8UD/WsRhaLcYL+hlxVtCWOqWs64/HEPbnqIkYLwQrru5VecWSwDjpy6JTlu0BZvCR0cIF23m0M9/UOm9mJfFzwZK58FFZr6lrKPBfwItS//QU4Xvhh1cW3ATLb4u31zXONdlGyWgYMLfitkFgRXsmnL9BXE3ygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYfDW90P; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYfDW90P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684492; x=1762220492;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKbxzYPLOMl2d5uZw3sK2WSdhynpYg32+aQMrm+8LkE=;
  b=GYfDW90PA0vvNmhicKZNaEmXa/ViwuiPQW4tjTRCpjke5/Ni3q0/U1Cb
   bQWeqvOxgsbcLdeQ5csSrCi3vzVqMfz2jl2vlBPXygsmuQmKkxeO8br7n
   fhgmcrA+qmUdWfrJrbUe9OcHWUdRT6SJRQWAPrHeCX1p/m6EW4z0ZJAcH
   vCvaWH8jYyT4DLsMxRzT05wEZ259MqdnyI4OdhxWShQNqwun5RYDdeQWR
   oOzmPRNJwSXJktsr8srWrh4VCvM8H0kMFOUjPxcsOO1x9LGl+CS0rXHfV
   SIbJo9yKLM1PspgGUA+YH/CmK6YA41UN4ByB6BFNZC4TEV838AucQiYZs
   Q==;
X-CSE-ConnectionGUID: awuuSRCfSsmiHRtAIuq2DA==
X-CSE-MsgGUID: 20K+AByfR8iX3PLxjHuRiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221927"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221927"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:31 -0800
X-CSE-ConnectionGUID: 1UmceN+XSfuNCE/x+HVB0Q==
X-CSE-MsgGUID: +gu4jeAXSeGn+/SjkQDXbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020883"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/19] iommu/vt-d: Refactor first_level_by_default()
Date: Mon,  4 Nov 2024 09:40:26 +0800
Message-ID: <20241104014040.106100-7-baolu.lu@linux.intel.com>
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

The first stage page table is compatible across host and guest kernels.
Therefore, this driver uses the first stage page table as the default for
paging domains.

The helper first_level_by_default() determines the feasibility of using
the first stage page table based on a global policy. This policy requires
consistency in scalable mode and first stage translation capability among
all iommu units. However, this is unnecessary as domain allocation,
attachment, and removal operations are performed on a per-device basis.

The domain type (IOMMU_DOMAIN_DMA vs. IOMMU_DOMAIN_UNMANAGED) should not
be a factor in determining the first stage page table usage. Both types
are for paging domains, and there's no fundamental difference between them.
The driver should not be aware of this distinction unless the core
specifies allocation flags that require special handling.

Convert first_level_by_default() from global to per-iommu and remove the
'type' input.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20241021085125.192333-7-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f6dc83c26fa5..ebdb97835fc3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1329,18 +1329,17 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
  * Check and return whether first level is used by default for
  * DMA translation.
  */
-static bool first_level_by_default(unsigned int type)
+static bool first_level_by_default(struct intel_iommu *iommu)
 {
 	/* Only SL is available in legacy mode */
-	if (!scalable_mode_support())
+	if (!sm_supported(iommu))
 		return false;
 
 	/* Only level (either FL or SL) is available, just use it */
-	if (intel_cap_flts_sanity() ^ intel_cap_slts_sanity())
-		return intel_cap_flts_sanity();
+	if (ecap_flts(iommu->ecap) ^ ecap_slts(iommu->ecap))
+		return ecap_flts(iommu->ecap);
 
-	/* Both levels are available, decide it based on domain type */
-	return type != IOMMU_DOMAIN_UNMANAGED;
+	return true;
 }
 
 int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
@@ -3110,7 +3109,7 @@ int __init intel_iommu_init(void)
 		 * the virtual and physical IOMMU page-tables.
 		 */
 		if (cap_caching_mode(iommu->cap) &&
-		    !first_level_by_default(IOMMU_DOMAIN_DMA)) {
+		    !first_level_by_default(iommu)) {
 			pr_info_once("IOMMU batching disallowed due to virtualization\n");
 			iommu_set_dma_strict();
 		}
@@ -4361,10 +4360,12 @@ static struct iommu_domain identity_domain = {
 
 static struct iommu_domain *intel_iommu_domain_alloc_paging(struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
 	struct dmar_domain *dmar_domain;
 	bool first_stage;
 
-	first_stage = first_level_by_default(0);
+	first_stage = first_level_by_default(iommu);
 	dmar_domain = paging_domain_alloc(dev, first_stage);
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
-- 
2.43.0

