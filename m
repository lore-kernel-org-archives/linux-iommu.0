Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857D36C5A3
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 06:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890057; cv=none; b=XHZbhFvZanP7znPyBif6QWLfmDBVANjFeT4dpJRqRTa+KdBsSRtG0mlfcNvNAE3PRFDy+nKKkew3wfJcF8dJMIAKJbfzSb05FT9fQ+dL0SpuSYML6pKvxLRUwidyqUIeAfZTa8i8P3mCR360JT8WM9oiA4hC+xfkg3eoN3HVCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890057; c=relaxed/simple;
	bh=Wsf8+Tqw1vh/9VsN5YjTjdQxnbGm1mUm8mSEQp+1Las=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQJAMy5Un///SRhXZqnol+gOZ4xv2hfLKaCri+uNbl3iwgi+3EluR3Q31WWjd3nsRZ0yTpCjol+qTzeaA3d7QxR4TD3Z/uWy/PowPTA9RVz33bekP8yby4HGICZp2zwtLuVGw+Wv/g9s/LlkbLp7nFV9QKO9S4OTjbMbWDij4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bt/hs+sL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bt/hs+sL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768890055; x=1800426055;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wsf8+Tqw1vh/9VsN5YjTjdQxnbGm1mUm8mSEQp+1Las=;
  b=Bt/hs+sL6q3WRGqz3rCZBqB8UE8WkjqemnaWHE2kIdKpJZ09qV6WFfK6
   2FZ/4NXwPHH5elYIEfQC1UMCqiAsGR+UngPbFiPCSUXyEi0DF+bIG76v7
   9MCmAN3VoNSKpn5nzoXQreEQSQEWds5Wx62smspicxib4nRC+dHSoxv56
   yRXudwkT5Mn1XdXK6jqbUtHA1g6xfQmbwJLAkfNA/GCcT6MlThbf8IQy2
   rjzcGFSOrw0h89DxY7ir7MUD81RRvdE6MeyCUSb2jSfHknFDPqCiitTX/
   mC+tQ7mzdP2SHqoQrIGZyogRiY62UybFKo0o4Nbmt6R85iTngi6IXDOjc
   Q==;
X-CSE-ConnectionGUID: BadDbOYDSimseooSn+zhOQ==
X-CSE-MsgGUID: S0l+040PTLWGqRi7crX5gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69991325"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="69991325"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 22:20:54 -0800
X-CSE-ConnectionGUID: EPNpNMMiS36U2q/soj20FQ==
X-CSE-MsgGUID: CIRPfzxSQ0a4y7gqSvl5ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="206464274"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jan 2026 22:20:52 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 3/3] iommu/vt-d: Fix race condition during PASID entry replacement
Date: Tue, 20 Jan 2026 14:18:14 +0800
Message-ID: <20260120061816.2132558-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
References: <20260120061816.2132558-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Intel VT-d PASID table entry is 512 bits (64 bytes). When replacing
an active PASID entry (e.g., during domain replacement), the current
implementation calculates a new entry on the stack and copies it to the
table using a single structure assignment.

        struct pasid_entry *pte, new_pte;

        pte = intel_pasid_get_entry(dev, pasid);
        pasid_pte_config_first_level(iommu, &new_pte, ...);
        *pte = new_pte;

Because the hardware may fetch the 512-bit PASID entry in multiple
128-bit chunks, updating the entire entry while it is active (Present
bit set) risks a "torn" read. In this scenario, the IOMMU hardware
could observe an inconsistent state — partially new data and partially
old data — leading to unpredictable behavior or spurious faults.

Fix this by removing the unsafe "replace" helpers and following the
"clear-then-update" flow, which ensures the Present bit is cleared and
the required invalidation handshake is completed before the new
configuration is applied.

Fixes: 7543ee63e811 ("iommu/vt-d: Add pasid replace helpers")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h  |  14 ---
 drivers/iommu/intel/iommu.c  |  29 +++---
 drivers/iommu/intel/nested.c |   9 +-
 drivers/iommu/intel/pasid.c  | 184 -----------------------------------
 4 files changed, 16 insertions(+), 220 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 0b303bd0b0c1..c3c8c907983e 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -316,20 +316,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct device *dev, u32 pasid);
 int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 			     u32 pasid, struct dmar_domain *domain);
-int intel_pasid_replace_first_level(struct intel_iommu *iommu,
-				    struct device *dev, phys_addr_t fsptptr,
-				    u32 pasid, u16 did, u16 old_did, int flags);
-int intel_pasid_replace_second_level(struct intel_iommu *iommu,
-				     struct dmar_domain *domain,
-				     struct device *dev, u16 old_did,
-				     u32 pasid);
-int intel_pasid_replace_pass_through(struct intel_iommu *iommu,
-				     struct device *dev, u16 old_did,
-				     u32 pasid);
-int intel_pasid_replace_nested(struct intel_iommu *iommu,
-			       struct device *dev, u32 pasid,
-			       u16 old_did, struct dmar_domain *domain);
-
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, u32 pasid,
 				 bool fault_ignore);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c66cc51f9e51..705828b06e32 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1252,12 +1252,10 @@ int __domain_setup_first_level(struct intel_iommu *iommu, struct device *dev,
 			       ioasid_t pasid, u16 did, phys_addr_t fsptptr,
 			       int flags, struct iommu_domain *old)
 {
-	if (!old)
-		return intel_pasid_setup_first_level(iommu, dev, fsptptr, pasid,
-						     did, flags);
-	return intel_pasid_replace_first_level(iommu, dev, fsptptr, pasid, did,
-					       iommu_domain_did(old, iommu),
-					       flags);
+	if (old)
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+	return intel_pasid_setup_first_level(iommu, dev, fsptptr, pasid, did, flags);
 }
 
 static int domain_setup_second_level(struct intel_iommu *iommu,
@@ -1265,23 +1263,20 @@ static int domain_setup_second_level(struct intel_iommu *iommu,
 				     struct device *dev, ioasid_t pasid,
 				     struct iommu_domain *old)
 {
-	if (!old)
-		return intel_pasid_setup_second_level(iommu, domain,
-						      dev, pasid);
-	return intel_pasid_replace_second_level(iommu, domain, dev,
-						iommu_domain_did(old, iommu),
-						pasid);
+	if (old)
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+	return intel_pasid_setup_second_level(iommu, domain, dev, pasid);
 }
 
 static int domain_setup_passthrough(struct intel_iommu *iommu,
 				    struct device *dev, ioasid_t pasid,
 				    struct iommu_domain *old)
 {
-	if (!old)
-		return intel_pasid_setup_pass_through(iommu, dev, pasid);
-	return intel_pasid_replace_pass_through(iommu, dev,
-						iommu_domain_did(old, iommu),
-						pasid);
+	if (old)
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+	return intel_pasid_setup_pass_through(iommu, dev, pasid);
 }
 
 static int domain_setup_first_level(struct intel_iommu *iommu,
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index a3fb8c193ca6..e9a440e9c960 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -136,11 +136,10 @@ static int domain_setup_nested(struct intel_iommu *iommu,
 			       struct device *dev, ioasid_t pasid,
 			       struct iommu_domain *old)
 {
-	if (!old)
-		return intel_pasid_setup_nested(iommu, dev, pasid, domain);
-	return intel_pasid_replace_nested(iommu, dev, pasid,
-					  iommu_domain_did(old, iommu),
-					  domain);
+	if (old)
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+	return intel_pasid_setup_nested(iommu, dev, pasid, domain);
 }
 
 static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index eb069aefa4fa..4b880b9ad49d 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -416,50 +416,6 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu, struct device *dev,
 	return 0;
 }
 
-int intel_pasid_replace_first_level(struct intel_iommu *iommu,
-				    struct device *dev, phys_addr_t fsptptr,
-				    u32 pasid, u16 did, u16 old_did,
-				    int flags)
-{
-	struct pasid_entry *pte, new_pte;
-
-	if (!ecap_flts(iommu->ecap)) {
-		pr_err("No first level translation support on %s\n",
-		       iommu->name);
-		return -EINVAL;
-	}
-
-	if ((flags & PASID_FLAG_FL5LP) && !cap_fl5lp_support(iommu->cap)) {
-		pr_err("No 5-level paging support for first-level on %s\n",
-		       iommu->name);
-		return -EINVAL;
-	}
-
-	pasid_pte_config_first_level(iommu, &new_pte, fsptptr, did, flags);
-
-	spin_lock(&iommu->lock);
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (!pte) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
-
-	if (!pasid_pte_is_present(pte)) {
-		spin_unlock(&iommu->lock);
-		return -EINVAL;
-	}
-
-	WARN_ON(old_did != pasid_get_domain_id(pte));
-
-	*pte = new_pte;
-	spin_unlock(&iommu->lock);
-
-	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
-	intel_iommu_drain_pasid_prq(dev, pasid);
-
-	return 0;
-}
-
 /*
  * Set up the scalable mode pasid entry for second only translation type.
  */
@@ -526,51 +482,6 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	return 0;
 }
 
-int intel_pasid_replace_second_level(struct intel_iommu *iommu,
-				     struct dmar_domain *domain,
-				     struct device *dev, u16 old_did,
-				     u32 pasid)
-{
-	struct pasid_entry *pte, new_pte;
-	u16 did;
-
-	/*
-	 * If hardware advertises no support for second level
-	 * translation, return directly.
-	 */
-	if (!ecap_slts(iommu->ecap)) {
-		pr_err("No second level translation support on %s\n",
-		       iommu->name);
-		return -EINVAL;
-	}
-
-	did = domain_id_iommu(domain, iommu);
-
-	pasid_pte_config_second_level(iommu, &new_pte, domain, did);
-
-	spin_lock(&iommu->lock);
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (!pte) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
-
-	if (!pasid_pte_is_present(pte)) {
-		spin_unlock(&iommu->lock);
-		return -EINVAL;
-	}
-
-	WARN_ON(old_did != pasid_get_domain_id(pte));
-
-	*pte = new_pte;
-	spin_unlock(&iommu->lock);
-
-	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
-	intel_iommu_drain_pasid_prq(dev, pasid);
-
-	return 0;
-}
-
 /*
  * Set up dirty tracking on a second only or nested translation type.
  */
@@ -683,38 +594,6 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	return 0;
 }
 
-int intel_pasid_replace_pass_through(struct intel_iommu *iommu,
-				     struct device *dev, u16 old_did,
-				     u32 pasid)
-{
-	struct pasid_entry *pte, new_pte;
-	u16 did = FLPT_DEFAULT_DID;
-
-	pasid_pte_config_pass_through(iommu, &new_pte, did);
-
-	spin_lock(&iommu->lock);
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (!pte) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
-
-	if (!pasid_pte_is_present(pte)) {
-		spin_unlock(&iommu->lock);
-		return -EINVAL;
-	}
-
-	WARN_ON(old_did != pasid_get_domain_id(pte));
-
-	*pte = new_pte;
-	spin_unlock(&iommu->lock);
-
-	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
-	intel_iommu_drain_pasid_prq(dev, pasid);
-
-	return 0;
-}
-
 /*
  * Set the page snoop control for a pasid entry which has been set up.
  */
@@ -848,69 +727,6 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device *dev,
 	return 0;
 }
 
-int intel_pasid_replace_nested(struct intel_iommu *iommu,
-			       struct device *dev, u32 pasid,
-			       u16 old_did, struct dmar_domain *domain)
-{
-	struct iommu_hwpt_vtd_s1 *s1_cfg = &domain->s1_cfg;
-	struct dmar_domain *s2_domain = domain->s2_domain;
-	u16 did = domain_id_iommu(domain, iommu);
-	struct pasid_entry *pte, new_pte;
-
-	/* Address width should match the address width supported by hardware */
-	switch (s1_cfg->addr_width) {
-	case ADDR_WIDTH_4LEVEL:
-		break;
-	case ADDR_WIDTH_5LEVEL:
-		if (!cap_fl5lp_support(iommu->cap)) {
-			dev_err_ratelimited(dev,
-					    "5-level paging not supported\n");
-			return -EINVAL;
-		}
-		break;
-	default:
-		dev_err_ratelimited(dev, "Invalid stage-1 address width %d\n",
-				    s1_cfg->addr_width);
-		return -EINVAL;
-	}
-
-	if ((s1_cfg->flags & IOMMU_VTD_S1_SRE) && !ecap_srs(iommu->ecap)) {
-		pr_err_ratelimited("No supervisor request support on %s\n",
-				   iommu->name);
-		return -EINVAL;
-	}
-
-	if ((s1_cfg->flags & IOMMU_VTD_S1_EAFE) && !ecap_eafs(iommu->ecap)) {
-		pr_err_ratelimited("No extended access flag support on %s\n",
-				   iommu->name);
-		return -EINVAL;
-	}
-
-	pasid_pte_config_nestd(iommu, &new_pte, s1_cfg, s2_domain, did);
-
-	spin_lock(&iommu->lock);
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (!pte) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
-
-	if (!pasid_pte_is_present(pte)) {
-		spin_unlock(&iommu->lock);
-		return -EINVAL;
-	}
-
-	WARN_ON(old_did != pasid_get_domain_id(pte));
-
-	*pte = new_pte;
-	spin_unlock(&iommu->lock);
-
-	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
-	intel_iommu_drain_pasid_prq(dev, pasid);
-
-	return 0;
-}
-
 /*
  * Interfaces to setup or teardown a pasid table to the scalable-mode
  * context table entry:
-- 
2.43.0

