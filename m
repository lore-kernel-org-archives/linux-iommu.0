Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7FA1BC58
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 03:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724123167; cv=none; b=u6qNvUb5VW4xTPQtjprGuioMm5+B9PoY029f1YADA398aBK3c3kFVWRIFILAdR2R7g23xsK72O1gznqEqgING4icVLc5RXBNvQGk6JzIw4V8mkt1DYbsVNVCa92QIK5Ce4ICnixKwd2mKl2ukxIce4VPYKTD8p4PU5YFdzMg638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724123167; c=relaxed/simple;
	bh=D4NWc1ISe5L1Y95LSqKQcLDmDgdsikzzYZ3vCOvQJCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kQ1+giHgEtQFFlT3b/Oma6+kzH3+RK306obh8iqa1JlzWixNBhXcUEMReJ6ln4bNoaIUfYskgMB7gNTLhia43yWzGuxE1YilneIhKrPKpcznvk94JQjAVwizqtNy2w10oYl1FoVnTEVelXMBeSeN/5FetZAPTCpbaSHG4MR51iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BOoI5B0e; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOoI5B0e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724123167; x=1755659167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D4NWc1ISe5L1Y95LSqKQcLDmDgdsikzzYZ3vCOvQJCI=;
  b=BOoI5B0eqT74GEcqjZTUIZacWZ+53rpS5RfqoNOtv9WpXG8rpz06a8Hy
   bSg0M7cM3M7yE6gqkxQsckM7XcohrBFpBlvvbBEyKxa+vpX4SAisSO8PT
   88VewOKZo6SvdtINA65uWxdapEvIUGMW+n+S2RIRymVyTB1+ovrMRBPLS
   QreZot39ux5Wkh2eUF/Wymkje9xojhcFkAsiGwRjdMfozqptwmLAnOKwH
   QNqMZY1eS7Me3xyegsN/LToUwkfC5LN3xkRNaLyapx/PUomsWANjd71fC
   efI7U7Kq9ubY0pt8Jj5JWzx66BguAbGdqL71IccH0C4XwJP+1kQI4Qx36
   A==;
X-CSE-ConnectionGUID: z1jYYc+qRyqYpib82RmaYg==
X-CSE-MsgGUID: JxwxRZWgSx6TlX3btDIQ4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22542954"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="22542954"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 20:05:50 -0700
X-CSE-ConnectionGUID: UHCmsldzR7S+yyCbUDK9Zw==
X-CSE-MsgGUID: H38gDz3ISSykmFz1pLykiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="65395406"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 19 Aug 2024 20:05:48 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Unconditionally flush device TLB for pasid table updates
Date: Tue, 20 Aug 2024 11:02:08 +0800
Message-Id: <20240820030208.20020-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The caching mode of an IOMMU is irrelevant to the behavior of the device
TLB. Previously, commit <304b3bde24b5> ("iommu/vt-d: Remove caching mode
check before device TLB flush") removed this redundant check in the
domain unmap path.

Checking the caching mode before flushing the device TLB after a pasid
table entry is updated is unnecessary and can lead to inconsistent
behavior.

Extends this consistency by removing the caching mode check in the pasid
table update path.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/pasid.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 5792c817cefa..dc00eac6be31 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -264,9 +264,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	else
 		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
 /*
@@ -493,9 +491,7 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
 
 	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 
 	return 0;
 }
@@ -572,9 +568,7 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
 	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
 
-	/* Device IOTLB doesn't need to be flushed in caching mode. */
-	if (!cap_caching_mode(iommu->cap))
-		devtlb_invalidation_with_pasid(iommu, dev, pasid);
+	devtlb_invalidation_with_pasid(iommu, dev, pasid);
 }
 
 /**
-- 
2.34.1

