Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E76446063
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887684; cv=none; b=Brh3smeBA6zrRk02g8wZSoueOYXMBo7eUxkGGgjTRlA0M9UJWy/hLE/4evTt14dXFRO/zWQGD0034Q2hgrMS1W2TiAXfynfNpyHgTkJ1u8SYD/uQwNCY8BbOJNSqAnE7OyvPwXJo7agedtJw5F2GYuhN3y7JlArOYw+VDQx8Fa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887684; c=relaxed/simple;
	bh=SdZ/l+fYJwUzZGSzWTxaBMIaqf3zUpO7xK8W3xhNzzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKzP2JmIs0hZ/Yp7TdsDO99tpo9CLR7JqPC9nnDLsBXym3mX8paBYuflS3/yAxMyAv3P5tNESSKOZR2rr8nZ6cHdpOEvDRBQ7XxzMDaw6c+Qb9ACxVVaQhpRtMe6zQeZ2to2f4Rkt8deWAoQ/rgxf9C7yuAi6jLMJkp43iH0wxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SNSN7RNf; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SNSN7RNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887683; x=1817423683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SdZ/l+fYJwUzZGSzWTxaBMIaqf3zUpO7xK8W3xhNzzc=;
  b=SNSN7RNfpjhm/qEGtW5+ALCLOcx1op9C8judtbUONJVVEoB9ymRM8vNp
   ovOIg5FVb01MJKsBIO7lubFOdCyof5+y/Lp/FT7bLFDJ+Zzc7d6crgBsU
   6WFlCIEFYHRtRo3oYLqnDIow8l0APZoQ+pgT6epqVZeARQqB0h0GbVX6e
   mtDFrPXPTR/2DQNgDaGHFRk69PThWT87c0ddQEA6uqoNlmW14T2Wemwt5
   XFFVUSlkfbuReO0p0P7eNKrjGz2vUn17Sk/joQUtbZYs7BQX8ITLLSZCT
   tOKotCNkzJ201XTGDHmIopOt8k0mtQLsWWZhGvvnxmbdGvwSguhfRA0n3
   Q==;
X-CSE-ConnectionGUID: up7X3+2cTbGF4GPT31Dl/w==
X-CSE-MsgGUID: Czg95ElqQgydZTww98AOfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263263"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263263"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:42 -0700
X-CSE-ConnectionGUID: Pm33gKI3R++ru4XhCpbKiw==
X-CSE-MsgGUID: dw1tCIXySpWjwA1Mw1PcXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324363"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:39 -0700
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
Subject: [PATCH v2 08/19] iommu/vt-d: Consolidate dmar policy management and force_on logic
Date: Wed,  5 Aug 2026 07:43:02 +0800
Message-ID: <20260804234314.3087110-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Tian <kevin.tian@intel.com>

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
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 45 ++++++++++++++++++++++++++++
 drivers/iommu/intel/dmar.c  | 58 ++++++++++++++++++++++++++++++++++---
 drivers/iommu/intel/iommu.c |  7 +++++
 3 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 785aa3b62055..dd2376a079b9 100644
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
+ *     force to turn on (e.g. by tboot or platform opt-in).
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
+	if (dmar_policy_on())
+		return true;
+
 	if (!intel_iommu_tboot_noforce && tboot_enabled())
-		return true;
+		return dmar_can_force_on(DMAR_FORCEON_TBOOT);
 
-	if (!no_iommu && (!dmar_disabled || dmar_platform_optin()))
-		return true;
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
index 4d03d9a517de..2f0cd1714923 100644
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
-- 
2.43.0

