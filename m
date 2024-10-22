Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55E196DA2
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590804; cv=none; b=JDdfDGTF8SzNtTDQ7L9BNiQQ7gRCBnWACh67QiwpOGemby662pG5EEa5WspuKAPfpJ8bRbMmKhJ1YTVCFObN8iVJWezi/h+Vyc3DprmUh0fv3PsQxoDGhxLvpBgFQ4TB+tYqHU3wYVEHGT1ur02s0cF09zEOksTdSjh1COWhlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590804; c=relaxed/simple;
	bh=vhXxUumZV/ND0LwAlvGNUtYRRyRAOFMzsBRrz5SZqDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rBTOzevMvyBVNcF0SrCMT/gAH3YeAjZSHEbBYQopdVeH6ai8+GQa6ro+UrvlS82qHsGR5YFIrhCZS+LEA6jXkvRGFAqVDFsMJhr8y1yIOz6Fc5D/Q0Rv0OOnfXrXQitmPYYPlaEYkSPTtuHR6cIEO5Cp364cfl564X7pBQdJJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OncEXgZJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OncEXgZJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729590803; x=1761126803;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vhXxUumZV/ND0LwAlvGNUtYRRyRAOFMzsBRrz5SZqDU=;
  b=OncEXgZJ8tv+MBBarKFYiWFSncnF9gAtU/3v6dL9WyoEA8K6W4eNl02p
   aQXf7n4YDKmZOjYSS+pducz2ys6HNoswN6rxtxsANyb31djSS+dCd4Ajs
   fkukaF9js347yZNoW9NR6c4l/G9tk+6PUu2+1Z75S843uKi6IdXsDwEG0
   af7x+cTx9wQ9cGoB1EwhMhk9aSrwEa7TQJmJrW2Vw6lVSYox+ZVqCMnD7
   dvuLW3MmNapX44nnCfkJIjm+e7QMkmUwntIJpINDm5ofC7mE1tk/yY2et
   /LyUZlYJQtBj9ew1/MxXAqae+TjRrg1BMvHWv/ST/w9zDcG+ZN0CoTsI0
   Q==;
X-CSE-ConnectionGUID: I32Yi/HIQzu/8AHj+droYA==
X-CSE-MsgGUID: O85pfqAiSNuCP1cIrMGAoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="31976806"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="31976806"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:53:23 -0700
X-CSE-ConnectionGUID: QN0kUc6CR0m4z1OmiuB5eg==
X-CSE-MsgGUID: MxGcUg1zSdiZmUJWNl2HNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84412597"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:53:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: dwmw2@infradead.org,
	baolu.lu@linux.intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	chao.p.peng@intel.com,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 1/2] iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
Date: Tue, 22 Oct 2024 17:50:16 +0800
Message-Id: <20241022095017.479081-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022095017.479081-1-zhenzhong.duan@intel.com>
References: <20241022095017.479081-1-zhenzhong.duan@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In dmar_fault_dump_ptes(), return value of phys_to_virt() is used for
checking if an entry is present. It's never NULL on x86 platform at least.
This makes some zero entries are dumped like below:

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

Fix it by checking present bit in all entries.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/iommu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a564eeaf2375..8288b0ee7a61 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -733,12 +733,17 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 	u8 devfn = source_id & 0xff;
 	u8 bus = source_id >> 8;
 	struct dma_pte *pgtable;
+	u64 entry;
 
 	pr_info("Dump %s table entries for IOVA 0x%llx\n", iommu->name, addr);
 
 	/* root entry dump */
 	rt_entry = &iommu->root_entry[bus];
-	if (!rt_entry) {
+	entry = rt_entry->lo;
+	if (sm_supported(iommu) && devfn >= 0x80)
+		entry = rt_entry->hi;
+
+	if (!(entry & 1)) {
 		pr_info("root table entry is not present\n");
 		return;
 	}
@@ -766,28 +771,32 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
 		goto pgtable_walk;
 	}
 
+	/* For request-without-pasid, get the pasid from context entry */
+	if (pasid == IOMMU_PASID_INVALID)
+		pasid = IOMMU_NO_PASID;
+
 	/* get the pointer to pasid directory entry */
 	dir = phys_to_virt(ctx_entry->lo & VTD_PAGE_MASK);
-	if (!dir) {
+	dir_index = pasid >> PASID_PDE_SHIFT;
+	pde = &dir[dir_index];
+
+	if (!pasid_pde_is_present(pde)) {
 		pr_info("pasid directory entry is not present\n");
 		return;
 	}
-	/* For request-without-pasid, get the pasid from context entry */
-	if (intel_iommu_sm && pasid == IOMMU_PASID_INVALID)
-		pasid = IOMMU_NO_PASID;
 
-	dir_index = pasid >> PASID_PDE_SHIFT;
-	pde = &dir[dir_index];
 	pr_info("pasid dir entry: 0x%016llx\n", pde->val);
 
 	/* get the pointer to the pasid table entry */
-	entries = get_pasid_table_from_pde(pde);
-	if (!entries) {
+	entries = phys_to_virt(READ_ONCE(pde->val) & PDE_PFN_MASK);
+	index = pasid & PASID_PTE_MASK;
+	pte = &entries[index];
+
+	if (!pasid_pte_is_present(pte)) {
 		pr_info("pasid table entry is not present\n");
 		return;
 	}
-	index = pasid & PASID_PTE_MASK;
-	pte = &entries[index];
+
 	for (i = 0; i < ARRAY_SIZE(pte->val); i++)
 		pr_info("pasid table entry[%d]: 0x%016llx\n", i, pte->val[i]);
 
-- 
2.34.1

