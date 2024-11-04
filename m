Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A73217D36A
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684492; cv=none; b=ANHLs7KUbFiSmrEe+NJDMxtOuqlnoH/avi7fMEFzMXGMlbdXelw6WTV6EavNT6ddJa1ctDiobU/lE1uB72J6F2f8aJ9i3Z9ZCmXFdDl67PSIKuT3kFCl5x3ky5Zv1KjgmRMr/P78PpallthDg8dOzgwGztEH5KHOmBmy+I8/7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684492; c=relaxed/simple;
	bh=5ikrJYE2v63GTuWmc304uEtArJ9WsMTRZafX88ViieY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC5x//+X4aqvT8XvxuvqwK+Kh3MKPO8F3/qr0VvqmFHqs4/JgKNp+LrECgkoyOhSKnQgYc1/r8U4a2ygtTV1ORd/qhgFd0IVTQBWAsurt8Gcl9klmPn2UhUsAgy3QMu1+wsdZ6KW91Hkr/nTpFo8Cwa51yv7KaTplOdZaN512hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E0Zt5msR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E0Zt5msR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684491; x=1762220491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ikrJYE2v63GTuWmc304uEtArJ9WsMTRZafX88ViieY=;
  b=E0Zt5msRqy/bBVVUp1UDu9tMvhIrCtEhBHBitFT77JBdbv7Cx1WD1umg
   +HjWQTCooKTfc761rnr2BkKNQ2PHGF7l/SW8Q/X67DTl/pPG0SrIUkwJ0
   kBUKgp3Xdnb7NX0hPnjSuJefdfyAdmZuuGm94ZIdV4xTaRdTAYiEMhlIa
   4hxMQPS5yKPAX81lWAEd6CLCSi3I0TRCZffdet0Ofd9G+u6m9lwRvaLop
   7PzPHkxblN18M48eZyDUZK1U5e2kvo3yFVPNlHQESITrKcmjopBdhpewq
   oRab9cBaLLceKGsI9H1x6DeW+h9iaedOUzV/1Fx9MPXm2cp1fDTTy7tMa
   Q==;
X-CSE-ConnectionGUID: vFYWsJzuSp2qZqD9/0kc9g==
X-CSE-MsgGUID: oYqXusdVT+K1oATHx5NR3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221924"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221924"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:30 -0800
X-CSE-ConnectionGUID: RzDLdfinTGivi1W9WHPObg==
X-CSE-MsgGUID: HRG+D7AiT3iW6JgkzSoLMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020881"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:29 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/19] iommu/vt-d: Remove domain_update_iommu_superpage()
Date: Mon,  4 Nov 2024 09:40:25 +0800
Message-ID: <20241104014040.106100-6-baolu.lu@linux.intel.com>
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

The requirement for consistent super page support across all the IOMMU
hardware in the system has been removed. In the past, if a new IOMMU
was hot-added and lacked consistent super page capability, the hot-add
process would be aborted. However, with the updated attachment semantics,
it is now permissible for the super page capability to vary among
different IOMMU hardware units.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20241021085125.192333-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 39 +------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d148274e7135..f6dc83c26fa5 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -352,36 +352,6 @@ static bool iommu_paging_structure_coherency(struct intel_iommu *iommu)
 			ecap_smpwc(iommu->ecap) : ecap_coherent(iommu->ecap);
 }
 
-static int domain_update_iommu_superpage(struct dmar_domain *domain,
-					 struct intel_iommu *skip)
-{
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
-	int mask = 0x3;
-
-	if (!intel_iommu_superpage)
-		return 0;
-
-	/* set iommu_superpage to the smallest common denominator */
-	rcu_read_lock();
-	for_each_active_iommu(iommu, drhd) {
-		if (iommu != skip) {
-			if (domain && domain->use_first_level) {
-				if (!cap_fl1gp_support(iommu->cap))
-					mask = 0x1;
-			} else {
-				mask &= cap_super_page_val(iommu->cap);
-			}
-
-			if (!mask)
-				break;
-		}
-	}
-	rcu_read_unlock();
-
-	return fls(mask);
-}
-
 /* Return the super pagesize bitmap if supported. */
 static unsigned long domain_super_pgsize_bitmap(struct dmar_domain *domain)
 {
@@ -2605,20 +2575,13 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
 
 static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 {
-	int sp, ret;
 	struct intel_iommu *iommu = dmaru->iommu;
+	int ret;
 
 	ret = intel_cap_audit(CAP_AUDIT_HOTPLUG_DMAR, iommu);
 	if (ret)
 		goto out;
 
-	sp = domain_update_iommu_superpage(NULL, iommu) - 1;
-	if (sp >= 0 && !(cap_super_page_val(iommu->cap) & (1 << sp))) {
-		pr_warn("%s: Doesn't support large page.\n",
-			iommu->name);
-		return -ENXIO;
-	}
-
 	/*
 	 * Disable translation if already enabled prior to OS handover.
 	 */
-- 
2.43.0

