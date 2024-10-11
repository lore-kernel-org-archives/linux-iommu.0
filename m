Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9C1F4FDC
	for <iommu@lists.linux.dev>; Fri, 11 Oct 2024 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728621141; cv=none; b=df8rdSQZeurUQChdiG6tkqBNnXJ2qsLx0gdN9ci72QN8I34r5V1/KGTA28jUuorUN92X0kyQ95XgmJF0qbJC8HKoVIWGbjoy+5seOfR80fBTFwOaR1KqU6KpKQC7HNtxp9Xc0ClKShN2to+fALN469XCaY3vcUCK+KiwVaAA/fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728621141; c=relaxed/simple;
	bh=YNDUXwNx4J5Jdea8H7AkuKogV4bRGnlfdSAj8fhW6Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svSP/Lrwd+JEJit7Jrsy7OhiX8M/feYbibfe0f5SGptzzh2ATpJKexM9gpQzKEVYPITf4itDBd0odZUyZKtXNU1Qn4vwEAMJNdF4LTfASJLtZH/C+N8H61jnlMMpieTfU7LHlCgywyf2tWYUIw8LbzMGpxkA3IykfLHnJQYPVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyZW5ZQ5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyZW5ZQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728621140; x=1760157140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YNDUXwNx4J5Jdea8H7AkuKogV4bRGnlfdSAj8fhW6Yg=;
  b=kyZW5ZQ5mTM7PWJUdnt7INFWUf468X/0s0cBLeozQ9Zg9EVFsI4JAiBK
   gG078Ai0PjgPEMz3I5VfPPJRJv/b0Y5N0fMv01hlZXa6w05zAbek4QbQi
   Xgfwg5fxkF2wx+u4apXnWxHsT418H22iSrys18RTM4IonN3z2/CTt9FaG
   W/fEzT33CcyxJ6wOkTQfgOLtEIcNiLqs8A1bEthjEeJl0QMc3E6OmtJQJ
   xS6+0iwnq9pJ82945ZPaLG8UKxzvvL3AVR4S58K3eCOM5zdna3BUjYQkf
   nWlmGJMFhZFZo61HY4KiT2wJ5KlspmmBsQVEBFqY7x+8YziJqO0jELdk3
   g==;
X-CSE-ConnectionGUID: Owp7TielT4KP4yaR5M5GXA==
X-CSE-MsgGUID: MsvCd/LBSs2i5211qcZJ/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="28101812"
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="28101812"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 21:32:19 -0700
X-CSE-ConnectionGUID: 7dBVpkP7Say/Aftp8p6l0A==
X-CSE-MsgGUID: tIquPaqwTZykQ2mxHyXTyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,194,1725346800"; 
   d="scan'208";a="81412242"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 10 Oct 2024 21:32:16 -0700
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
Subject: [PATCH 6/7] iommu/vt-d: Refactor first_level_by_default()
Date: Fri, 11 Oct 2024 12:27:21 +0800
Message-ID: <20241011042722.73930-7-baolu.lu@linux.intel.com>
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
---
 drivers/iommu/intel/iommu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 29b53d955022..70f3cbcc3160 100644
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
@@ -4359,10 +4358,12 @@ static struct iommu_domain identity_domain = {
 
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

