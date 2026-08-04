Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B19241D657
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811732; cv=none; b=HyaeORgiettypsHZ7wFs56+/lRy81QBSc4UrhyIvipEqUa98ZGyiJsdIvYLrFSqCgW2pIrGc3JiPxeYRWjxpXBaNUlvlY9Q2YHnJY5vg+8tGwF7E9XDLKnuD/q843iG119HUF1rjEheAITjZnBPyTuQRBhjsVLrSmRgVADtixkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811732; c=relaxed/simple;
	bh=dlVfOaW2BcS/8ZscA+AC93RlpoSyCVyt3w8eLMCO4GM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6/p9TrEBlmxvSMM54M/j5jXjr8cP9kTwK6mmmjchuEFtV8dU4+GIBVNOm2OPFpQZAsMNVfCCxQBb0EHTEFTQexeQNQO7z8OY+2UKrWDJDO8bC8UpeebY8lLHYeaRhR5GRRih2XATkiDb7dIOODNZ4NbvoyBzQvGh+Y64S3ANdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8S9JxGv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8S9JxGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811731; x=1817347731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dlVfOaW2BcS/8ZscA+AC93RlpoSyCVyt3w8eLMCO4GM=;
  b=a8S9JxGvwrtzLKQl26bkJYivgSzQjfrhcu+FR2IqSPIZNLZFyQ8t0bCk
   5rbO7NT1Kk/VR9w9czS+evT5IjL2uzvcW0feGPfyJm+1OUlpNk+7rTMgj
   ah2F8KUP/Efj/ZbPLuSrFIMEQOWTeeFPYenRPtqoUPRyihJF2KDtcNMsv
   Eft9cQUCXxLPRRsDWMMjaTQK82b0fDjUgIvi97iQ4NDqAoiUW6p6KxjM6
   yqXcv4JW/yHGtc2fntU83aEuGylDdmCIuop8NH0/PYqII5iJ3u11U7G6n
   uTzmmdIYNLKvMhgc64kBZitGSI0bpx2ABhue5oLpG+fEuukHMEsMFfrfv
   w==;
X-CSE-ConnectionGUID: SK7qo+dSTi2Y7Ai9hR13+w==
X-CSE-MsgGUID: Wweqb4ttTYOpFyClVmEB2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231310"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231310"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:48 -0700
X-CSE-ConnectionGUID: GDGwrFKoRryF//COmZEhuw==
X-CSE-MsgGUID: JERbT/2YS/2712Zz25Od3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587538"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:46 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] iommu/vt-d: Remove the 'force_on' variable
Date: Tue,  4 Aug 2026 10:37:05 +0800
Message-ID: <20260804023714.3080506-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Tian <kevin.tian@intel.com>

The force_on variable is now redundant - same information captured
by "dmar_policy == DMAR_FORCE_ON". Replace all force_on checks
with dmar_policy_force_on().

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  5 +++++
 drivers/iommu/intel/iommu.c | 37 +++++++++++++++++--------------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index dd2376a079b9..40da2ed7e254 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1394,6 +1394,11 @@ static inline bool dmar_policy_off(void)
 	return dmar_policy < 0;
 }
 
+static inline bool dmar_policy_force_on(void)
+{
+	return dmar_policy == DMAR_FORCE_ON;
+}
+
 bool dmar_can_force_on(enum dmar_force_on force_on);
 
 extern int dmar_disabled;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5eb80aeec274..118c62e859fd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -53,10 +53,9 @@ static int rwbf_quirk;
 #define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
 
 /*
- * set to 1 to panic kernel if can't successfully enable VT-d
- * (used when kernel is launched w/ TXT)
+ * Skip forcing iommu on and avoid tboot-related kernel panics during
+ * initialization when set to 1 (via intel_iommu=tboot_noforce).
  */
-static int force_on = 0;
 int intel_iommu_tboot_noforce;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
@@ -1713,7 +1712,7 @@ static int __init init_dmars(void)
 			 * we always have to disable PMRs or DMA may fail on
 			 * this device
 			 */
-			if (force_on)
+			if (dmar_policy_force_on())
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
@@ -1805,7 +1804,7 @@ static int init_iommu_hw(void)
 			 * we always have to disable PMRs or DMA may fail on
 			 * this device
 			 */
-			if (force_on)
+			if (dmar_policy_force_on())
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
@@ -1866,7 +1865,7 @@ static void iommu_resume(void *data)
 	unsigned long flag;
 
 	if (init_iommu_hw()) {
-		if (force_on)
+		if (dmar_policy_force_on())
 			panic("tboot: IOMMU setup failed, DMAR can not resume!\n");
 		else
 			WARN(1, "IOMMU setup failed, DMAR can not resume!\n");
@@ -2134,7 +2133,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		/*
 		 * we always have to disable PMRs or DMA may fail on this device
 		 */
-		if (force_on)
+		if (dmar_policy_force_on())
 			iommu_disable_protect_mem_regions(iommu);
 		return 0;
 	}
@@ -2487,13 +2486,13 @@ static bool has_external_pci(void)
 	return false;
 }
 
-static int __init platform_optin_force_iommu(void)
+static void __init platform_optin_force_iommu(void)
 {
 	if (!dmar_platform_optin() || !dmar_can_force_on(DMAR_FORCEON_PLATFORM))
-		return 0;
+		return;
 
 	if (!has_external_pci())
-		return 0;
+		return;
 
 	/*
 	 * If Intel-IOMMU is disabled by default, we will apply identity
@@ -2507,8 +2506,6 @@ static int __init platform_optin_force_iommu(void)
 	/* No concurrent access to dmar_policy at this point. */
 	dmar_policy = DMAR_FORCE_ON;
 	dmar_disabled = 0;
-
-	return 1;
 }
 
 static int __init probe_acpi_namespace_devices(void)
@@ -2548,10 +2545,10 @@ static int __init probe_acpi_namespace_devices(void)
 	return 0;
 }
 
-static __init int tboot_force_iommu(void)
+static __init void tboot_force_iommu(void)
 {
 	if (!tboot_enabled() || intel_iommu_tboot_noforce)
-		return 0;
+		return;
 
 	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
 		panic("tboot: Failed to force IOMMU on\n");
@@ -2563,8 +2560,6 @@ static __init int tboot_force_iommu(void)
 	dmar_policy = DMAR_FORCE_ON;
 	dmar_disabled = 0;
 	no_iommu = 0;
-
-	return 1;
 }
 
 int __init intel_iommu_init(void)
@@ -2577,17 +2572,19 @@ int __init intel_iommu_init(void)
 	 * Intel IOMMU is required for a TXT/tboot launch or platform
 	 * opt in, so enforce that.
 	 */
-	force_on = tboot_force_iommu() || platform_optin_force_iommu();
+	tboot_force_iommu();
+	if (!dmar_policy_force_on())
+		platform_optin_force_iommu();
 
 	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
-		if (force_on)
+		if (dmar_policy_force_on())
 			panic("tboot: Failed to initialize DMAR table\n");
 		goto out_free_dmar;
 	}
 
 	if (dmar_dev_scope_init() < 0) {
-		if (force_on)
+		if (dmar_policy_force_on())
 			panic("tboot: Failed to initialize DMAR device scope\n");
 		goto out_free_dmar;
 	}
@@ -2641,7 +2638,7 @@ int __init intel_iommu_init(void)
 
 	ret = init_dmars();
 	if (ret) {
-		if (force_on)
+		if (dmar_policy_force_on())
 			panic("tboot: Failed to initialize DMARs\n");
 		pr_err("Initialization failed\n");
 		goto out_free_dmar;
-- 
2.43.0

