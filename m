Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58819F422
	for <iommu@lists.linux.dev>; Thu,  5 Jun 2025 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749090250; cv=none; b=ncEit+kz8pHZSDnHpmHuwR4p0MWqoOGVgZOprFY+6pTBPwnDrvnFn7RopDI+Rl4h/Ic2llT9qtSrsdk1KSJqBg5Ey2vgV4+CNXE3/UnIu9Ho+UZpOH3W3J0P5eESKBuGYp5wwnp3sH4ZhIYimPJePX1wALuwgbXIgWo9nrtYQuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749090250; c=relaxed/simple;
	bh=V4rok7lW+n5Z+MDI3yPK1/H60EXqcu+mobX8r2avzIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aN7AYw9IFFqc7/TDuXpGRUVoXUq/GlwUXNjTshJ/iGGFmH0qlvtQAYmune22sSf0YoYWERAqWzKvTTNPbXjy4Dmhiijp4+yxalcqQWu3P9B/sZ9OOe1lZaCLHGE1Aje+8bz0zgpI/wANqCwclAXDc3ugHnyhG3eNPIDacBbSe5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVTOuY4G; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVTOuY4G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749090249; x=1780626249;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V4rok7lW+n5Z+MDI3yPK1/H60EXqcu+mobX8r2avzIQ=;
  b=DVTOuY4GykhpRrPP8/o6CevG278H5x8Dh06kHDDuLrvQimlDdI78yugH
   RXs1wTT1FF02HHYFQYgc89CkC4OuAMJ3kmWXf1kDXG7KwHjmQtZapSuE5
   Drote6PP/Xk92FK1UuOK6DiNwyMeGbMAQEW5j06s9RXYWIIY1kdtILaRe
   sC2NYux7UWw+TFsNlAbhZL9GLoKe+dUirrNUxc2Q42fbidaYZry7uWTzp
   +U415H0wwQs6fPngxJpd5MtHtyuJMoDsm1SaOC5KEtT8GnV9SDJyub3bU
   Tu3vQUuJWqQ2zzTLiqQNiazPm6uRveYY5Yl0mMwa9GRJI9tVAf4y6sd4M
   Q==;
X-CSE-ConnectionGUID: BlWn8FDQRcWxK24MVl47xw==
X-CSE-MsgGUID: G4IUa/FqQwK8ZQoVTnb/zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54854856"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="54854856"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 19:24:08 -0700
X-CSE-ConnectionGUID: ekfezvIyRieh6q+ZjFYnHw==
X-CSE-MsgGUID: wcOCUFU4TZO0IycvEbFreA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="150640710"
Received: from ww-dev.sh.intel.com ([10.239.48.95])
  by orviesa005.jf.intel.com with ESMTP; 04 Jun 2025 19:24:06 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: baolu.lu@linux.intel.com,
	kevin.tian@intel.com,
	yi.l.liu@intel.com,
	jgg@nvidia.com,
	dwmw2@infradead.org,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1] iommu/vt-d: Remove redundant SLTS cap check for nested and dirty tracking
Date: Thu,  5 Jun 2025 18:10:52 +0800
Message-ID: <20250605101052.955174-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In intel_iommu_domain_alloc_paging_flags():
For the nested_parent case, nested_supported() has been check earlier,
and for the dirty_tracking case, ssads_supported() has been check earlier.
Both of these imply SLTS support, making the subsequent SLTS cap check
redundant.
Also, false-initialize the first_stage boolean to simplify the code.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/iommu/intel/iommu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7aa3932251b2..a79f91b47a8a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3340,7 +3340,7 @@ intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	struct intel_iommu *iommu = info->iommu;
 	struct dmar_domain *dmar_domain;
 	struct iommu_domain *domain;
-	bool first_stage;
+	bool first_stage = false;
 
 	if (flags &
 	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
@@ -3356,13 +3356,8 @@ intel_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	 * IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING
 	 * is specified.
 	 */
-	if (nested_parent || dirty_tracking) {
-		if (!sm_supported(iommu) || !ecap_slts(iommu->ecap))
-			return ERR_PTR(-EOPNOTSUPP);
-		first_stage = false;
-	} else {
+	if (!nested_parent && !dirty_tracking)
 		first_stage = first_level_by_default(iommu);
-	}
 
 	dmar_domain = paging_domain_alloc(dev, first_stage);
 	if (IS_ERR(dmar_domain))

base-commit: 16b70698aa3ae7888826d0c84567c72241cf6713
-- 
2.43.0

