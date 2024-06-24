Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305917BD5
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 02:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719197172; cv=none; b=bZsuJ1xaDj2YYGB43Ji06eBrQa9CvWBi3nRSJ4Wx609AhqgStEVUMC10A213BsKa1w4cDIpR6rsY84S1Aa0dN0+tEiHeFFbKR1c6UEp1JyJlmJNVf4jxPjh8/quhwTUWJVPK4mY49WiBzMQ8PKWf0ImREcky4FsJ2GBqiGZwkK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719197172; c=relaxed/simple;
	bh=9skIRVd0hdhRAhhe6BksPTGWz7ouqeybU0wcB/6E+FI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SDjTq3B2VrVQ8rEhNKzEwLexP/gp2MdnhM3Rf2F4EgZQQ8MlKj6Njv1CPD+RVMiQNKFFrLtdDeQX53sqqQgeUgs4cedpZC7AWcvsWLXoOcuTBEXYE0n5tnIMPv10QjK7SCWYUpZAg6oQMX0F+FgA41nsORkpCPzL2AAzXNOE6PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RosJWFEl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RosJWFEl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719197171; x=1750733171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9skIRVd0hdhRAhhe6BksPTGWz7ouqeybU0wcB/6E+FI=;
  b=RosJWFElwkPvKzmHp6yHx9yGmm14F/CsDTPy2D+6cwma0/0Fj+eEDyEU
   48JkzTHTLXB7WD8M476s6eEOaVtXKdWHdVfd5ZUxFidQiCR/u/HaSchJE
   PH+ANRH79LiS+sZ33WVhz8uZQhUq+IouiCzZBBRTyPwwvSY6JttNnuJ2o
   uubA/wj2xMuBxBYL0289mo1ac+5M4t82aZjgv7pH0X1sHYJjHrIyKjgOn
   5TEzEP3K1RV4UKcYd95RBHhIcyS93Mm+P1YaYZk3JDqyWgdS6nyMwMgvz
   3l4wfs24RYweQPLDUaqR5fNW/v4GvMqbO/5CHO16YicjIVemHYz+7vTMl
   g==;
X-CSE-ConnectionGUID: 0SPxJVbtQpW2rPh3Ia+dZQ==
X-CSE-MsgGUID: EWsBUfX3TAq1P24LhNfnxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16030510"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16030510"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 19:46:10 -0700
X-CSE-ConnectionGUID: 5V6Syz//RpaJ7JG0uqbhsg==
X-CSE-MsgGUID: e+4ocBQGRQG7RtJexlPeFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43131723"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 23 Jun 2024 19:46:09 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Remove comment for def_domain_type
Date: Mon, 24 Jun 2024 10:43:27 +0800
Message-Id: <20240624024327.234979-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment for def_domain_type is outdated. Part of it is irrelevant.
Furthermore, it could just be deleted since the iommu_ops::def_domain_type
callback is properly documented in iommu.h, so individual implementations
shouldn't need to repeat that. Remove it to avoid confusion.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ccde5f5972e4..640081933aed 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2177,17 +2177,6 @@ static bool device_rmrr_is_relaxable(struct device *dev)
 		return false;
 }
 
-/*
- * Return the required default domain type for a specific device.
- *
- * @dev: the device in query
- * @startup: true if this is during early boot
- *
- * Returns:
- *  - IOMMU_DOMAIN_DMA: device requires a dynamic mapping domain
- *  - IOMMU_DOMAIN_IDENTITY: device requires an identical mapping domain
- *  - 0: both identity and dynamic domains work for this device
- */
 static int device_def_domain_type(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
-- 
2.34.1

