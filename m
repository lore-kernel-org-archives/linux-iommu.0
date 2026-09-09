Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423864734C9
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940991; cv=none; b=dm2hmjZPjVIDOQFnOweuexsYkPzQmEjIanzxtZp8PEmcJMhi7awf/Aob8PcERhMDUOpkGkj3poZflpDOvG4Jkx9j5dqvkgcf3Gj7ZyzYLbQjHAY7DvSx5CU555W8jzBeMOIBoWhTNKpFdZbBSMMadeBK6SkLq69LwuIfEhZlmy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940991; c=relaxed/simple;
	bh=+nSvbWkPPEJCrpBxrms7g4NcRIR0MNVq+yWahQf9Hi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EmEijZVK/BjrTdckbyfeeky6NeiRJYxiJSByUgVTWBF1ZQqzY4XhDD7Xc6GJUL49jpyXuRmU0UyMgvtp+EftArrGzrGCwqLedF4l0whpgztr0A3dHqKs1AOFMcBRQyHj7DEn1Qfhul3HWwlp/4+u75hVpY3yvT/pvZcqH6tJCN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VM6MkNvd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VM6MkNvd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788940991; x=1820476991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+nSvbWkPPEJCrpBxrms7g4NcRIR0MNVq+yWahQf9Hi8=;
  b=VM6MkNvdM4gr1fIRpxYHU7yfA5gFet/bhVpJhZ+OJw+QsN2+nNsE6FMG
   Dd1U8LQGzztMtGlMzkxK6bvnzp0zrD1ML5TZ72VIflXZBuwXxd3V9xcWh
   LOWvNZCUO4lpwaVXBFxkA0Nzym6ZfCaBPdP7FIqSE1TOOm+8RGq4pMRcS
   q+EfDPMjt1r3Ru5jgwa3/U6DnKIDH/H/8+t/wkN/1I9dvTZTOpjhFAJOA
   Iuna8ycLMp5IGihsPqULSKoM/E5e+du7SyoZ1Ds8caqJeAEVhCz1eFi5w
   Jafx3z42axZFt+3QHwea4ZRHv2fkTmcPLJGNbUtd+/DSOcBjZ2baxdJj0
   w==;
X-CSE-ConnectionGUID: StkbKWhrRsq7Udgc9dsFUQ==
X-CSE-MsgGUID: v1kXEBwtRRamAhgPiVHvaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106726444"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="106726444"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 01:03:10 -0700
X-CSE-ConnectionGUID: rLkuDipTR1O7bMFk+r5Ijw==
X-CSE-MsgGUID: 7wHZi4V5Rk6GjjxeAd2+Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="301119234"
Received: from allen-box.sh.intel.com ([10.239.48.101])
  by orviesa002.jf.intel.com with ESMTP; 09 Sep 2026 01:03:08 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/7] iommu/vt-d: Fix issues reported by Sashiko
Date: Wed,  9 Sep 2026 15:50:59 +0800
Message-ID: <20260909075106.738691-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This collects a number of pre-existing issues that were reported by
Sashiko while reviewing recent VT-d patches. None of them are
regressions from the patches under review; they are latent problems in
code those patches happened to touch.

Thanks,
baolu

Lu Baolu (7):
  iommu/vt-d: Avoid out-of-range shift in qi_desc_dev_iotlb_pasid()
  iommu/vt-d: Do not ignore context table copy failures
  iommu/vt-d: Handle DID reservation errors when copying context tables
  iommu/vt-d: Reserve scalable-mode DIDs from PASID entries during copy
  iommu/vt-d: Use old domain parameter when attaching the blocking
    domain
  iommu/vt-d: Fix iopf refcount leak in nested attach
  iommu/vt-d: Drop old iopf ref only after attach succeeds

 drivers/iommu/intel/iommu.h  |  17 +++-
 drivers/iommu/intel/iommu.c  | 152 ++++++++++++++++++++++++++++++-----
 drivers/iommu/intel/nested.c |   2 +
 3 files changed, 149 insertions(+), 22 deletions(-)

-- 
2.43.0
