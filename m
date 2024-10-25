Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA21CF7DB
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866823; cv=none; b=fhbzVzllLtAnxfIDiJQM3RDnC+Wi9X78zu0ayKOrOJyPPNThFXPS/gEvBUJG6OIKk3xsUbjP15kDKcKMuS50sCcuknSa8lFXMXELUMC+fJGXrQgJ6JpLe6R1fl/1Dtx386yuLfYH/2kk15BjULdfMqbTmS0xdEzLlIUYB8a6s/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866823; c=relaxed/simple;
	bh=Knj201xEIzZb2h2MF8qbmY7ruPwSmvKe2wKMv3fHvzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LnNmOf6RWZowmbPwL+/Z0L/lrm7Ib4ALTj6v91HGzlLauKU6OY10NEutQSPnc6gJZogm4XU6ak8GuRbFYYyfap/V3e0JXPIu0jh039HL/u2DBTgaxT68YWxAg0WYxyYz2t0vVjrvg2fHnmG/Gx3rM+Xg56wiKqkbZ0GSKthYB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PzRVeWsk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PzRVeWsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729866822; x=1761402822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Knj201xEIzZb2h2MF8qbmY7ruPwSmvKe2wKMv3fHvzE=;
  b=PzRVeWskdATP2HOBG7FI6GycMqvfYPAp9WAHpZ0dJ89lFBNFF0UBgdFz
   NC16C9zHAtvwF/SeJjpF1x67aemcaKE/Rn0ZfH30y8VVuXfqgPqTjNUcU
   ysKnBUhoAl3hqWyGbJLbIh54gSwdzIbjbV+gnhMby+5ifKQdzNnHK8pfb
   WzD1LqypJ3gztCQ2SBGP7t+Uz1tjPiR81avqvWAdOeu3oTQgs8Df4C1/q
   DmLB0qyvmNfCMZCrjfLD5RK2vkz6R7dqFjUVJaf2RDvgWGJfLOLo1UP2Q
   C8LvE6NiCj6OiZ0ErX5sj6DdWNgZjIIZjtsSSgnovDKS/x1xzvLi7aPMh
   g==;
X-CSE-ConnectionGUID: dH7L8AwaSLy8eJqknC0rMA==
X-CSE-MsgGUID: uA0fK0KcQSK5w+BaZ6944g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29713387"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29713387"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 07:33:41 -0700
X-CSE-ConnectionGUID: Bx05FgDiQcyhPmQkETh6wA==
X-CSE-MsgGUID: Za61K9Q6Tpm00+tyu9WvHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="80846992"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa010.jf.intel.com with ESMTP; 25 Oct 2024 07:33:40 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev
Subject: [PATCH] iommu/vt-d: Drop s1_pgtbl from dmar_domain
Date: Fri, 25 Oct 2024 07:33:39 -0700
Message-Id: <20241025143339.2328991-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dmar_domian has stored the s1_cfg which includes the s1_pgtbl info, so
no need to store s1_pgtbl, hence drop it.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/intel/iommu.h  | 2 --
 drivers/iommu/intel/nested.c | 1 -
 drivers/iommu/intel/pasid.c  | 3 +--
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1497f3112b12..009f518722e0 100644
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
index 433c58944401..3ce3c4fd210e 100644
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
index 2e5fa0a23299..977c4ac00c4c 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -586,7 +586,6 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 			     u32 pasid, struct dmar_domain *domain)
 {
 	struct iommu_hwpt_vtd_s1 *s1_cfg = &domain->s1_cfg;
-	pgd_t *s1_gpgd = (pgd_t *)(uintptr_t)domain->s1_pgtbl;
 	struct dmar_domain *s2_domain = domain->s2_domain;
 	u16 did = domain_id_iommu(domain, iommu);
 	struct dma_pte *pgd = s2_domain->pgd;
@@ -637,7 +636,7 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 	if (s1_cfg->addr_width == ADDR_WIDTH_5LEVEL)
 		pasid_set_flpm(pte, 1);
 
-	pasid_set_flptr(pte, (uintptr_t)s1_gpgd);
+	pasid_set_flptr(pte, s1_cfg->pgtbl_addr);
 
 	if (s1_cfg->flags & IOMMU_VTD_S1_SRE) {
 		pasid_set_sre(pte);
-- 
2.34.1

