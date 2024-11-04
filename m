Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A08198A0E
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684501; cv=none; b=E1i3V/9IjtnEFGsfKLGa+V7ROoPNkbpTjJPitZ+zxAnyz7LIbIl3XuV0pC9olJqbBfw+nYqSZsIju8YlxAU3I/T0cjXK7gyZPy9JyWC5/xSIJ8iNnUrK20Cs4MuZo7jcLUOPwuO3StjPBfALNbX2KhNJn79dZNd/ZTb46ZB5FJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684501; c=relaxed/simple;
	bh=84kN1mbv6oOi3fz8ZMAtSPfybriRKGybJV3vaR1CgJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJVJad/9LXloy/S/ix1NwbWeW4yQQGMaPEmqVVnNFsagCRP/9TECPDm0sLyuw0zwTVDTCyaMaGawM72wnPItYeYDhl7YBo024FBAlPL8MhfEdw+Cef2DMjs1JD/lecoXOhRCPXsf/vOaYJ67wm6c68VrFWZpnYHJ12JrWBNwiuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDHvWJfg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDHvWJfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684500; x=1762220500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=84kN1mbv6oOi3fz8ZMAtSPfybriRKGybJV3vaR1CgJ8=;
  b=fDHvWJfg70SeFk+BD9uRWwo1IbgHcf63jcUpNZFlGS7XyLL+p/R41fgf
   4T7r9qNqZIwP1ikFI1sHUb+PvHAKwqL4MX7jtLWWSDis2k36CycozXlsK
   e40GiCoH7X8qVjO3O6bKgnQPjubDSS+jtThMXpszZORsSMfCu43qCkUUi
   K80uDDk06GVkZywwUzHK4W+zTbvxenSE+DFq2UfB+LVkqLRY6JDv5cBAI
   RRZ/AuWMVkdCRmxvL7cx/GrZJ6OjkadZhMf2LrcSG3MYW5xL4bIl2td8u
   xy59NM7IwPHCCbo9XUZJGDqzmvbPygPmd5mmepduHS39yk9HTBptXyxnU
   Q==;
X-CSE-ConnectionGUID: FPE6O+UxRzWGeGPw4yvgYg==
X-CSE-MsgGUID: bbeDNmtARN28oaIcEqmH8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221948"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221948"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:40 -0800
X-CSE-ConnectionGUID: 4Kw3quI3Q7KFYxA7pj+2iQ==
X-CSE-MsgGUID: k+b6LQ77RO6ohATe3YHmRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020892"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:39 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/19] iommu/vt-d: Fix checks and print in pgtable_walk()
Date: Mon,  4 Nov 2024 09:40:33 +0800
Message-ID: <20241104014040.106100-14-baolu.lu@linux.intel.com>
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

There are some issues in pgtable_walk():

1. Super page is dumped as non-present page
2. dma_pte_superpage() should not check against leaf page table entries
3. Pointer pte is never NULL so checking it is meaningless
4. When an entry is not present, it still makes sense to dump the entry
   content.

Fix 1,2 by checking dma_pte_superpage()'s returned value after level check.
Fix 3 by removing pte check.
Fix 4 by checking present bit after printing.

By this chance, change to print "page table not present" instead of "PTE
not present" to be clearer.

Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Link: https://lore.kernel.org/r/20241024092146.715063-3-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 96d40e0268a2..b7351d81b77d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -596,14 +596,15 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
 	while (1) {
 		offset = pfn_level_offset(pfn, level);
 		pte = &parent[offset];
-		if (!pte || (dma_pte_superpage(pte) || !dma_pte_present(pte))) {
-			pr_info("PTE not present at level %d\n", level);
-			break;
-		}
 
 		pr_info("pte level: %d, pte value: 0x%016llx\n", level, pte->val);
 
-		if (level == 1)
+		if (!dma_pte_present(pte)) {
+			pr_info("page table not present at level %d\n", level - 1);
+			break;
+		}
+
+		if (level == 1 || dma_pte_superpage(pte))
 			break;
 
 		parent = phys_to_virt(dma_pte_addr(pte));
-- 
2.43.0

