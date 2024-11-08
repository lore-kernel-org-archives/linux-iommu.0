Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A3F5FEE4
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 02:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731032128; cv=none; b=hBwNyiONtVs+FPZjtLLY6Th7RK02IOUlpOJTuivBskeyto97ptsootNhsBqIrovoEC13U6iB+yZ0YblqbRDd0Txpkb36azr4e7Gnzl0cwi27fgtxGfm6xp06HbZzyhFsN40JuOXR25poU36M5n4E1rYqCCc8syn5XHuAiZONHto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731032128; c=relaxed/simple;
	bh=hqsP3BN5O7/9a9dPUsicIXA08bRbbQ6xZ0CYe/p9c5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDJY4bSHdm+GK1AzwFT/Gn9dJawEOB7iVvjNHiDIBMe9DTriMJkG6HnJ87cBWj/ZINRBl1K1/ruu7lhDtmRmcsNWPvPX5ZSrkxVRMvHLcXumn5+RnLTnz67LyL6hovbkwGnG8kw4xyfj9N+zxCUV8Tg9o5UkQYDCf+zsBQ6w4r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InQCSps0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InQCSps0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731032127; x=1762568127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hqsP3BN5O7/9a9dPUsicIXA08bRbbQ6xZ0CYe/p9c5U=;
  b=InQCSps0suIZVbJ8gGOTGYkpQWFHNtS87i5BgbUkPUOq4Zrk/M0a+Olz
   kAxgSsh5XJsNSAn/0MIxaBalj2jaUx0jpwnW4sSbdvc7CEpeYHWTcOXLm
   rhCBmLB6iupC3PmhjllncZDHujRrLp1qodCMHBj3Chstuc8/iFgK0ns1B
   m0rMupxxqLXXbhyjOgipgcsy1hmyJ2RqS0U3fuX+XCvj1zJNGkNZNuGbg
   RV9psA5esEkB9NdsViqlHonwHLFiSEzgXaPL9fVRjsg/+4jB1MZnEwjjh
   YfuJF+3gogSP6pU4cFe+IkSR5/XoDiyLFcUhwFT0VP3MbST6IMcqldHsa
   Q==;
X-CSE-ConnectionGUID: kEFnONKhTU2d4hMiWgVSKg==
X-CSE-MsgGUID: jcy2rB5MQEW9i0jdivdx3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="31007846"
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="31007846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 18:15:20 -0800
X-CSE-ConnectionGUID: fHDIbN78S0GJR9NDru8BkQ==
X-CSE-MsgGUID: rfq6MEEhQGSXEpsZ0zQTNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="116213818"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa001.fm.intel.com with ESMTP; 07 Nov 2024 18:15:12 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] iommu/vt-d: Limit intel_iommu_set_dev_pasid() for paging domain
Date: Fri,  8 Nov 2024 10:13:59 +0800
Message-ID: <20241108021406.173972-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108021406.173972-1-baolu.lu@linux.intel.com>
References: <20241108021406.173972-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Liu <yi.l.liu@intel.com>

intel_iommu_set_dev_pasid() is only supposed to be used by paging domain,
so limit it.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Link: https://lore.kernel.org/r/20241107122234.7424-9-yi.l.liu@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d19bd0ff5220..f3ccbe516dcb 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4154,6 +4154,9 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	struct dev_pasid_info *dev_pasid;
 	int ret;
 
+	if (WARN_ON_ONCE(!(domain->type & __IOMMU_DOMAIN_PAGING)))
+		return -EINVAL;
+
 	if (!pasid_supported(iommu) || dev_is_real_dma_subdevice(dev))
 		return -EOPNOTSUPP;
 
@@ -4182,8 +4185,7 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 
 	domain_remove_dev_pasid(old, dev, pasid);
 
-	if (domain->type & __IOMMU_DOMAIN_PAGING)
-		intel_iommu_debugfs_create_dev_pasid(dev_pasid);
+	intel_iommu_debugfs_create_dev_pasid(dev_pasid);
 
 	return 0;
 
-- 
2.43.0

