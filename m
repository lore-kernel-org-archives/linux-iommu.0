Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243B715B0E2
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672862; cv=none; b=J0NL7yWPrB/ASEi5qveACJxvz0U/K5Iyo8AuHG84bq/+NMDviRJiNY257EVQ/0+fyQuU5MN3OE+JaCR3ftQWEb/p3CJAGttsVZ5QeBXZ7CFF5tqI8eaIEIGkQwzRtYZQ0F0Y6axRqdHVADKb0zdYREP8OMcJm6AWEtnAenZu0b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672862; c=relaxed/simple;
	bh=TKfb3FYCYQ9R4HYL6swULU5MIrnn5Cj8544DnGCTNMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJiOKQC2HFl0kxd2CexrUcfIpHqsN92mfVU37Rs6cSgyGIsZVHCeZmCo5oS3oNK9xpqfZHNAxbvOSu59yHBuSAZqKLCWn3vu/54wkInB1K+GBqYnteY86o6+hzbMYOUjv0s481L3VZ/6cM15LmtKbnHJ916bxq+99PdY+Bxt8O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K2LaB2Ga; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K2LaB2Ga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729672860; x=1761208860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKfb3FYCYQ9R4HYL6swULU5MIrnn5Cj8544DnGCTNMs=;
  b=K2LaB2GaYNJF7ftXQFtHG90DX5ArNrm//U15BU7w5Jg9Jhqu+RH4DUwQ
   ZP8Ui+daqnvKlkGfeyL7WPIX9F/5Apzqme1bURA1fWt8R3uI3IKnZbZ1J
   dcu8lzg3b7R/L1rbD5ST6kDrH8B2bU2nyQoX8eHIqIAnfahz3JJ2AS/G/
   UyKqynShVgsGYH8uQZ7rob6O8TMj42Tyn1y5oxh/NRTORY6LTWk2mNVc4
   hTXOMZF5B3SLj1HXBwAzH8crIA/EtkYaDdnOqYnY2kbA+sd2fXRcOT0d5
   CuPFeQKrem/qMao9tL5Vqi1utnJnFuIQ92O262F10LSTCZd0OfqXrCMI/
   g==;
X-CSE-ConnectionGUID: qwolXUltTOCVlMxd82gztw==
X-CSE-MsgGUID: EC55EbyjRC2Xl+lK0+NgiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="32108931"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="32108931"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:40:55 -0700
X-CSE-ConnectionGUID: izdtrW4jQui9uoZNttvzlg==
X-CSE-MsgGUID: Ll37NpZ0SEaUlz7oTass9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80048654"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:40:52 -0700
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
Subject: [PATCH v2 1/2] iommu/vt-d: Fix checks in dmar_fault_dump_ptes()
Date: Wed, 23 Oct 2024 16:37:14 +0800
Message-Id: <20241023083715.582149-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023083715.582149-1-zhenzhong.duan@intel.com>
References: <20241023083715.582149-1-zhenzhong.duan@intel.com>
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

Fix it by checking present bit of an entry before dump its content.

Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
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

