Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B62369203
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 06:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972084; cv=none; b=KE9noCHxc58RheZ4U2b2SxTI7xEX7NWgICK6olAWSL5kBdAZKHdlkDqCuiXe853aDvqmX0h4R4m5g7pbs70gGfltI8fMSD4OZ5kaiyVh2Tew5spV5Z5N8Uc0E65qYzDoEESIw7WjLaoNPRC8XOwtClakqA5DSVBhFPEw3qWAOKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972084; c=relaxed/simple;
	bh=EJZRcaqr0ohjq2NoOlo+z55pNr++8TebuEPMizarM5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlWyF0tl/alyL+L96wfQvd5afjCK+LhC+mJaPOlS5XRcKwULMnxXL9Eu2sp4SZnmjkicj8t4U1qaSEs6c2dyMPAXswY/iuEnNCIUCBqVB3DGWFYMGFhVNl/LoFuzi71uxEhrOnNEILZk1Pj+NVfZzr5y8SdGxPuIxKgtTB3PyzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlBHx3Dp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlBHx3Dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972081; x=1814508081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EJZRcaqr0ohjq2NoOlo+z55pNr++8TebuEPMizarM5U=;
  b=DlBHx3DpOmDU8BYc0GVuXbQg80lO7BRyzsKrBQrw7bJOJG6XBP9eswuy
   UUG8ZCNBiUn8SMwVS+l1FyRqAnUTLa52mRnMijZFZggLIUa2u5mc7Dvy5
   zvU+7t6E+u/mGuE5U4/JHnAF6Jxn7K8+GoTrDFQkOmGhiVx6ym7PzFKwg
   MvTWbBmL0GB5y8I7qY0rTyHawyIDj+EkwCqo4a2Spa9Xaj513xiFjDn2Z
   mwR3nD+mbHiTNWBq1KGB2TRG8z+CimglycJzmah+NSN+fdmqPjlG5esJc
   A4IBnW6wSLGdmWV/dho+tVXGm718GnH/1g3vXcYUOokH6IcTQ5LFBAGjD
   A==;
X-CSE-ConnectionGUID: i/w2rSC7TfePf2el/NIbzw==
X-CSE-MsgGUID: 7zH1sZs2QZi/1ZMeWLmL5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256475"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256475"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:21 -0700
X-CSE-ConnectionGUID: Mjk7jBcZR9q3ye056cBB7w==
X-CSE-MsgGUID: c5PSwTiSRZyJoYc3gakU0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425828"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:18 -0700
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
Subject: [PATCH v2 4/9] iommu/vt-d: Consolidate dmar policy management and force_on logic
Date: Thu,  2 Jul 2026 06:12:11 +0000
Message-ID: <20260702061216.388743-5-kevin.tian@intel.com>
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

Currently the dmar on/off is carried by multiple variables (no_iommu,
dmar_disabled, no_platform_optin, etc.) with error-prone force_on logic
scattered in multiple places.

Unify/centralize the policy/priority management for various force_on
scenarios.

No functional impact except one case - "intel_iommu=off" sets
no_platform_optin which is checked in platform_optin_force_iommu()
but not in detect_intel_iommu(), leading to ACS unnecessarily requested
when iommu could not be forced on later. Now with the unified logic
this becomes more consistent.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/dmar.c  | 58 ++++++++++++++++++++++++++++++++++---
 drivers/iommu/intel/iommu.c |  7 +++++
 drivers/iommu/intel/iommu.h | 45 ++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index e32685402f74..bc2f6597eb27 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -915,14 +915,61 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
 	return 0;
 }
 
+/*
+ * Centralized helper for deciding the force_on policy
+ *
+ * dmar off policies (for DMA Remapping) are defined from stronger
+ * (more negative values) to weaker (less negative values).
+ *
+ * When a force_on type is passed in, it is associated to a reference
+ * level for comparison. force_on is permitted when dmar is in a
+ * off policy less negative than the reference level (if the policy is
+ * on then the check is always true).
+ *
+ * For supported force_on types:
+ *
+ * - DMAR_FORCEON_TBOOT: tboot strictly requires DMA remapping for secure
+ *   boot hence supersedes any user opts ("iommu=off" or "intel_iommu=off")
+ *   and weaker off policies.
+ *
+ * - DMAR_FORCEON_PLATFORM: external-facing devices requires DMA
+ *   remapping to prevent malicious downstream external devices from
+ *   composing DMA attacks. force_on is permitted only if dmar policy is
+ *   off by build configurations (CONFIG_INTEL_IOMMU_DEFAULT_ON=off).
+ *
+ * In a nutshell, "trusted boot environment" is considered stronger than
+ * "user choices", which in turn is stronger than "platform opt-in hint".
+ */
+bool dmar_can_force_on(enum dmar_force_on force_on)
+{
+	int level;
+
+	switch (force_on) {
+	case DMAR_FORCEON_TBOOT:
+		level = DMAR_USER_OFF;
+		break;
+	case DMAR_FORCEON_PLATFORM:
+		level = DMAR_DEFAULT_OFF;
+		break;
+	default:
+		level = INT_MAX;
+		pr_warn("Unsupported force_on type (%d)\n", force_on);
+		break;
+	}
+
+	return dmar_policy >= level;
+}
+
 static bool dmar_required(void)
 {
-	/* tboot supersedes any user/platform opt */
-	if (!intel_iommu_tboot_noforce && tboot_enabled())
+	if (dmar_policy_on())
 		return true;
 
-	if (!no_iommu && (!dmar_disabled || dmar_platform_optin()))
-		return true;
+	if (!intel_iommu_tboot_noforce && tboot_enabled())
+		return dmar_can_force_on(DMAR_FORCEON_TBOOT);
+
+	if (dmar_platform_optin())
+		return dmar_can_force_on(DMAR_FORCEON_PLATFORM);
 
 	return false;
 }
@@ -936,6 +983,9 @@ void __init detect_intel_iommu(void)
 	};
 
 	down_write(&dmar_global_lock);
+	if (no_iommu)
+		dmar_policy = DMAR_USER_OFF;
+
 	ret = dmar_table_detect();
 	if (!ret)
 		ret = dmar_walk_dmar_table((struct acpi_table_dmar *)dmar_tbl,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4e7ba60f3a0a..c66909b8e33b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -199,6 +199,11 @@ static LIST_HEAD(dmar_satc_units);
 
 static void intel_iommu_domain_free(struct iommu_domain *domain);
 
+#ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
+int dmar_policy = DMAR_ON;
+#else
+int dmar_policy = DMAR_DEFAULT_OFF;
+#endif
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
 
@@ -240,9 +245,11 @@ static int __init intel_iommu_setup(char *str)
 
 	while (*str) {
 		if (!strncmp(str, "on", 2)) {
+			dmar_policy = DMAR_ON;
 			dmar_disabled = 0;
 			pr_info("IOMMU enabled\n");
 		} else if (!strncmp(str, "off", 3)) {
+			dmar_policy = DMAR_USER_OFF;
 			dmar_disabled = 1;
 			no_platform_optin = 1;
 			pr_info("IOMMU disabled\n");
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 785aa3b62055..d2e787243532 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1351,6 +1351,51 @@ static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
 		DMA_ECMD_ECCAP3_ESSENTIAL;
 }
 
+enum dmar_force_on {
+	DMAR_FORCEON_PLATFORM,
+	DMAR_FORCEON_TBOOT
+};
+
+/*
+ * On policies are positive, with more positive value being stronger.
+ * Off policies are negative, with more negative value being stronger.
+ *
+ * 'dmar' here refers to DMA remapping instead of the dmar/iommu unit.
+ *
+ * - DMAR_FORCE_ON:
+ *     force to turn on (e.g. by tboot or platform optin).
+ *
+ * - DMAR_ON:
+ *     turn on by build configuration (CONFIG_INTEL_IOMMU_DEFAULT_ON=on)
+ *     or user opts ("intel_iommu=on").
+ *
+ * - DMAR_DEFAULT_OFF
+ *     turn off by build configuration (CONFIG_INTEL_IOMMU_DEFAULT_ON=off).
+ *
+ * - DMAR_USER_OFF
+ *     turn off by user opts ("intel_iommu=off" or "iommu=off").
+ *
+ * - '0' is invalid, compared to decide the on/off policy
+ *
+ */
+#define DMAR_FORCE_ON		2
+#define DMAR_ON			1
+#define DMAR_DEFAULT_OFF	-1
+#define DMAR_USER_OFF		-2
+extern int dmar_policy;
+
+static inline bool dmar_policy_on(void)
+{
+	return dmar_policy > 0;
+}
+
+static inline bool dmar_policy_off(void)
+{
+	return dmar_policy < 0;
+}
+
+bool dmar_can_force_on(enum dmar_force_on force_on);
+
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
 extern int intel_iommu_tboot_noforce;
-- 
2.43.0

