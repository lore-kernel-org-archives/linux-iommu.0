Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B9219D8B3
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538979; cv=none; b=RR5s2TZkLg9tKb+f3MYF7bXjSnr4VRC7ZN22rPtLDugNxUe+TA4i5FJ52sxjUTSaf3dlT7zRI+uEqFlz1HLmFCL4ixd9fhGPEu010pPxOZzYDXoySCU6EGWQuHKTt2tSGoP7VyKvEJYqcf+3+T+pi1E7YasG5fFdjB6vlt1aC1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538979; c=relaxed/simple;
	bh=MgOFKuoS0gbsBlC2yXiG9tpNMfshnXGRtR3CrLdH7uw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LTuLR16fSPzt8skus1xxtPCxCyeyLxhMyPiO2dyzSDk3BHFK81tPl0osfQkXmtfRi4ZZ3LR7LYyG3NLApwoM1gffbrmQjCbCGKagd4yE3kjxZ0GuNpUBFCC5VwrccbWuD+7EJi6MH1ob5ScxhINv2OKfsgzcRVcd2tit0X9z/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYuYPWzv; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYuYPWzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720538978; x=1752074978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MgOFKuoS0gbsBlC2yXiG9tpNMfshnXGRtR3CrLdH7uw=;
  b=EYuYPWzvIhn6XrrSisLpGeyydmsBoSjuozBvfZwKYRegPDCeFVvxp8ME
   HJAs23nP/uKHVmAamx05RxAL+Ilzwqskut9BWIdY2bXIs+3Ak9yN0BiCl
   cocVqISwWQsfGMJ/1Z3f0CTLX8YUofPBJUDLr/XnuMYiJ+kPFy3ACF2aO
   6NI1npHwlMcKyK8p5aq2fyS6KnVulmMJun9heU9jtcrupID1eQgYjhSg7
   gxDWcXmW5Za2NEck25vNFrZ8OF0o6SHEmvPEtlx7e5AKdTsj5H5Ym2LSK
   zPelmQY4KOm0gR2EllMVha1e7xIkku8tKI1sHVrgofFwi5ItP2FG95bB9
   g==;
X-CSE-ConnectionGUID: GxODDX44SwittOiHFDgsYw==
X-CSE-MsgGUID: 5BvD4eK7TeiFR7RayUW0Ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="40321129"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="40321129"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 08:29:38 -0700
X-CSE-ConnectionGUID: DvTxw2R/T+6eVbNLFu7Gnw==
X-CSE-MsgGUID: dfMqfnn/TX6p9RnDbEFa4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="48618931"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 09 Jul 2024 08:29:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Louis Maliyam <louispm@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 0/2] iommu/vt-d: Fix aligned pages for cache invalidation
Date: Tue,  9 Jul 2024 23:26:41 +0800
Message-Id: <20240709152643.28109-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The aligned pages for cache invalidation returned by
calculate_psi_aligned_address() are incorrect if the start pfn is not
aligned, which can lead to cache inconsistencies when qi_flush_piotlb()
uses the number of pages to flush caches for the first-stage
translation.

Fix this by updating the aligned pages once the address mask is adjusted.

Change log:

v2:
 - Add a new fix to Limit max address mask to MAX_AGAW_PFN_WIDTH.

v1: https://lore.kernel.org/linux-iommu/20240708121417.18705-1-baolu.lu@linux.intel.com/

Lu Baolu (2):
  iommu/vt-d: Limit max address mask to MAX_AGAW_PFN_WIDTH
  iommu/vt-d: Fix aligned pages in calculate_psi_aligned_address()

 drivers/iommu/intel/cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1

