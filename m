Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F3F2BE7B1
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258858; cv=none; b=OXTFsACdI7176vA2DICVlFC5CPXGWY+JIGQDdw2ql0dHnEBwgnQn/khP7RBEowytTYMFhgBUCAD1rbrYV9ysG6/sWNS7pCdDqpdaHN+vHJVU3qIoHGwoy4LS77Wzp6GK2aMq/yFntNzd+qqhMuPFUg7lPsEKaJh5shvnCZW7cxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258858; c=relaxed/simple;
	bh=AbywpTOOKbxEqDW9iByzwp7ySVcBEv42pVsan2OURTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrInLAUEqeNKH4j85EV78rM8C2FuIhw1EsQnEzw/JSqbAe/J7CP/kdFS8Ecndx2OUgFlWjp/UEoRG6Ef4c4z9nEqjpuN1w492lISOT1aVhw/n9W2qLN3GNtOHZ0BtYoZcJjIUvM816oU92Dw4p0wJShLoXwQOeARCrGxl/ZtCmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ispSGaJS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ispSGaJS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770258858; x=1801794858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AbywpTOOKbxEqDW9iByzwp7ySVcBEv42pVsan2OURTQ=;
  b=ispSGaJSwebq2vjDmUIyTdFv3OjZBTuCsnTiP6syqVLdGRyP6WqitmMH
   vGEgyupCRMGID6oDGFbRQsvvG+lLQNe6MVZHkrBCN6BuVsxExteT30Znl
   H/MrUjKfWS2aIIN99K2QJFsQBDSyKvLInDxN8Zh8JjxDDtJhTMasKY69+
   Nb66dSdypXAQSKI6t71vVmZl1gtWLwbxmwpGO8GUkFk+ZYJFdtAeoZe3R
   kHh7b3skKtKB9VXJJA64/dnAFsegM8LNO5KcnBxKm5HL3hR4eldljXm1T
   wr5HZVNX3Z4KIHeGZCunrY45YhTMLkceC6a7j0CjjEEGLHWP8Ra0Bg843
   A==;
X-CSE-ConnectionGUID: P3tKHVn2SpuzE/oSbBp1mA==
X-CSE-MsgGUID: Pw+MRh8rTnqjOF6ATaDG2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="74057937"
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="74057937"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 18:34:18 -0800
X-CSE-ConnectionGUID: qoqrCeOfTMCUzx4vy7Sn9g==
X-CSE-MsgGUID: fkOkHTpOTiaan/dJGHM9cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,273,1763452800"; 
   d="scan'208";a="214872061"
Received: from spr-duan.bj.intel.com ([172.16.114.123])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 18:34:16 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/3] iommupt/vtd: Pass dmar_domain pointer to device_set_dirty_tracking()
Date: Wed,  4 Feb 2026 21:34:02 -0500
Message-ID: <20260205023405.41583-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205023405.41583-1-zhenzhong.duan@intel.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pass dmar_domain pointer to device_set_dirty_tracking() instead of
device list in the domain.

This is a prerequisite patch to support dirty tracking on PASIDs.

No functional changes intended.

Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/iommu.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 134302fbcd92..acaa6eaf7e2f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3687,16 +3687,15 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length,
 	return vtd;
 }
 
-/*
- * Set dirty tracking for the device list of a domain. The caller must
- * hold the domain->lock when calling it.
- */
-static int device_set_dirty_tracking(struct list_head *devices, bool enable)
+/* Set dirty tracking for the devices that the domain has been attached. */
+static int device_set_dirty_tracking(struct dmar_domain *domain, bool enable)
 {
 	struct device_domain_info *info;
 	int ret = 0;
 
-	list_for_each_entry(info, devices, link) {
+	lockdep_assert_held(&domain->lock);
+
+	list_for_each_entry(info, &domain->devices, link) {
 		ret = intel_pasid_setup_dirty_tracking(info->iommu, info->dev,
 						       IOMMU_NO_PASID, enable);
 		if (ret)
@@ -3716,7 +3715,7 @@ static int parent_domain_set_dirty_tracking(struct dmar_domain *domain,
 	spin_lock(&domain->s1_lock);
 	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
 		spin_lock_irqsave(&s1_domain->lock, flags);
-		ret = device_set_dirty_tracking(&s1_domain->devices, enable);
+		ret = device_set_dirty_tracking(s1_domain, enable);
 		spin_unlock_irqrestore(&s1_domain->lock, flags);
 		if (ret)
 			goto err_unwind;
@@ -3727,8 +3726,7 @@ static int parent_domain_set_dirty_tracking(struct dmar_domain *domain,
 err_unwind:
 	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
 		spin_lock_irqsave(&s1_domain->lock, flags);
-		device_set_dirty_tracking(&s1_domain->devices,
-					  domain->dirty_tracking);
+		device_set_dirty_tracking(s1_domain, domain->dirty_tracking);
 		spin_unlock_irqrestore(&s1_domain->lock, flags);
 	}
 	spin_unlock(&domain->s1_lock);
@@ -3745,7 +3743,7 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	if (dmar_domain->dirty_tracking == enable)
 		goto out_unlock;
 
-	ret = device_set_dirty_tracking(&dmar_domain->devices, enable);
+	ret = device_set_dirty_tracking(dmar_domain, enable);
 	if (ret)
 		goto err_unwind;
 
@@ -3762,8 +3760,7 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	return 0;
 
 err_unwind:
-	device_set_dirty_tracking(&dmar_domain->devices,
-				  dmar_domain->dirty_tracking);
+	device_set_dirty_tracking(dmar_domain, dmar_domain->dirty_tracking);
 	spin_unlock(&dmar_domain->lock);
 	return ret;
 }
-- 
2.47.3

