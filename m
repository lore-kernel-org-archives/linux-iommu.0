Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970C138DF2
	for <iommu@lists.linux.dev>; Mon,  2 Sep 2024 02:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725244300; cv=none; b=O3O/+/CtLWujFSsipyF6d+RUw4Rqs2UzC2cUMFraLbwRhWPLzc5jnLaQQP8t0P320DU1Jvwav6SnFStMjHHpmAmrABrZjoU2mO4X4MixqNrcM+PkzhL+acJwJFjeqlGNqYK0TPjLOHWDU1GaoQ8YKfHELGoDa7QAi+XBJRLss44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725244300; c=relaxed/simple;
	bh=GtutiaUzGKFbzKvh3xEoisjtlmPo8NKbdxyJU2Gn1lA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ws8GAnwCmUM9IT8bG9VK2u0/H6J92IsdJ7J8ocaZqb1rNHXXWOy+EwUmOWawr49Th4ujJ94VqdT8zqEpcsyLzMVb+nMUdGCp8ZvSdOcTqA6NTKRZyMhe1/+CXGUoXMNtEZK32xaagLFZiNepeXcoqamodTDaLho0iplN7uzNSvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aNMeWGzz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aNMeWGzz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725244299; x=1756780299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GtutiaUzGKFbzKvh3xEoisjtlmPo8NKbdxyJU2Gn1lA=;
  b=aNMeWGzzKuRylr2yKf5XOgdwCpYkR23EVQ9IeRrlltH65XrnxieBchPd
   Wt2WYMqGGWJl0xRhZow1e3N41iod6X8UuSsbjPp3pwoBf5umuaErzCwTn
   Q9NjnyRea1PPflq1J1wRUXijP3q2+0m2Hdjl1CFIf4XMVZ6lLd/cQ8VYx
   ldYyDL6aCHlm9XHC1N7JPgAuzAEtPbJdFW/RfdmZM0QMOftm7AGAhxMQg
   0ALubS+pAxHBg+tHGpxzDtMC6WjbC1QSs0kw7jfGSMK2KxLQlDtZ+42NS
   lW2Zq/fuC5cYn0yqBrzxpWVmuQQOE7mkjOUOYm6LJaFX7llBTn1USUveC
   w==;
X-CSE-ConnectionGUID: 2VIYffpZS8aK1ufVbLhx2w==
X-CSE-MsgGUID: Ql1+bPjoQheqkku5TfmX7Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23994336"
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="23994336"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 19:31:38 -0700
X-CSE-ConnectionGUID: DN3V7W+7Sx+80mb+F32J2w==
X-CSE-MsgGUID: L/mCona4QAuoIG3+JnSisQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="69359345"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2024 19:31:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Tina Zhang <tina.zhang@intel.com>,
	Sanjay K Kumar <sanjay.k.kumar@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/14] iommu/vt-d: Unconditionally flush device TLB for pasid table updates
Date: Mon,  2 Sep 2024 10:27:20 +0800
Message-Id: <20240902022724.67059-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902022724.67059-1-baolu.lu@linux.intel.com>
References: <20240902022724.67059-1-baolu.lu@linux.intel.com>
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
Link: https://lore.kernel.org/r/20240820030208.20020-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/pasid.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index b51fc268dc84..2e5fa0a23299 100644
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

