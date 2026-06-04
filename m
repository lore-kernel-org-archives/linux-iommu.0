Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8783BF689
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549616; cv=none; b=eSWNn76BSKUsxTCfukcHPbUnhogA0sof532rUSAHzpL01OZEW4RgWiqkp6p/jZzm6cawJSuY/i6I8OExLTHMv5xItQECQ2UnKOqYSMgeyF7Ld9cycz+6PKRm3j7o6qCxVVBIyJ2QlN29Pob3nRhwoPNEm6ulhjZDjZcy5DCDjz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549616; c=relaxed/simple;
	bh=r+YoTMiSQXSu4s6Q36+MaSkHW545Uv3UXvUatJ+cbvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzEfHVWpLZevh1pJNBsHGHyIMWF3vBvImidckpS9YfF0crs3WrKD7tAoIWFN/u2Tkuym+qAB96fDiInjpe+ldOwNPaxwHHNNA+coKDBuwFRgWk1Nb2vXS/u0NSzr/QbTIe4v/l6aKPOaF/TV5/SHB9AS/295Vewz1oGuucO4v1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/tVR78d; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/tVR78d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780549615; x=1812085615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r+YoTMiSQXSu4s6Q36+MaSkHW545Uv3UXvUatJ+cbvY=;
  b=N/tVR78d9hAbjg4YIpT+W1/yKHn6sox4pjgTipBmXEIxhciqJ8DjfXXb
   R+AyJ5JLlW7xcUrM4itErUV4j8fW7SOyV4ouJUO8mQgIFyWvhhx93qySe
   qe2QyPLuyzVjHD8xkI1RANyDEBuGAJoJKrpXSTBOIQxBZlJxp804ZyimL
   AHjCUlPJefDpM3rUhF704NbaZmOlq3Dr1bVrfN/1PmchGKjBhvevW1he9
   BVhDXWm6PyE73v43GMOn1jKrGKaifDzZ9NHeytlAuFS96bSqybt0Co0pU
   hMGBXjvQehPfU1VUE8wYCrv6ygVieTrw+BgJmpH2+xxOZTdK3wDGacJEq
   A==;
X-CSE-ConnectionGUID: Hwo8dbXfQ3uBJskZS44uKg==
X-CSE-MsgGUID: Xssf5KFYSc2/+x3hC070AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91943559"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91943559"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:06:39 -0700
X-CSE-ConnectionGUID: ZX9P7e8XTI+IIMdYDB1ecQ==
X-CSE-MsgGUID: v0Unc7DfQJ+mQFzzUgto+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246266674"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 22:06:35 -0700
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
Subject: [PATCH 9/9] iommu/vt-d: Support the new DMA_REMAP_OPT_OUT flag bit
Date: Thu,  4 Jun 2026 05:15:40 +0000
Message-ID: <20260604051540.592925-10-kevin.tian@intel.com>
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

Some BIOS already provides config options to expose/hide VT-d units
as a whole to/from system software. A new demand is to allow exposing
VT-d units but requesting system software to disable DMA remapping
while sustaining interrupt remapping. This can be communicated now by
setting the new DMA_REMAP_OPT_OUT flag bit in the DMAR table, as
introduced in VT-d spec v5.2 (section 8.1, DMA Remapping Reporting
Structure).

Introduce a new disabled state (DMAR_DISABLED_FW) for DMA_REMAP_OPT_OUT.
As the strongest disabled state, it cannot be overridden by user opts
or any force_on types. If tboot is enabled in the meantime, kernel will
panic. It is user responsibility to configure BIOS properly.

One cleanup is left for future - the DMAR flag is parsed multiple
times, in detect_intel_iommu(), dmar_platform_optin() (which can be
called at run-time), etc. Caching it is a cleaner way.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/dmar.c  | 32 ++++++++++++++++++++++----------
 drivers/iommu/intel/iommu.h |  4 ++++
 include/linux/dmar.h        |  1 +
 3 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 791b91a7be29..24b173d33afd 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -931,7 +931,9 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
  *
  * - DMAR_FORCEON_TBOOT: tboot strictly requires DMA remapping for secure
  *   boot hence supersedes any user opts ("iommu=off" or "intel_iommu=off")
- *   and weaker disables.
+ *   and weaker disables. But if firmware forces DMA remapping off (by
+ *   setting DMAR_REMAP_OPT_OUT in the DMAR table), no force_on is allowed.
+ *   Firmware settings must be changed to unblock tboot.
  *
  * - DMAR_FORCEON_PLATFORM: external-facing devices requires DMA
  *   remapping to prevent malicious downstream external devices from
@@ -975,31 +977,41 @@ static bool dmar_required(void)
 
 void __init detect_intel_iommu(void)
 {
-	int ret;
 	struct dmar_res_callback validate_drhd_cb = {
 		.cb[ACPI_DMAR_TYPE_HARDWARE_UNIT] = &dmar_validate_one_drhd,
 		.ignore_unhandled = true,
 	};
+	struct acpi_table_dmar *dmar;
+	int ret;
 
 	down_write(&dmar_global_lock);
 	if (no_iommu)
 		dmar_state = DMAR_DISABLED_USER;
 
 	ret = dmar_table_detect();
-	if (!ret)
-		ret = dmar_walk_dmar_table((struct acpi_table_dmar *)dmar_tbl,
-					   &validate_drhd_cb);
-	if (!ret && !iommu_detected && dmar_required()) {
+	if (!ret) {
+		dmar = (struct acpi_table_dmar *)dmar_tbl;
+		ret = dmar_walk_dmar_table(dmar, &validate_drhd_cb);
+	}
+
+	if (ret)
+		goto out;
+
+	if (dmar->flags & DMAR_REMAP_OPT_OUT) {
+		dmar_state = DMAR_DISABLED_FW;
+		pr_info("Firmware forces DMA remapping off\n");
+	}
+
+	if (!iommu_detected && dmar_required()) {
 		iommu_detected = 1;
 		/* Make sure ACS will be enabled */
 		pci_request_acs();
 	}
 
-	if (!ret) {
-		x86_init.iommu.iommu_init = intel_iommu_init;
-		x86_platform.iommu_shutdown = intel_iommu_shutdown;
-	}
+	x86_init.iommu.iommu_init = intel_iommu_init;
+	x86_platform.iommu_shutdown = intel_iommu_shutdown;
 
+out:
 	if (dmar_tbl) {
 		acpi_put_table(dmar_tbl);
 		dmar_tbl = NULL;
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 1832debf4982..67ecf3521fd4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1364,6 +1364,9 @@ enum dmar_force_on {
  * - DMAR_DISABLED_USER
  *     disabled by user opts ("intel_iommu=off" or "iommu=off").
  *
+ * - DMAR_DISABLED_FW
+ *     disabled due to firmware opt-out (DMAR_REMAP_OPT_OUT)
+ *
  * - '0' is invalid, compared to decide dmar enabled vs. disabled
  *
  */
@@ -1371,6 +1374,7 @@ enum dmar_force_on {
 #define DMAR_ENABLED		1
 #define DMAR_DISABLED_AUTO	-1
 #define DMAR_DISABLED_USER	-2
+#define DMAR_DISABLED_FW	-3
 extern int dmar_state;
 
 static inline bool dmar_is_enabled(void)
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 692b2b445761..63e35df2cef4 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -24,6 +24,7 @@ struct acpi_dmar_header;
 #define DMAR_INTR_REMAP		0x1
 #define DMAR_X2APIC_OPT_OUT	0x2
 #define DMAR_PLATFORM_OPT_IN	0x4
+#define DMAR_REMAP_OPT_OUT	0x8
 
 struct intel_iommu;
 
-- 
2.43.0

