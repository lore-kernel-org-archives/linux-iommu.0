Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6111AE001
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761901; cv=none; b=a4bP3uinKoR4iX+Ca+Cgc15zD1D5jTY57ccTqgNjLlCXeSldhz1D+ttTlDJLuc1Srpsl3kpz9sf59ykTt9DERW8Rz6ilmzIFxj3hevwZLs6L4QCDGJCUnrZyXvGengODEvFGnmshX4ZT5NWWIhpLzmvRBk/h2WL2DilCZV3LFRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761901; c=relaxed/simple;
	bh=yWcx+J+t1863Iuh/mMCSpJaiqMpAsIEREh4AZVcBGEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S4D7MSSZ4hz/iGtHAMvDudzvmwjW6eo3QLCcXrXI8IjPHUUTqX80kaWTqE1aP0JCL8zFSeWnFQOEtyGfO3vlWOoQR0En7umjk1MdI2kRnRpIRUXh9KUzwoWNTS4hzuSY5fxs2NNlK6XIG5GLtFLta9ZFERxCujIrA0BmmFH345c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=apfA1nQ3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="apfA1nQ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729761899; x=1761297899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yWcx+J+t1863Iuh/mMCSpJaiqMpAsIEREh4AZVcBGEY=;
  b=apfA1nQ3H5vpviKa563h75s5l1xDHkAGybpBuTzlNIvVolOugeJZ9nLH
   alDvQybgJpqp0rKVCtYoxjxY1Z+cuwkt5+wFXHtFXvVWGduG29dVRrKt9
   s7jJrCPeWOm/L/uSR2SncAkz3Rr5trn3HLCUBKbvPKZYxQJeAlvQfb57w
   xD1t0BgZyBW2lusJ77t6Z9hJtLKgS7yQxbZry/nGTPmihAqz0Rgity1o3
   VcPmvSwZQYPkmSx8OSAn0+nS5WZ4LlJdZlMrgJrMMHwSSol3nx2gch/tn
   VK0SM9b1C9Lt2Gy+EHzgIjkpFJoFFTCVkzXm+AlOQr8umbibbu4ubyMFZ
   g==;
X-CSE-ConnectionGUID: CmZghbRzR+6i5F4GkRVViQ==
X-CSE-MsgGUID: xD9YpoFiQHOcV8ldWT+72Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="40501248"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="40501248"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 02:24:59 -0700
X-CSE-ConnectionGUID: Zx77NExaRY6vmWKfmx7Mew==
X-CSE-MsgGUID: KglRZbw0Sw2AYcfkQfRgVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80705038"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 02:24:56 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	chao.p.peng@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Kyung Min Park <kyung.min.park@intel.com>
Subject: [PATCH v3 1/2] iommu/vt-d: Fix checks and print in dmar_fault_dump_ptes()
Date: Thu, 24 Oct 2024 17:21:45 +0800
Message-Id: <20241024092146.715063-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024092146.715063-1-zhenzhong.duan@intel.com>
References: <20241024092146.715063-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some issues in dmar_fault_dump_ptes():

1. return value of phys_to_virt() is used for checking if an entry is
   present.
2. dump is confusing, e.g., "pasid table entry is not present", confusing
   by unpresent pasid table vs. unpresent pasid table entry. Current code
   means the former.
3. pgtable_walk() is called without checking if page table is present.

Fix 1 by checking present bit of an entry before dump a lower level entry.
Fix 2 by removing "entry" string, e.g., "pasid table is not present".
Fix 3 by checking page table present before walk.

Take issue 3 for example, before fix:

[  442.240357] DMAR: pasid dir entry: 0x000000012c83e001
[  442.246661] DMAR: pasid table entry[0]: 0x0000000000000000
[  442.253429] DMAR: pasid table entry[1]: 0x0000000000000000
[  442.260203] DMAR: pasid table entry[2]: 0x0000000000000000
[  442.266969] DMAR: pasid table entry[3]: 0x0000000000000000
[  442.273733] DMAR: pasid table entry[4]: 0x0000000000000000
[  442.280479] DMAR: pasid table entry[5]: 0x0000000000000000
[  442.287234] DMAR: pasid table entry[6]: 0x0000000000000000
[  442.293989] DMAR: pasid table entry[7]: 0x0000000000000000
[  442.300742] DMAR: PTE not present at level 2

After fix:
...
[  357.241214] DMAR: pasid table entry[6]: 0x0000000000000000
[  357.248022] DMAR: pasid table entry[7]: 0x0000000000000000
[  357.254824] DMAR: scalable mode page table is not present

Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/iommu.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a564eeaf2375..e7a711a42528 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -737,11 +737,11 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	pr_info("Dump %s table entries for IOVA 0x%llx\n", iommu->name, addr);
 
 	/* root entry dump */
-	rt_entry = &iommu->root_entry[bus];
-	if (!rt_entry) {
-		pr_info("root table entry is not present\n");
+	if (!iommu->root_entry) {
+		pr_info("root table is not present\n");
 		return;
 	}
+	rt_entry = &iommu->root_entry[bus];
 
 	if (sm_supported(iommu))
 		pr_info("scalable mode root entry: hi 0x%016llx, low 0x%016llx\n",
@@ -752,7 +752,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	/* context entry dump */
 	ctx_entry = iommu_context_addr(iommu, bus, devfn, 0);
 	if (!ctx_entry) {
-		pr_info("context table entry is not present\n");
+		pr_info("context table is not present\n");
 		return;
 	}
 
@@ -761,17 +761,23 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 
 	/* legacy mode does not require PASID entries */
 	if (!sm_supported(iommu)) {
+		if (!context_present(ctx_entry)) {
+			pr_info("legacy mode page table is not present\n");
+			return;
+		}
 		level = agaw_to_level(ctx_entry->hi & 7);
 		pgtable = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
 		goto pgtable_walk;
 	}
 
-	/* get the pointer to pasid directory entry */
-	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
-	if (!dir) {
-		pr_info("pasid directory entry is not present\n");
+	if (!context_present(ctx_entry)) {
+		pr_info("pasid directory table is not present\n");
 		return;
 	}
+
+	/* get the pointer to pasid directory entry */
+	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
+
 	/* For request-without-pasid, get the pasid from context entry */
 	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
 		pasid = IOMMU_NO_PASID;
@@ -783,7 +789,7 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	/* get the pointer to the pasid table entry */
 	entries = get_pasid_table_from_pde(pde);
 	if (!entries) {
-		pr_info("pasid table entry is not present\n");
+		pr_info("pasid table is not present\n");
 		return;
 	}
 	index = pasid & PASID_PTE_MASK;
@@ -791,6 +797,11 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	for (i = 0; i < ARRAY_SIZE(pte->val); i++)
 		pr_info("pasid table entry[%d]: 0x%016llx\n", i, pte->val[i]);
 
+	if (!pasid_pte_is_present(pte)) {
+		pr_info("scalable mode page table is not present\n");
+		return;
+	}
+
 	if (pasid_pte_get_pgtt(pte) == PASID_ENTRY_PGTT_FL_ONLY) {
 		level = pte->val[2] & BIT_ULL(2) ? 5 : 4;
 		pgtable = phys_to_virt(pte->val[2] & VTD_PAGE_MASK);
-- 
2.34.1

