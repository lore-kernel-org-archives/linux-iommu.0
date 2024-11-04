Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50941917C4
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684499; cv=none; b=CgIdTnJ1KSjt+wPdP5nrHnmacylsK+Z5dclrx/eTQTvxnq75Rq57IY4VVGJCvLfWQ55natd3zcGVzz6zgx4yAXGyzC+qCVBhrSQaRrAvrkzvQ2dNx3SC8R6FoOGJfhZqYfKm/SVMNkoow2u+U/Yd0ykfyrCp8b9dpEwCp5nS5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684499; c=relaxed/simple;
	bh=+uSyS4phHxq5GXYXVRUlJGeP7Fm9awHucoHHXntuCdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss9jQhBBh/LWunddnplwCyCrHzDOdU7IocXtkkJftAMmFlurVDRgf4EBDCs1wGxuxz2r+Qe/fiGLTpHRKvE74XFcXi+rJCVuH0AO9C/xys6EKeo1TOkhoyOQ3ChTEx3IJUeOinL7Xfm1OKRM4PYYsRFe/W6EN5Sa/WPDbaC7mkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WsnduKCc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsnduKCc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684498; x=1762220498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+uSyS4phHxq5GXYXVRUlJGeP7Fm9awHucoHHXntuCdI=;
  b=WsnduKCc/cIwWuGaJbkDeGT6Og5Vt0rrXPEqlXl8JvHIo8rxB5HKQCII
   JLdstegyuZSoJnxHhLJes0ME3yYvIq0BMLSxBH92rumY0sBsLfBd9RELg
   anvfHa1YM4PRskR1aY8kvbSm3VyG7+7lgZblCrjqEWvql7yWQJ1Otb7aQ
   0CGGvt6iNq1CsC28SJJd/CsSmTQQzbs6Z7MI0q6S3+r6/A3EyBARfQiTj
   GVVOQxH/viHBZHizKmxl9VyyXCj8MiSm+cWodwuuL86841b6pS+LtNtOD
   ImDWFAcFUd94ICqoFp5AqCOxvVzHpUeh53LRW3XNu08Gk3iK5HGmVxorI
   A==;
X-CSE-ConnectionGUID: DJaUSy81SLivHMc7mcPeog==
X-CSE-MsgGUID: xdsy8LjXRqqyE1m6P4W3vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221942"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221942"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:37 -0800
X-CSE-ConnectionGUID: 26hekfaMSQG/XrJi2eJsyw==
X-CSE-MsgGUID: lCwL2dolQJmegrMUAVnL4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020889"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:37 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/19] iommu/vt-d: Drop s1_pgtbl from dmar_domain
Date: Mon,  4 Nov 2024 09:40:31 +0800
Message-ID: <20241104014040.106100-12-baolu.lu@linux.intel.com>
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

From: Yi Liu <yi.l.liu@intel.com>

dmar_domian has stored the s1_cfg which includes the s1_pgtbl info, so
no need to store s1_pgtbl, hence drop it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20241025143339.2328991-1-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h  | 2 --
 drivers/iommu/intel/nested.c | 1 -
 drivers/iommu/intel/pasid.c  | 3 +--
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 79692d7a26d1..4c6135a2e2f8 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -653,8 +653,6 @@ struct dmar_domain {
 		struct {
 			/* parent page table which the user domain is nested on */
 			struct dmar_domain *s2_domain;
-			/* user page table pointer (in GPA) */
-			unsigned long s1_pgtbl;
 			/* page table attributes */
 			struct iommu_hwpt_vtd_s1 s1_cfg;
 			/* link to parent domain siblings */
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index 96016bc40f94..989ca5cc04eb 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -162,7 +162,6 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
 
 	domain->use_first_level = true;
 	domain->s2_domain = s2_domain;
-	domain->s1_pgtbl = vtd.pgtbl_addr;
 	domain->s1_cfg = vtd;
 	domain->domain.ops = &intel_nested_domain_ops;
 	domain->domain.type = IOMMU_DOMAIN_NESTED;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 7ef157615e0f..7e76062a7ad2 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -560,7 +560,6 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 			     u32 pasid, struct dmar_domain *domain)
 {
 	struct iommu_hwpt_vtd_s1 *s1_cfg = &domain->s1_cfg;
-	pgd_t *s1_gpgd = (pgd_t *)(uintptr_t)domain->s1_pgtbl;
 	struct dmar_domain *s2_domain = domain->s2_domain;
 	u16 did = domain_id_iommu(domain, iommu);
 	struct dma_pte *pgd = s2_domain->pgd;
@@ -611,7 +610,7 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 	if (s1_cfg->addr_width == ADDR_WIDTH_5LEVEL)
 		pasid_set_flpm(pte, 1);
 
-	pasid_set_flptr(pte, (uintptr_t)s1_gpgd);
+	pasid_set_flptr(pte, s1_cfg->pgtbl_addr);
 
 	if (s1_cfg->flags & IOMMU_VTD_S1_SRE) {
 		pasid_set_sre(pte);
-- 
2.43.0

