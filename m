Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BB30595B
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 03:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273418; cv=none; b=FDHdyPlYQUH3OQMZdmZChKgIsyUBJoeh8MbDUkicRV8QYTc5Syuc1Lrscc9nwSWVFSn5VKyJDleDZe0t3yfaE0I9A/TkpB9DspFX01YPJjNA+FjwPM6TgIfCFwSaOw+50BrjpkRfxBXDGBphbsrvCcVwqCoa/1L03VDcKH9j06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273418; c=relaxed/simple;
	bh=n+uTTsNko9/lUhpcJVi/aQ0OodLEcU133efT/nzUBwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UVE5ZfRtNb1zpedlQVYCqa9GIY1H3lgl/tlXUEVG+iSfdDhI5UYj5zhlyK1tiugtfifFMFvB3hcrOXtPwRmo78Ofa5aKPcbZwA5kkJF+cHxfipz7HG6LLbs9qG2dlXPLsSlOtNa8Y+U6imBFoi5lt2DCmbmV1ccCYD38ZQ8x2DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RPhM6GNJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RPhM6GNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768273418; x=1799809418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n+uTTsNko9/lUhpcJVi/aQ0OodLEcU133efT/nzUBwQ=;
  b=RPhM6GNJEUmiMr4JYrHFWQp/KLIHY8TSt73sDQVJ2WfV0navTXGME/fJ
   nhtl3PW8egGJK6ocVFRPQGKWHxT1bAmcaXWgfPT7vHfLZsP8g874gaJoV
   ukyQBVhOvzYc4+yrtM8yJFA6IX1RWI6lkvTttSdXfpM9hI2KkDigegalc
   kR9gPIz9hMGJhB4pXaWllIRUNByDBBMgrA7OuJgKSDv4ZJdvrqqzVhdm5
   Ya6U1wBlLEGPNG9ruGy6408gHnXKQQnGOjyyf/GO2EiLWAT1e2BJIFDkz
   yV+3NdiHsMPp9R4ItvjCAuuF6ZWy6F9gXH3dbXbPGRyI/hCyXLusCkYyJ
   Q==;
X-CSE-ConnectionGUID: f3IPbEZBQCmXrw/2Q/fjRA==
X-CSE-MsgGUID: V6qEl+gBQKWL7kfwr+swtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69607505"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="69607505"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 19:03:37 -0800
X-CSE-ConnectionGUID: 6/s5ML/gRn6pqepF3aCTwA==
X-CSE-MsgGUID: OU4qvVkERrO+R1uM2nGsbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="203466962"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 12 Jan 2026 19:03:34 -0800
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
Subject: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Date: Tue, 13 Jan 2026 11:00:48 +0800
Message-ID: <20260113030052.977366-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113030052.977366-1-baolu.lu@linux.intel.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel VT-d PASID table entry is 512 bits (64 bytes). Because the
hardware may fetch this entry in multiple 128-bit chunks, updating the
entire entry while it is active (P=1) risks a "torn" read where the
hardware observes an inconsistent state.

However, certain updates (e.g., changing page table pointers while
keeping the translation type and domain ID the same) can be performed
hitlessly. This is possible if the update is limited to a single
128-bit chunk while the other chunks remains stable.

Introduce a hitless replacement mechanism for PASID entries:

- Update 'struct pasid_entry' with a union to support 128-bit
  access via the newly added val128[4] array.
- Add pasid_support_hitless_replace() to determine if a transition
  between an old and new entry is safe to perform atomically.
  - For First-level/Nested translations: The first 128 bits (chunk 0)
    must remain identical; chunk 1 is updated atomically.
  - For Second-level/Pass-through: The second 128 bits (chunk 1)
    must remain identical; chunk 0 is updated atomically.
- If hitless replacement is supported, use intel_iommu_atomic128_set()
  to commit the change in a single 16-byte burst.
- If the changes are too extensive to be hitless, fall back to the
  safe "tear down and re-setup" flow (clear present -> flush -> setup).

Fixes: 7543ee63e811 ("iommu/vt-d: Add pasid replace helpers")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.h | 26 ++++++++++++++++-
 drivers/iommu/intel/pasid.c | 57 ++++++++++++++++++++++++++++++++++---
 2 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
index 35de1d77355f..b569e2828a8b 100644
--- a/drivers/iommu/intel/pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -37,7 +37,10 @@ struct pasid_dir_entry {
 };
 
 struct pasid_entry {
-	u64 val[8];
+	union {
+		u64 val[8];
+		u128 val128[4];
+	};
 };
 
 #define PASID_ENTRY_PGTT_FL_ONLY	(1)
@@ -297,6 +300,27 @@ static inline void pasid_set_eafe(struct pasid_entry *pe)
 	pasid_set_bits(&pe->val[2], 1 << 7, 1 << 7);
 }
 
+static inline bool pasid_support_hitless_replace(struct pasid_entry *pte,
+						 struct pasid_entry *new, int type)
+{
+	switch (type) {
+	case PASID_ENTRY_PGTT_FL_ONLY:
+	case PASID_ENTRY_PGTT_NESTED:
+		/* The first 128 bits remain the same. */
+		return READ_ONCE(pte->val[0]) == READ_ONCE(new->val[0]) &&
+			READ_ONCE(pte->val[1]) == READ_ONCE(new->val[1]);
+	case PASID_ENTRY_PGTT_SL_ONLY:
+	case PASID_ENTRY_PGTT_PT:
+		/* The second 128 bits remain the same. */
+		return READ_ONCE(pte->val[2]) == READ_ONCE(new->val[2]) &&
+			READ_ONCE(pte->val[3]) == READ_ONCE(new->val[3]);
+	default:
+		WARN_ON(true);
+	}
+
+	return false;
+}
+
 extern unsigned int intel_pasid_max_id;
 int intel_pasid_alloc_table(struct device *dev);
 void intel_pasid_free_table(struct device *dev);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 4f36138448d8..da7ab18d3bfe 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -452,7 +452,20 @@ int intel_pasid_replace_first_level(struct intel_iommu *iommu,
 
 	WARN_ON(old_did != pasid_get_domain_id(pte));
 
-	*pte = new_pte;
+	if (!pasid_support_hitless_replace(pte, &new_pte,
+					   PASID_ENTRY_PGTT_FL_ONLY)) {
+		spin_unlock(&iommu->lock);
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+		return intel_pasid_setup_first_level(iommu, dev, fsptptr,
+						     pasid, did, flags);
+	}
+
+	/*
+	 * A first-only hitless replace requires the first 128 bits to remain
+	 * the same. Only the second 128-bit chunk needs to be updated.
+	 */
+	intel_iommu_atomic128_set(&pte->val128[1], new_pte.val128[1]);
 	spin_unlock(&iommu->lock);
 
 	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
@@ -563,7 +576,19 @@ int intel_pasid_replace_second_level(struct intel_iommu *iommu,
 
 	WARN_ON(old_did != pasid_get_domain_id(pte));
 
-	*pte = new_pte;
+	if (!pasid_support_hitless_replace(pte, &new_pte,
+					   PASID_ENTRY_PGTT_SL_ONLY)) {
+		spin_unlock(&iommu->lock);
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+		return intel_pasid_setup_second_level(iommu, domain, dev, pasid);
+	}
+
+	/*
+	 * A second-only hitless replace requires the second 128 bits to remain
+	 * the same. Only the first 128-bit chunk needs to be updated.
+	 */
+	intel_iommu_atomic128_set(&pte->val128[0], new_pte.val128[0]);
 	spin_unlock(&iommu->lock);
 
 	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
@@ -707,7 +732,19 @@ int intel_pasid_replace_pass_through(struct intel_iommu *iommu,
 
 	WARN_ON(old_did != pasid_get_domain_id(pte));
 
-	*pte = new_pte;
+	if (!pasid_support_hitless_replace(pte, &new_pte,
+					   PASID_ENTRY_PGTT_PT)) {
+		spin_unlock(&iommu->lock);
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+		return intel_pasid_setup_pass_through(iommu, dev, pasid);
+	}
+
+	/*
+	 * A passthrough hitless replace requires the second 128 bits to remain
+	 * the same. Only the first 128-bit chunk needs to be updated.
+	 */
+	intel_iommu_atomic128_set(&pte->val128[0], new_pte.val128[0]);
 	spin_unlock(&iommu->lock);
 
 	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
@@ -903,7 +940,19 @@ int intel_pasid_replace_nested(struct intel_iommu *iommu,
 
 	WARN_ON(old_did != pasid_get_domain_id(pte));
 
-	*pte = new_pte;
+	if (!pasid_support_hitless_replace(pte, &new_pte,
+					   PASID_ENTRY_PGTT_NESTED)) {
+		spin_unlock(&iommu->lock);
+		intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+
+		return intel_pasid_setup_nested(iommu, dev, pasid, domain);
+	}
+
+	/*
+	 * A nested hitless replace requires the first 128 bits to remain
+	 * the same. Only the second 128-bit chunk needs to be updated.
+	 */
+	intel_iommu_atomic128_set(&pte->val128[1], new_pte.val128[1]);
 	spin_unlock(&iommu->lock);
 
 	intel_pasid_flush_present(iommu, dev, pasid, old_did, pte);
-- 
2.43.0

