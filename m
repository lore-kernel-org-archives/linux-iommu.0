Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FB35A384
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549614; cv=none; b=dE60AlZQf2k+KVrSaaiHYegffnmvJOKIpby8rSWv8Sp5KTahbKIewmVJM7IuWSkAhlTTmE2QOviPzu0a/BdvvnpDvY01Q5JrR/v5qBVidTpch6vaFeeLAxPqjnEnQByh3BN6UDHHqVhImhuJ3FptTyxm/3nZri7LYHFxWULkJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549614; c=relaxed/simple;
	bh=xDuyLI+qTmYFzG8Nj8ZDoEHxNqxrXrFsynXD13r2qoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXV+vLqcTZZlgHxX1Z0lCXIz8NQWpzlC+NKjCOAcFizC4yvFHnjNmGuFou48eqBfKT+VbS2SOsLWpfV+ePP9W15zv9Fj3+bGQP4QhLZi59mF+pSnlvtzaerwE+Fy4YRb1QMxV2gWPY60FW/EMFAezNtNVDt+25u+AAHo/RmjbFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=catvDwYy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="catvDwYy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780549613; x=1812085613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDuyLI+qTmYFzG8Nj8ZDoEHxNqxrXrFsynXD13r2qoI=;
  b=catvDwYyoqJ4undQCK69khT/lcyj/tjuBUymTwRLz7lVUgEoe6PBxj2j
   sTDQqG4LQXhuQ8HlT8GEyiesZkk+Bvh/vNVX2uTleGj6I4SdqMybi52AG
   2ed4hEYoQ9s3GhkFGNrCNlVV3yOriXbOYgpT24tpjTymsxbd5nltLesSJ
   2bwg05Y7i+m1wIZmubTBNXql7anURWSK4bmOAu9KNxtVUWrJbvPjl00BF
   Ka2yNBdp7DLd9cs4+J0CayrWywQ9guSADcf8RNfVBkeTYx04rydtXdA+9
   gVBXIOYsETe0oI1ppEfnv6E1DBuVtw5M+fiHtIqLiZ+HtBzWadofpZpvG
   w==;
X-CSE-ConnectionGUID: DdCF2zyORbi/yMv6iT8C1g==
X-CSE-MsgGUID: VqoJoFLFRKy6mHJqlkjaHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91943538"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91943538"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:06:32 -0700
X-CSE-ConnectionGUID: XEp/e8yJT4Ox/AFYeprvMA==
X-CSE-MsgGUID: BS0g7t+BRdGAMtmzuIWuJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246266563"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 22:06:29 -0700
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
Subject: [PATCH 7/9] iommu/vt-d: Remove the 'force_on' variable
Date: Thu,  4 Jun 2026 05:15:38 +0000
Message-ID: <20260604051540.592925-8-kevin.tian@intel.com>
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

The force_on variable is now redundant - same information captured
by "dmar_state == DMAR_ENABLED_FORCE". Replace all force_on checks
with dmar_is_force_on().

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 34 +++++++++++++++-------------------
 drivers/iommu/intel/iommu.h |  5 +++++
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ed227de6d0ba..d05ae36eda70 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -53,10 +53,9 @@ static int rwbf_quirk;
 #define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
 
 /*
- * set to 1 to panic kernel if can't successfully enable VT-d
+ * set to 1 to avoid kernel panic if can't successfully enable VT-d
  * (used when kernel is launched w/ TXT)
  */
-static int force_on = 0;
 int intel_iommu_tboot_noforce;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
@@ -1708,7 +1707,7 @@ static int __init init_dmars(void)
 			 * we always have to disable PMRs or DMA may fail on
 			 * this device
 			 */
-			if (force_on)
+			if (dmar_is_force_on())
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
@@ -1800,7 +1799,7 @@ static int init_iommu_hw(void)
 			 * we always have to disable PMRs or DMA may fail on
 			 * this device
 			 */
-			if (force_on)
+			if (dmar_is_force_on())
 				iommu_disable_protect_mem_regions(iommu);
 			continue;
 		}
@@ -1861,7 +1860,7 @@ static void iommu_resume(void *data)
 	unsigned long flag;
 
 	if (init_iommu_hw()) {
-		if (force_on)
+		if (dmar_is_force_on())
 			panic("tboot: IOMMU setup failed, DMAR can not resume!\n");
 		else
 			WARN(1, "IOMMU setup failed, DMAR can not resume!\n");
@@ -2129,7 +2128,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 		/*
 		 * we always have to disable PMRs or DMA may fail on this device
 		 */
-		if (force_on)
+		if (dmar_is_force_on())
 			iommu_disable_protect_mem_regions(iommu);
 		return 0;
 	}
@@ -2482,13 +2481,13 @@ static bool has_external_pci(void)
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
@@ -2501,8 +2500,6 @@ static int __init platform_optin_force_iommu(void)
 
 	dmar_state = DMAR_ENABLED_FORCE;
 	dmar_disabled = 0;
-
-	return 1;
 }
 
 static int __init probe_acpi_namespace_devices(void)
@@ -2542,10 +2539,10 @@ static int __init probe_acpi_namespace_devices(void)
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
@@ -2556,8 +2553,6 @@ static __init int tboot_force_iommu(void)
 	dmar_state = DMAR_ENABLED_FORCE;
 	dmar_disabled = 0;
 	no_iommu = 0;
-
-	return 1;
 }
 
 int __init intel_iommu_init(void)
@@ -2570,17 +2565,18 @@ int __init intel_iommu_init(void)
 	 * Intel IOMMU is required for a TXT/tboot launch or platform
 	 * opt in, so enforce that.
 	 */
-	force_on = tboot_force_iommu() || platform_optin_force_iommu();
+	tboot_force_iommu();
+	platform_optin_force_iommu();
 
 	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
-		if (force_on)
+		if (dmar_is_force_on())
 			panic("tboot: Failed to initialize DMAR table\n");
 		goto out_free_dmar;
 	}
 
 	if (dmar_dev_scope_init() < 0) {
-		if (force_on)
+		if (dmar_is_force_on())
 			panic("tboot: Failed to initialize DMAR device scope\n");
 		goto out_free_dmar;
 	}
@@ -2634,7 +2630,7 @@ int __init intel_iommu_init(void)
 
 	ret = init_dmars();
 	if (ret) {
-		if (force_on)
+		if (dmar_is_force_on())
 			panic("tboot: Failed to initialize DMARs\n");
 		pr_err("Initialization failed\n");
 		goto out_free_dmar;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1acc393dafce..6b4e47f2f245 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1383,6 +1383,11 @@ static inline bool dmar_is_disabled(void)
 	return dmar_state < 0;
 }
 
+static inline bool dmar_is_force_on(void)
+{
+	return dmar_state == DMAR_ENABLED_FORCE;
+}
+
 bool dmar_can_force_on(enum dmar_force_on force_on);
 
 extern int dmar_disabled;
-- 
2.43.0

