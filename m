Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE2126C0A
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032109; cv=none; b=eAgL8M0rdf/5axzXx435x7/jtguQneh5cH/5e5xoSSJjSFAK/pKLGzMBsDGmR4ojJ5MnI4eXRQgpYhwqnYCdFwsO+PMfrYOAEAu5Wt1a4ybH32fV+cPj7lzYFcPglvbRpPlJ8ob4jIHi6aP0+/qRMviJFaSRoUhXx3kMa1DDOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032109; c=relaxed/simple;
	bh=Zr0PGgREOMxb9hFtNVo5tDPtF6olnwqmeazDou4TFVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZzg/shqnd9NOuz1XS+EV5DPn+cQYGHUKvqZsRJuKmYUrH38NKOb07huxOKL+g38B7tN0vmAe+dCwKYyanuUfJnFO3o0ZO0fUpndxjdGCVbf7zeKNDI4iCCSQNYPCtEPxfV7VtfBQODD2bbhnVBDeYnCIu4rCaGJU+xMrQAJKlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCcINCuZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCcINCuZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032107; x=1762568107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zr0PGgREOMxb9hFtNVo5tDPtF6olnwqmeazDou4TFVI=;
  b=JCcINCuZGLaP/9KgW85uaMdjNtaP6U5CJAK3DHhggJ4TZUgC5TSKlh5O
   1meO6L/h/kKrOPYZ2rF/OgYIKMe4G3fxSFaqvwDFZC5BOKKKqaAE7wQgF
   RcLt+9Q2QBXdARQfZebWIK7ANDN+35mxb3XYxSQIm+QZWhjx8hlrkWgPP
   YRk/g/71/UEXlwwPbzREIluLksmd09HGGkBaOQqA4HtwyejaNfo7h9EqB
   6dHbGOvFES/5ySHeL0FlAy61JXc2/PrI00bd1ujxidNFueiR8PlUA6I2Q
   0SCPPZT7YYToXVQux8EEdW+XZPcXo/JwvTgr/kqO6ZPHY/Vtp4yFgj01z
   g==;
X-CSE-ConnectionGUID: BcYWEIqdR5SpEv67DrDDlA==
X-CSE-MsgGUID: 679nuv33TSagqDvS9YQNRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007773"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007773"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:07 -0800
X-CSE-ConnectionGUID: pBxeondQQ4a2MsjaeJ6CAA==
X-CSE-MsgGUID: OUGQDDkCRsyghUheQs2ztA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213780"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:05 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] iommu/vt-d: Add pasid replace helpers
Date: Fri,  8 Nov 2024 10:13:55 +0800
Message-ID: <20241108021406.173972-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108021406.173972-1-baolu.lu@linux.intel.com>
References: <20241108021406.173972-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

pasid replacement allows converting a present pasid entry to be FS, SS,
PT or nested, hence add helpers for such operations.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-5-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 190 ++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/pasid.h |  15 +++
 2 files changed, 205 insertions(+)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 6841b9892d55..0f2a926d3bd5 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -389,6 +389,50 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	return 0;
 }
 
+int intel_pasid_replace_first_level(struct intel_iommu *iommu,
+				    struct device *dev, pgd_t *pgd,
+				    u32 pasid, u16 did, u16 old_did,
+				    int flags)
+{
+	struct pasid_entry *pte, new_pte;
+
+	if (!ecap_flts(iommu->ecap)) {
+		pr_err("No first level translation support on %s\n",
+		       iommu->name);
+		return -EINVAL;
+	}
+
+	if ((flags & PASID_FLAG_FL5LP) && !cap_fl5lp_support(iommu->cap)) {
+		pr_err("No 5-level paging support for first-level on %s\n",
+		       iommu->name);
+		return -EINVAL;
+	}
+
+	pasid_pte_config_first_level(iommu, &new_pte, pgd, did, flags);
+
+	spin_lock(&iommu->lock);
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		spin_unlock(&iommu->lock);
+		return -ENODEV;
+	}
+
+	if (!pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
+		return -EINVAL;
+	}
+
+	WARN_ON(old_did != pasid_get_domain_id(pte));
+
+	*pte = new_pte;
+	spin_unlock(&iommu->lock);
+
+	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
+	intel_iommu_drain_pasid_prq(dev, pasid);
+
+	return 0;
+}
+
 /*
  * Set up the scalable mode pasid entry for second only translation type.
  */
@@ -456,6 +500,57 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	return 0;
 }
 
+int intel_pasid_replace_second_level(struct intel_iommu *iommu,
+				     struct dmar_domain *domain,
+				     struct device *dev, u16 old_did,
+				     u32 pasid)
+{
+	struct pasid_entry *pte, new_pte;
+	struct dma_pte *pgd;
+	u64 pgd_val;
+	u16 did;
+
+	/*
+	 * If hardware advertises no support for second level
+	 * translation, return directly.
+	 */
+	if (!ecap_slts(iommu->ecap)) {
+		pr_err("No second level translation support on %s\n",
+		       iommu->name);
+		return -EINVAL;
+	}
+
+	pgd = domain->pgd;
+	pgd_val = virt_to_phys(pgd);
+	did = domain_id_iommu(domain, iommu);
+
+	pasid_pte_config_second_level(iommu, &new_pte, pgd_val,
+				      domain->agaw, did,
+				      domain->dirty_tracking);
+
+	spin_lock(&iommu->lock);
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		spin_unlock(&iommu->lock);
+		return -ENODEV;
+	}
+
+	if (!pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
+		return -EINVAL;
+	}
+
+	WARN_ON(old_did != pasid_get_domain_id(pte));
+
+	*pte = new_pte;
+	spin_unlock(&iommu->lock);
+
+	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
+	intel_iommu_drain_pasid_prq(dev, pasid);
+
+	return 0;
+}
+
 /*
  * Set up dirty tracking on a second only or nested translation type.
  */
@@ -568,6 +663,38 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	return 0;
 }
 
+int intel_pasid_replace_pass_through(struct intel_iommu *iommu,
+				     struct device *dev, u16 old_did,
+				     u32 pasid)
+{
+	struct pasid_entry *pte, new_pte;
+	u16 did = FLPT_DEFAULT_DID;
+
+	pasid_pte_config_pass_through(iommu, &new_pte, did);
+
+	spin_lock(&iommu->lock);
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		spin_unlock(&iommu->lock);
+		return -ENODEV;
+	}
+
+	if (!pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
+		return -EINVAL;
+	}
+
+	WARN_ON(old_did != pasid_get_domain_id(pte));
+
+	*pte = new_pte;
+	spin_unlock(&iommu->lock);
+
+	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
+	intel_iommu_drain_pasid_prq(dev, pasid);
+
+	return 0;
+}
+
 /*
  * Set the page snoop control for a pasid entry which has been set up.
  */
@@ -698,6 +825,69 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 	return 0;
 }
 
+int intel_pasid_replace_nested(struct intel_iommu *iommu,
+			       struct device *dev, u32 pasid,
+			       u16 old_did, struct dmar_domain *domain)
+{
+	struct iommu_hwpt_vtd_s1 *s1_cfg = &domain->s1_cfg;
+	struct dmar_domain *s2_domain = domain->s2_domain;
+	u16 did = domain_id_iommu(domain, iommu);
+	struct pasid_entry *pte, new_pte;
+
+	/* Address width should match the address width supported by hardware */
+	switch (s1_cfg->addr_width) {
+	case ADDR_WIDTH_4LEVEL:
+		break;
+	case ADDR_WIDTH_5LEVEL:
+		if (!cap_fl5lp_support(iommu->cap)) {
+			dev_err_ratelimited(dev,
+					    "5-level paging not supported\n");
+			return -EINVAL;
+		}
+		break;
+	default:
+		dev_err_ratelimited(dev, "Invalid stage-1 address width %d\n",
+				    s1_cfg->addr_width);
+		return -EINVAL;
+	}
+
+	if ((s1_cfg->flags & IOMMU_VTD_S1_SRE) && !ecap_srs(iommu->ecap)) {
+		pr_err_ratelimited("No supervisor request support on %s\n",
+				   iommu->name);
+		return -EINVAL;
+	}
+
+	if ((s1_cfg->flags & IOMMU_VTD_S1_EAFE) && !ecap_eafs(iommu->ecap)) {
+		pr_err_ratelimited("No extended access flag support on %s\n",
+				   iommu->name);
+		return -EINVAL;
+	}
+
+	pasid_pte_config_nestd(iommu, &new_pte, s1_cfg, s2_domain, did);
+
+	spin_lock(&iommu->lock);
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		spin_unlock(&iommu->lock);
+		return -ENODEV;
+	}
+
+	if (!pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
+		return -EINVAL;
+	}
+
+	WARN_ON(old_did != pasid_get_domain_id(pte));
+
+	*pte = new_pte;
+	spin_unlock(&iommu->lock);
+
+	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
+	intel_iommu_drain_pasid_prq(dev, pasid);
+
+	return 0;
+}
+
 /*
  * Interfaces to setup or teardown a pasid table to the scalable-mode
  * context table entry:
diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index dde6d3ba5ae0..06d1f7006d01 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -303,6 +303,21 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct device *dev, u32 pasid);
 int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 			     u32 pasid, struct dmar_domain *domain);
+int intel_pasid_replace_first_level(struct intel_iommu *iommu,
+				    struct device *dev, pgd_t *pgd,
+				    u32 pasid, u16 did, u16 old_did,
+				    int flags);
+int intel_pasid_replace_second_level(struct intel_iommu *iommu,
+				     struct dmar_domain *domain,
+				     struct device *dev, u16 old_did,
+				     u32 pasid);
+int intel_pasid_replace_pass_through(struct intel_iommu *iommu,
+				     struct device *dev, u16 old_did,
+				     u32 pasid);
+int intel_pasid_replace_nested(struct intel_iommu *iommu,
+			       struct device *dev, u32 pasid,
+			       u16 old_did, struct dmar_domain *domain);
+
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, u32 pasid,
 				 bool fault_ignore);
-- 
2.43.0

