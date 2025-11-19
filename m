Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6072FF157
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763529511; cv=none; b=XBvMu+UGV/rrsDtWN+jUX3aTR/hXpjvCx1YfDhY1pqJ3DYlgD7kVILAPsPXv+zAlCRbTRMneK0czz0lJaafIoI+DolguZPzcSKjHIqZnFXDgOsEZOJdC66D5LWhsfRd6NlDTCoyxeF56Z49m4g86vnFG8E0nlioOoSnyvas6CaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763529511; c=relaxed/simple;
	bh=kuBNU3NpDDQpR+usXd3D141ujyj/uB6KnO0r1vqyZ4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Juydq3ysfnEH24zdaSVb2nbr5rnxov1lHqBQGoy9gSvLCn69KHhzoDb0t66CH8prym5v8ElwuzEDUP95nagPcSa/Z/3Ja0L1g64wCDJOkA4xAEEttpnXrxADk+sOXqSuzEhnnRjQsrxxameJl2dZPtjYi4Ew4a5/HZ/3D0Exiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQLM/QNW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQLM/QNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763529510; x=1795065510;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kuBNU3NpDDQpR+usXd3D141ujyj/uB6KnO0r1vqyZ4g=;
  b=WQLM/QNWEhTqQR3tW1YwU/rmP/wpzrFon97XG9rbfNeofBkCVOL+T0Ww
   vkt7lQtGG+SQgIDLxh/wkCVo9xmEXgVPgIGTLGuf1jbeFuC7rplfPArkg
   ZLWkI9XGqq4Usp+bh0tGt2p6xuBrOaOfXEiQNhzOjAl+cvcI1S0JdxpHb
   tZfaeVQElEs0qBha1+kXC6LDvNvj/Nk+ITwmEKhvox+r9S5cJNF238IH1
   ZCqVXlFJkfUjSYSDs8FXMb8D8+YVL21W91LFDb5Gy19fYPGbWtGCvikTJ
   i39Z4DUdq3J4et9p8XLzslgib/FydeW2q4bua9+Z/ywsSpURKW7I1piNv
   g==;
X-CSE-ConnectionGUID: 4/Mho7ztRr+2JQwtSbeHsw==
X-CSE-MsgGUID: yxG4U0ITR063o1/8vWcwFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65604701"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65604701"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 21:18:30 -0800
X-CSE-ConnectionGUID: XtroQH6PTueRdu8mDuY6TA==
X-CSE-MsgGUID: TSH49TmvTlKliW+/NSrX2w==
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 21:18:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/vt-d: Fix unused invalidation hint in qi_desc_iotlb
Date: Wed, 19 Nov 2025 13:16:13 +0800
Message-ID: <20251119051613.2604261-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119051613.2604261-1-baolu.lu@linux.intel.com>
References: <20251119051613.2604261-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aashish Sharma <aashish@aashishsharma.net>

Invalidation hint (ih) in the function 'qi_desc_iotlb' is initialized
to zero and never used. It is embedded in the 0th bit of the 'addr'
parameter. Get the correct 'ih' value from there.

Fixes: f701c9f36bcb ("iommu/vt-d: Factor out invalidation descriptor composition")
Signed-off-by: Aashish Sharma <aashish@aashishsharma.net>
Link: https://lore.kernel.org/r/20251009010903.1323979-1-aashish@aashishsharma.net
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3056583d7f56..dcc5466d35f9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1097,7 +1097,7 @@ static inline void qi_desc_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 				 struct qi_desc *desc)
 {
 	u8 dw = 0, dr = 0;
-	int ih = 0;
+	int ih = addr & 1;
 
 	if (cap_write_drain(iommu->cap))
 		dw = 1;
-- 
2.43.0

