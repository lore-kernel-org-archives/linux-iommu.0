Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3100365A08
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769046691; cv=none; b=Xd76Onf3O2BOeY1FNiiHJKFiQcsB0ptDUeHw7LsSAEINl1Y7jvJEfry/tAgTUnPNsMSu0w2AALbKqsBKzzUxvklHzmjV6UrUYuPU92VGSTRe25ozg8Lr+LhGIx/vABZRdVBE4GCosR7ONJJV5XX2fWFxT/nqQEKXM95P+XOSQRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769046691; c=relaxed/simple;
	bh=SsGMZADROTEU6smSqhYfvF4X4CchLTXShywLJIVw950=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dva3d82ETx+eqD5S91g9BIQyj7Dv9uZTGCzFoRGmpFDSP1ObXW3v/yg+G48mbEfsaWKgn6M17uydSJWijSMvoQIykIYz1BWjKr5R5X21jT80fOT04KhtPkfVZUzHYjHPLp/GdDIlDUWNgQs7T4P3kb0zbHjIeJyRRTlHQmzU7Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gA0nt51s; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gA0nt51s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769046690; x=1800582690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SsGMZADROTEU6smSqhYfvF4X4CchLTXShywLJIVw950=;
  b=gA0nt51si+C88pNbu/+yHLZUU8HPRrFJlAXMFO2ar24CfuG+UsEwYYEw
   Z8Afj+OyToZDaPREJ9t1iuxlnulnihMvnbU+i1O0Xswz1mjTRDq+gMrqS
   Dh3hnDUHo3SdUA6iZFFKGfSw2XvyCZEqgBPAHecUnyAMJnYISEWYWRbHJ
   sTSSw+cas7+vTe0toyfXcYOJb6tby1O6t5FyOXYMVBDLPUghrKpxcbndg
   I6OWZbW6neLBmsZ1HM6y+2qlP5Ov2gDQ1x9k8CKXXnFuktfNR2jDrHqhQ
   HKt5bkA1L+keueGnpc1kCC0Fr/fT1z7w1TBr2EBOwK48KTPG6lQWBQoU6
   w==;
X-CSE-ConnectionGUID: rV6/Xu01RvSCV0RPtPhf/A==
X-CSE-MsgGUID: 29yiCv6cSyC5PlTl6FQZMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="81393047"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="81393047"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 17:51:29 -0800
X-CSE-ConnectionGUID: PI0C6/2bTDarPwRZ2ahLBg==
X-CSE-MsgGUID: 2H/VUMfNTYW8ugnJS+pLnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="211455636"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa004.fm.intel.com with ESMTP; 21 Jan 2026 17:51:27 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	Jinhui Guo <guojinhui.liam@bytedance.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] iommu/vt-d: Flush cache for PASID table before using it
Date: Thu, 22 Jan 2026 09:48:52 +0800
Message-ID: <20260122014856.2457052-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
References: <20260122014856.2457052-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmytro Maluka <dmaluka@chromium.org>

When writing the address of a freshly allocated zero-initialized PASID
table to a PASID directory entry, do that after the CPU cache flush for
this PASID table, not before it, to avoid the time window when this
PASID table may be already used by non-coherent IOMMU hardware while
its contents in RAM is still some random old data, not zero-initialized.

Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer coherency")
Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20251221123508.37495-1-dmaluka@chromium.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 99692f88b883..6379b211f12b 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -153,6 +153,9 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 		if (!entries)
 			return NULL;
 
+		if (!ecap_coherent(info->iommu->ecap))
+			clflush_cache_range(entries, VTD_PAGE_SIZE);
+
 		/*
 		 * The pasid directory table entry won't be freed after
 		 * allocation. No worry about the race with free and
@@ -165,10 +168,8 @@ static struct pasid_entry *intel_pasid_get_entry(struct device *dev, u32 pasid)
 			iommu_free_pages(entries);
 			goto retry;
 		}
-		if (!ecap_coherent(info->iommu->ecap)) {
-			clflush_cache_range(entries, VTD_PAGE_SIZE);
+		if (!ecap_coherent(info->iommu->ecap))
 			clflush_cache_range(&dir[dir_index].val, sizeof(*dir));
-		}
 	}
 
 	return &entries[index];
-- 
2.43.0

