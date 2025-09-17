Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AD2F6594
	for <iommu@lists.linux.dev>; Wed, 17 Sep 2025 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758077454; cv=none; b=EC1udHBrCur77aE9HCFQMYQAwN/x1zs3+UIqghfvIAAl9SDCU56AviPqwq/5Wy7ruuBhbqZvwRvgotrylaADY1q8+89ECGYgsCt7UL1/zTHcLgnai+DUyXwC8U+CtUbYSvizG40gLPfWU3bcb2jM3oPmAl3Dq6hXSgtEvD0wlFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758077454; c=relaxed/simple;
	bh=TAbNBSS4RHNcQXrq8QpBB8Oyu1q8Yt8ZtOgysNs1Ep0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUmd3RuxDVvpCIuopK/suRyNuckSWegg7kNG9SdK7gskkcNk3jbKm7r831krYEtEKMXW9EohecM0wZzw0B1T9APpnd+YyuivkJa/Ep/blKAxQsUJSlKSR3kQFQLhBPsi3jg1MfG2VldSkgB/2G17duCHrlkNCo0UywWWKxK9v4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CieJUJwU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CieJUJwU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758077452; x=1789613452;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TAbNBSS4RHNcQXrq8QpBB8Oyu1q8Yt8ZtOgysNs1Ep0=;
  b=CieJUJwU9N+nis3YcfYEduqW0Z9uEV3gHWNBlUcM4iuzx2xm9vL72RUU
   3x4R/nOLLmBaRGwCUT9HM8GC1OXmSribinl1/roLXctj5WMAo+M5Pd3G1
   yYANGmMhWS4nPLKMuChCgi3Uu9vlLPmThAbbQrbBmciYNWgyUX7vY8iO4
   sfV2o6ED54+7Ry4RdRgmXWedIzgyQp3xvYmnbVbzFF4SmkLZ88wncOYnP
   dRN/clL1lEhkRhzfQcF0wOHkEXtHdINB7heM1+dk5cc+6BQaQYketi3OY
   tUsRhRaeHsU6yUNSVq1dAVXmj/sx47AoknMqTTYweQUuzvO70ywx8r9wi
   Q==;
X-CSE-ConnectionGUID: 46q/fHtER0+GiPkTk/ZVUw==
X-CSE-MsgGUID: JxSiyAJtRD+5pJ2A3H1zLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64005551"
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="64005551"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 19:50:52 -0700
X-CSE-ConnectionGUID: Hd5sgRXaRmW3RKBpNBg/Sw==
X-CSE-MsgGUID: +zA34w+hReGH382sp8Agkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="175516559"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2025 19:50:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Removal of Advanced Fault Logging
Date: Wed, 17 Sep 2025 10:48:50 +0800
Message-ID: <20250917024850.143801-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The advanced fault logging has been removed from the specification since
v4.0. Linux doesn't implement advanced fault logging functionality, but
it currently dumps the advanced logging registers through debugfs. Remove
the dumping of these advanced fault logging registers through debugfs to
avoid potential access to non-present registers.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c | 1 -
 drivers/iommu/intel/iommu.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 38790ff50977..765edb3740e2 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -63,7 +63,6 @@ static const struct iommu_regset iommu_regs_64[] = {
 	IOMMU_REGSET_ENTRY(ECAP),
 	IOMMU_REGSET_ENTRY(RTADDR),
 	IOMMU_REGSET_ENTRY(CCMD),
-	IOMMU_REGSET_ENTRY(AFLOG),
 	IOMMU_REGSET_ENTRY(PHMBASE),
 	IOMMU_REGSET_ENTRY(PHMLIMIT),
 	IOMMU_REGSET_ENTRY(IQH),
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 21d79414385c..ef7a1ae8e0db 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -77,7 +77,6 @@
 #define	DMAR_FEDATA_REG	0x3c	/* Fault event interrupt data register */
 #define	DMAR_FEADDR_REG	0x40	/* Fault event interrupt addr register */
 #define	DMAR_FEUADDR_REG 0x44	/* Upper address register */
-#define	DMAR_AFLOG_REG	0x58	/* Advanced Fault control */
 #define	DMAR_PMEN_REG	0x64	/* Enable Protected Memory Region */
 #define	DMAR_PLMBASE_REG 0x68	/* PMRR Low addr */
 #define	DMAR_PLMLIMIT_REG 0x6c	/* PMRR low limit */
-- 
2.43.0

