Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F21536728F
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 06:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972095; cv=none; b=anHxLyb+noDWoswg3U/cjVUTZ/fGvcA8HHwNxPCYvajRKL1dHx0PuZRPgoopM/1ixovnH/ndlJf6bqtV8HcUSJs2qOISTs8Io22JzzzxrE6Ac6yQqjSFAPcA1ZCPM4kfOSU+H9WNxAjTqLivl9i7jedL2U3PlAgEx1Cuj8NOPqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972095; c=relaxed/simple;
	bh=p4P0Jj3DAmfKFvOX4WQBJ1/TYWv+N6lLG9Zs2+i4Fs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3bE1ObzEjBApJOJ9hzQhYOg6KFPnz/zTSUYUK/gPH6guLl8mdse3x2s9X/4MaBM4rWNllaUUkSCxDpEe1yjIW56ugzOI/0YmtDTnS3/dQt8+b4hDe1KI9LPUe8VPZ89y79SWS2N9x95+wOEV9t4Sc6jKA91FwOpFb7NO/l2zG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EH+KnEfv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EH+KnEfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972091; x=1814508091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p4P0Jj3DAmfKFvOX4WQBJ1/TYWv+N6lLG9Zs2+i4Fs0=;
  b=EH+KnEfv56PVfI2DitYK/JCgxACEiHTESIGnNeM6Z2GKWa/XHJJBn2km
   8xtMUKS48TSXC9woqLPb/CCVEs9012G5J2XFIdYKGgvgb6S0p3TTBtYaW
   uiI3XcKorYqjWVClNQl0JWMJ46rw2XYTwXKjr0BF9R8tevPss9vPb5PPr
   hq44yt8+7QlP3a7nNowbo64oOS8d2HXoxSbzZKp+GCPhJ4wrP5NVYcNK0
   K0UWtp44+4q1slg/9Qg5O8FAFTjy7FDiKSbNX/lswQOgpdaaLWywDbJUl
   jKjN5NAqxMqhCUl/4PocNvL1f/moy77aQzuUy1FUL6T17Bmeovzf2IX51
   g==;
X-CSE-ConnectionGUID: KyLrNoJ0RFaxNr0Ss6NOdw==
X-CSE-MsgGUID: yQd8oQeKTeS9mrGTqGio2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256507"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256507"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:30 -0700
X-CSE-ConnectionGUID: qSL6MlvkRvi/WiwBbZcr7w==
X-CSE-MsgGUID: p1aYMNTqRvqTwGyxIa/hbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425894"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:28 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/9] iommu/vt-d: Remove the 'force_on' variable
Date: Thu,  2 Jul 2026 06:12:14 +0000
Message-ID: <20260702061216.388743-8-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702061216.388743-1-kevin.tian@intel.com>
References: <20260702061216.388743-1-kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The force_on variable is now redundant - same information captured
by "dmar_policy == DMAR_FORCE_ON". Replace all force_on checks
with dmar_policy_force_on().

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 37 +++++++++++++++++--------------------
 drivers/iommu/intel/iommu.h |  5 +++++
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cddd3ab215cf..50dfe426322f 100644
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
@@ -1711,7 +1710,7 @@ static int __init init_dmars(void)
 			 * we always have to disable PMRs or DMA may fail on
 			 * this device
 			 */
-			if (force_on)
+			if (dmar_policy_force_on())
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
@@ -1803,7 +1802,7 @@ static int init_iommu_hw(void)
 			 * we always have to disable PMRs or DMA may fail on
 			 * this device
 			 */
-			if (force_on)
+			if (dmar_policy_force_on())
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
@@ -1864,7 +1863,7 @@ static void iommu_resume(void *data)
 	unsigned long flag;
 
 	if (init_iommu_hw()) {
-		if (force_on)
+		if (dmar_policy_force_on())
 			panic("tboot: IOMMU setup failed, DMAR can not resume!\n");
 		else
 			WARN(1, "IOMMU setup failed, DMAR can not resume!\n");
@@ -2132,7 +2131,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		/*
 		 * we always have to disable PMRs or DMA may fail on this device
 		 */
-		if (force_on)
+		if (dmar_policy_force_on())
 			iommu_disable_protect_mem_regions(iommu);
 		return 0;
 	}
@@ -2485,13 +2484,13 @@ static bool has_external_pci(void)
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
@@ -2505,8 +2504,6 @@ static int __init platform_optin_force_iommu(void)
 	/* No concurrent access to dmar_policy at this point. */
 	dmar_policy = DMAR_FORCE_ON;
 	dmar_disabled = 0;
-
-	return 1;
 }
 
 static int __init probe_acpi_namespace_devices(void)
@@ -2546,10 +2543,10 @@ static int __init probe_acpi_namespace_devices(void)
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
@@ -2561,8 +2558,6 @@ static __init int tboot_force_iommu(void)
 	dmar_policy = DMAR_FORCE_ON;
 	dmar_disabled = 0;
 	no_iommu = 0;
-
-	return 1;
 }
 
 int __init intel_iommu_init(void)
@@ -2575,17 +2570,19 @@ int __init intel_iommu_init(void)
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
@@ -2639,7 +2636,7 @@ int __init intel_iommu_init(void)
 
 	ret = init_dmars();
 	if (ret) {
-		if (force_on)
+		if (dmar_policy_force_on())
 			panic("tboot: Failed to initialize DMARs\n");
 		pr_err("Initialization failed\n");
 		goto out_free_dmar;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d2e787243532..95962a45ac36 100644
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
-- 
2.43.0

