Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F8934F48D
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036602; cv=none; b=aZfXU8rUtZzepYBmLKO5LYFQ2mrzRntbXTfwO8qYTl1X5VdpXwyDbhmLsFyOp2hlMq9wXGIuOFzpPXG8QLc67q8UCrvt0mYrl7qisCfegBJpgZwRTlNVTS/mxIM+R/GoGuOP6vGVakComgMLAxRAH1RR/T30ZCv4M4QrWhIiDNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036602; c=relaxed/simple;
	bh=DYREPAnsXoAIO6r1Fw6EsIIRjTHVUtTguaZ0vRiAhtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G10O06DJ7pRW9uIWVcOvoJZYJdRCz9teZ5I1QM5dZG/4E4WlUHxLEkrGaFUtOcNTw8gFfb7webeEumS5UF258eZWLfXkguRUcNdQU4Rgd4JyaPjAi+qT33A0YF7H+QC5/ZmXTz/iQj/CQimTj3QjuOY2kIZxDqRlu4K5UH8WWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AGVV+2CD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGVV+2CD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773036600; x=1804572600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYREPAnsXoAIO6r1Fw6EsIIRjTHVUtTguaZ0vRiAhtk=;
  b=AGVV+2CDzQNCbHSgCMQVW5vwxUgnco4fz+JHMPXdpXikLh21nMs/q2wN
   GDPoky+8i/xwleQhSfAjQO9Vha9N5TF0WcK8njcTv0kOgQAyYaSmWEFDR
   hmUVv6Jv3QgDcDVfnT2v9p2j9MY9RPc7U3LiW0BB5ayjqs9r/gIFR+u2+
   ysTgrIQSSC67dBlwKl7/iroa7X9Thr1qH8tdslK1LcF1eV3ILnjjPvN+M
   nv0NKYNZnTWWLBcGdTWeLpW9QhJThh2H/T3axq52jktE8qHFRy3x14NS7
   6m0k6EwnLmyZvffeJEBwO0CT4rRCzDGjBnL83DPQzrkMLDgytFfo865GX
   Q==;
X-CSE-ConnectionGUID: zVkzj2AHTmabuYNDnGkDSg==
X-CSE-MsgGUID: 0cbAp7FKRkeTKU4sdj2UWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73248307"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73248307"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:10:00 -0700
X-CSE-ConnectionGUID: I7OP9EknQNKMwMswO7kOvA==
X-CSE-MsgGUID: VXVbF9BVSRuQjTfqra2T4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="245669179"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2026 23:09:57 -0700
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
Subject: [PATCH 7/8] iommu/vt-d: Use intel_pasid_write() for pass-through setup
Date: Mon,  9 Mar 2026 14:06:47 +0800
Message-ID: <20260309060648.276762-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309060648.276762-1-baolu.lu@linux.intel.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor intel_pasid_setup_pass_through() to utilize
the intel_pasid_write() helper. Move the pass-through setup implementation
to the entry_sync library, where the target PASID entry is constructed
locally and committed via the centralized intel_pasid_write() wrapper.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 12 +-----------
 drivers/iommu/intel/pasid.c | 26 ++++----------------------
 2 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b98020ac9de2..f1f9fafd3984 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1248,16 +1248,6 @@ static void domain_context_clear_one(struct device_domain_info *info, u8 bus, u8
 	__iommu_flush_cache(iommu, context, sizeof(*context));
 }
 
-static int domain_setup_passthrough(struct intel_iommu *iommu,
-				    struct device *dev, ioasid_t pasid,
-				    struct iommu_domain *old)
-{
-	if (old)
-		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
-
-	return intel_pasid_setup_pass_through(iommu, dev, pasid);
-}
-
 static int domain_setup_first_level(struct intel_iommu *iommu,
 				    struct dmar_domain *domain,
 				    struct device *dev,
@@ -3848,7 +3838,7 @@ static int identity_domain_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		return ret;
 
-	ret = domain_setup_passthrough(iommu, dev, pasid, old);
+	ret = intel_pasid_setup_pass_through(iommu, dev, pasid);
 	if (ret) {
 		iopf_for_domain_replace(old, domain, dev);
 		return ret;
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 3084afb3d4a1..cb55ff422d7d 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -704,9 +704,6 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 static void pasid_pte_config_pass_through(struct intel_iommu *iommu,
 					  struct pasid_entry *pte, u16 did)
 {
-	lockdep_assert_held(&iommu->lock);
-
-	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
 	pasid_set_address_width(pte, iommu->agaw);
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_PT);
@@ -718,27 +715,12 @@ static void pasid_pte_config_pass_through(struct intel_iommu *iommu,
 int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 				   struct device *dev, u32 pasid)
 {
-	u16 did = FLPT_DEFAULT_DID;
-	struct pasid_entry *pte;
+	struct pasid_entry new_pte = {0};
 
-	spin_lock(&iommu->lock);
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (!pte) {
-		spin_unlock(&iommu->lock);
-		return -ENODEV;
-	}
+	iommu_group_mutex_assert(dev);
+	pasid_pte_config_pass_through(iommu, &new_pte, FLPT_DEFAULT_DID);
 
-	if (pasid_pte_is_present(pte)) {
-		spin_unlock(&iommu->lock);
-		return -EBUSY;
-	}
-
-	pasid_pte_config_pass_through(iommu, pte, did);
-	spin_unlock(&iommu->lock);
-
-	pasid_flush_caches(iommu, pte, pasid, did);
-
-	return 0;
+	return intel_pasid_write(iommu, dev, pasid, (u128 *)&new_pte);
 }
 
 /*
-- 
2.43.0

