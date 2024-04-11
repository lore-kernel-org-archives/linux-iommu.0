Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7313B5AD
	for <iommu@lists.linux.dev>; Thu, 11 Apr 2024 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804939; cv=none; b=QkJMMBkr6CAeWK/NSz+8BLBs7trsE2L6viTkAjOxgdgrcG+CRS4zJEGbocVB6T38Nc5oBaZYX7L2Q1rowbyMIHWP9/lLejmGddlvx7HQBcEPNgnRtVwrwk/xDMUWL2OevitL5oPGiI+fnzhrHSYtUDEkPr07s6QyrOSxWSxMKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804939; c=relaxed/simple;
	bh=NIGz6endGjRZsn6/+1mnyMEPPi/V1nqZZ0N3qo84bsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rHMzxj4eNLratmj4zusD5OSuYlfQ6OYzipN3Ii19TASzVm34xR2OYY/KOmHnPh9vHzJbLO8hZPxPK5phHc7NmApa9BcVqSJ0e08hROMwpLNXi27cvjJlu9tqBuHfiopcrb23y/zvlG22k5EA83dx9t4nOG6WkUWFZxEjw0u1IQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iokp+reL; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iokp+reL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712804938; x=1744340938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NIGz6endGjRZsn6/+1mnyMEPPi/V1nqZZ0N3qo84bsI=;
  b=Iokp+reLQ4ktFEYE6t8YQHEiKDRE5vVQL048QlMXxDOManJXMV3qBa6c
   rdHRHR16glsXEXUgYXMAkZNFRaidB3FSkTqBhOQQJ7i50IBp8YMJYiQK2
   2osIzjnpDKa/lPaH1Np8t1Uz9DRH+t1og0pSV/XVzN8dxtF2bdH9V1kyJ
   ti0OQf23KZ/VHdKEfBB8GZBsEYUsLZYPsrn6wuTu/eKJZG/wFlbii4jRA
   G7/IunsnmvMPdXFGc7vzgkCyS+F1qql9Jq1y1qKH93n9ghRjWnKgBLbFt
   UD+lNTN0E6kt99WsAeERTHEHt497nOJ+GTZst/m9Efphj23MTwh7OatFU
   Q==;
X-CSE-ConnectionGUID: Otp0kgGJSHCHcE4ZCHUzmQ==
X-CSE-MsgGUID: tzdB/+EGSqaRFdcQutFhtw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30681433"
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="30681433"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 20:08:57 -0700
X-CSE-ConnectionGUID: PRqa8wJQThmImvvAx66Grw==
X-CSE-MsgGUID: wBc5C4ntS9aZwAnP2BixIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,192,1708416000"; 
   d="scan'208";a="20822959"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 10 Apr 2024 20:08:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Xuchun Shang <xuchun.shang@linux.alibaba.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] [PULL REQUEST] iommu/vt-d: Fixes for v6.9-rc3
Date: Thu, 11 Apr 2024 11:07:41 +0800
Message-Id: <20240411030744.273460-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Joerg,

The following patches have been queued for v6.9. They aim to address
below issues:

- Local memory for PRQ page allocation;
- Fix WARN_ON in iommu probe path;
- Fix wrong use of pasid config.

Please consider them for the iommu/fix branch.

Best regards,
Lu Baolu

Jacob Pan (1):
  iommu/vt-d: Allocate local memory for page request queue

Lu Baolu (1):
  iommu/vt-d: Fix WARN_ON in iommu probe path

Xuchun Shang (1):
  iommu/vt-d: Fix wrong use of pasid config

 drivers/iommu/intel/iommu.c   | 11 +++++++----
 drivers/iommu/intel/perfmon.c |  2 +-
 drivers/iommu/intel/svm.c     |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.34.1

