Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7EB3BD62C
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549615; cv=none; b=qRqOcxa215rOmwRhBofT/z0PyEcZxGTprAaSELPOK3cVQC+kqW1ZwxqIk2CRI+IIWngr20k9f876YX7KD4rWum4ZrbE3NHR8L61wpNXoIgxS8vYYCUQvbXz5xt1Gs87a8yge8wuzvqdjld0Ylh4doY/Joj09fVTsq5TYslCz/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549615; c=relaxed/simple;
	bh=0Q6cHtyHuTSMwB5DRu9niawkKX/hWiOQsHQv96nw3Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Anyk/PxihZ+RJamdQUbPIyRtRonfTHezCBIvRqn8OHlXzY8dJXNHRXXttUKCXxSi+3FdafbxZWHUAdR6nMfIUSwShMbuY8GyXy/6lFMwU1ihIckWwuo887Bnhzptie4dyqdj+by7tFQ/ZC/9H44YjUQXoSuXbw05ofC7hjYlOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c5svTz/c; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c5svTz/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780549614; x=1812085614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Q6cHtyHuTSMwB5DRu9niawkKX/hWiOQsHQv96nw3Ps=;
  b=c5svTz/cnOaIeW4xY/rh3NhrcQuIwcuNJiisAKdCeWQuCRYxjJsygpRP
   B3xnRLxGTgtReot2r48hS7TyydcRIw+avdItsASitzHO+kRjVFEyKKv/H
   e9Y8ERxuaEZhI2YahyrD4qECw4D/TsR+Utkm6MgEku9d/ivID2pxEyYb4
   UY/LPod3WNZ5ofyszdDt8uOkjmOxfEuen2UemgFsnBKsccZmVVEgoI8Yl
   5fCsSC30KcgNEfuRqpEohcsAB1LpOiquS99rnsG6XYTRSCTjofs3IZtkv
   zFMMIMECiuEpSZ3wdxMQM2MDlUGwLxUUDMmOsqVl45+XTchnjNPqQWBx5
   Q==;
X-CSE-ConnectionGUID: o/OmrS5wQW2NAqPRBX+XuQ==
X-CSE-MsgGUID: PULE5/F4TBWUjDPIUcVeVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91943548"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91943548"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:06:35 -0700
X-CSE-ConnectionGUID: vVagNXxASfKKga70Fm4xyw==
X-CSE-MsgGUID: 9aeLbOzLSDGxfQ94S2mNAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246266599"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 22:06:32 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] iommu/vt-d: Remove dmar_disabled
Date: Thu,  4 Jun 2026 05:15:39 +0000
Message-ID: <20260604051540.592925-9-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604051540.592925-1-kevin.tian@intel.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's replaced by dmar_is_disabled() now, covering both "iommu=off"
and "intel_iommu=off". Also remove unnecessary checks on no_iommu,
leaving only one exception in intel_iommu_init() which skips debugfs
init for "iommu=off" but not "intel_iommu=off". Keep it to avoid
surprise for now.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 9 ++-------
 drivers/iommu/intel/iommu.h | 1 -
 drivers/iommu/intel/svm.c   | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d05ae36eda70..78498dafa60a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -199,7 +199,6 @@ int dmar_state = DMAR_ENABLED;
 #else
 int dmar_state = DMAR_DISABLED_AUTO;
 #endif
-int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
 
 int intel_iommu_enabled = 0;
@@ -241,11 +240,9 @@ static int __init intel_iommu_setup(char *str)
 	while (*str) {
 		if (!strncmp(str, "on", 2)) {
 			dmar_state = DMAR_ENABLED;
-			dmar_disabled = 0;
 			pr_info("IOMMU enabled\n");
 		} else if (!strncmp(str, "off", 3)) {
 			dmar_state = DMAR_DISABLED_USER;
-			dmar_disabled = 1;
 			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
 			disable_igfx_iommu = 1;
@@ -2366,7 +2363,7 @@ void intel_iommu_shutdown(void)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
 
-	if (no_iommu || dmar_disabled)
+	if (dmar_is_disabled())
 		return;
 
 	/*
@@ -2499,7 +2496,6 @@ static void __init platform_optin_force_iommu(void)
 	}
 
 	dmar_state = DMAR_ENABLED_FORCE;
-	dmar_disabled = 0;
 }
 
 static int __init probe_acpi_namespace_devices(void)
@@ -2551,7 +2547,6 @@ static __init void tboot_force_iommu(void)
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
 	dmar_state = DMAR_ENABLED_FORCE;
-	dmar_disabled = 0;
 	no_iommu = 0;
 }
 
@@ -2594,7 +2589,7 @@ int __init intel_iommu_init(void)
 	if (!no_iommu)
 		intel_iommu_debugfs_init();
 
-	if (no_iommu || dmar_disabled) {
+	if (dmar_is_disabled()) {
 		/*
 		 * We exit the function here to ensure IOMMU's remapping and
 		 * mempool aren't setup, which means that the IOMMU's PMRs
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 6b4e47f2f245..1832debf4982 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1390,7 +1390,6 @@ static inline bool dmar_is_force_on(void)
 
 bool dmar_can_force_on(enum dmar_force_on force_on);
 
-extern int dmar_disabled;
 extern int intel_iommu_enabled;
 extern int intel_iommu_tboot_noforce;
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 57cd1db7207a..971dddaba48e 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -115,7 +115,7 @@ static int intel_iommu_sva_supported(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
 
-	if (!info || dmar_disabled)
+	if (!info || dmar_is_disabled())
 		return -EINVAL;
 
 	iommu = info->iommu;
-- 
2.43.0

