Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9519995D
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729590807; cv=none; b=pjGyO3KoOcnwkBrrM4+F338DMwH6zki5f5NHtR4RZcqN1n4ShRtT6t6Dbk2kXlGbb8U7U2N6Y2FtloaPAc1O6YmR2MWhkNSmhAEKwXv4AW0X3pxCBlRSB2GOuR0pyvMrjNGJfY3Q6PvQUltHwuJoX7eVBg4xBtX/BUaxCYXB/34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729590807; c=relaxed/simple;
	bh=Z/F6SkUpljXci2a8Q61yoocqs/lynbRbpXoFGemFnjc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EyLxfos2gvhVsN30yCgK7GWGbU2AwpHoqz553TWJl7fyR/82bUujymJPudT22y/q7Djj5O7hqhboaqZhOIkfx4vvpzi+PP4QJdypf7wDRrdjVhfufiI+C2z68hP1f18dJC5BC/y993BqnoIQA+7CYda+KUOpmfNtDZMsiHGv2iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fj/5eNIh; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fj/5eNIh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729590806; x=1761126806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z/F6SkUpljXci2a8Q61yoocqs/lynbRbpXoFGemFnjc=;
  b=fj/5eNIhGkZHjg37zs+y7bySBWNxOF5Kz7gL9VZl19jR+wWn9b+wQHT8
   mQcegVmsI7cpJ5+My5WAjHsjL9VhfAi3IBPKp09Pmf4lppoP03MfhSvDO
   Bj8WWFOfBk5jFCTKmb3g6+BdFMr+cXnPZH9altCET4xmlFYZ8ITPNABSS
   fq8DoNDX5Rm62n03YrOtdlL+v7lzwVzGIIbC7HeRDovOt2+8coN8+R/V1
   77MTWZrdtM0NGy+DslWZuqj49qWVLJLk/0f6JlhC8495TvRNCv1xzgmOL
   DE1ad87MAXn/IxsmUtG2OsgsFpC4QexA1dodRXSucxsNqqgChKaqQV1jN
   w==;
X-CSE-ConnectionGUID: XjKLB/loR2OSqeRK9Kbg/A==
X-CSE-MsgGUID: VvkKtLXBRwCgeyUdcRuadQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="31976832"
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="31976832"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:53:26 -0700
X-CSE-ConnectionGUID: 8dWegeQSRIWPgt7RJuYuvg==
X-CSE-MsgGUID: lknjUmMLTIS5ltfXgZKzMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,222,1725346800"; 
   d="scan'208";a="84412642"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 02:53:23 -0700
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
Subject: [PATCH 2/2] iommu/vt-d: Fix checks in pgtable_walk()
Date: Tue, 22 Oct 2024 17:50:17 +0800
Message-Id: <20241022095017.479081-3-zhenzhong.duan@intel.com>
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

It's not accurate to dump super page as non-present page,
meanwhile bit7 in first level page table entry is PAT bit,
also pointer pte is never NULL in pgtable_walk() context.

Fixes: 914ff7719e8a ("iommu/vt-d: Dump DMAR translation structure when DMA fault occurs")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 drivers/iommu/intel/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8288b0ee7a61..fec5cc1147f3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -707,14 +707,14 @@ static void pgtable_walk(struct intel_iommu *iommu, unsigned long pfn,
 	while (1) {
 		offset = pfn_level_offset(pfn, level);
 		pte = &parent[offset];
-		if (!pte || (dma_pte_superpage(pte) || !dma_pte_present(pte))) {
+		if (!dma_pte_present(pte)) {
 			pr_info("PTE not present at level %d\n", level);
 			break;
 		}
 
 		pr_info("pte level: %d, pte value: 0x%016llx\n", level, pte->val);
 
-		if (level == 1)
+		if (level == 1 || dma_pte_superpage(pte))
 			break;
 
 		parent = phys_to_virt(dma_pte_addr(pte));
-- 
2.34.1

