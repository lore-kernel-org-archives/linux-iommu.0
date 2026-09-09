Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBEE4A440B
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941001; cv=none; b=NOQ08h2GvnLlUwE7+oRN8+9hblm0GYfyO/niohBlftisRTE6ICIa0IrMO3j2gpTtHPlyAAW2v70btmQl7blqqd6jY/uWPpQMdA/V6NIdMgFT7wbxywZ6xT/y1+Oy7c8rGSyPnVwCc694gGt6YEbtB8o02/qvNp8gyMW89hyWzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941001; c=relaxed/simple;
	bh=2oJBUice+6l/lTky/rYxdZCKGsJLulR5hMAIr01sGnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwVI2RLqTxnA05MX7QO6P9XeYwYueRUl6YjZ1+91cYTX7KI2gR/isyQLqjUm4Q/xwvAkENF6K9jLiF3drfY5XeD1nxAdkR/VQoRA/lbY0GIRlEwEHghW+38A7F3BZEzQiirzx79cGZlVx8l8QFBf8rBDTDnrtYnV6GGOnHFqBNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMFNyjtr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMFNyjtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788941001; x=1820477001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2oJBUice+6l/lTky/rYxdZCKGsJLulR5hMAIr01sGnE=;
  b=YMFNyjtr0V00oE0vU1eArA4RK8qBsqg2xFZDNfxoRdH9h+qR72X9HM8S
   FBMaq98uHZDRBx5/SFNjc1/EvjNeeAlhrjr7dSRcOpkUBKq/2dZ27L8Os
   jw4cWN/hTRKqAcLs8cqcHXky4qHcpsGJIac4zCMh1tHYNKwY89Fc0TfrR
   vHa9mbnDgfbE6Wv1lLP7ySNv1ddrOcDsBwWPuG/eBMWdm38FZT6hnJCXt
   +FYbaMKZK+3GXvRO2K/NoHWyaafBf3uuV1Szbb9Bg/Z/9ZQ8l1jWuBZfT
   4M1ex1HejsMpHSz6Mu+R50GN4CUoAUr92eRFod+PPHrvEtD74qgzAJGtK
   A==;
X-CSE-ConnectionGUID: /xnEyTXaTpaBEXn2bobvwA==
X-CSE-MsgGUID: TANktg8mRmy7yRnbYrE8Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106726505"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106726505"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:03:21 -0700
X-CSE-ConnectionGUID: 47K9RuMvTVKmSVwvGuS27g==
X-CSE-MsgGUID: 0sHulKHmQSCrOfjHg4/Rgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301119276"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2026 01:03:18 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 5/7] iommu/vt-d: Use old domain parameter when attaching the blocking domain
Date: Wed,  9 Sep 2026 15:51:04 +0800
Message-ID: <20260909075106.738691-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909075106.738691-1-baolu.lu@linux.intel.com>
References: <20260909075106.738691-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

blocking_domain_attach_dev() drops the old domain’s iopf reference using
info->domain, but that value may already be cleared by
device_block_translation().

On attach failure fallback paths, this can cause the function to drop a
NULL-domain ref instead of @old, leaking the real old-domain reference.
Repeated leaks grow info->iopf_refcount, keep the device stuck on the
iopf queue, and can trigger WARN_ON(info->iopf_refcount) when PRI is
disabled.

Use the core-provided @old parameter directly. It always identifies the
correct domain to release and matches other attach paths.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5553c57130f7..99cf6716f602 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2899,9 +2899,7 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
 				      struct device *dev,
 				      struct iommu_domain *old)
 {
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-
-	iopf_for_domain_remove(info->domain ? &info->domain->domain : NULL, dev);
+	iopf_for_domain_remove(old, dev);
 	device_block_translation(dev);
 	return 0;
 }
-- 
2.43.0

