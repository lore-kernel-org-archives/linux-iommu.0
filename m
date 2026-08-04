Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A8A45199E
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887695; cv=none; b=BGAZWRrQ9qaOkqt/imo42ryAnheIPZ/LzdVz4WhaA7gbtrZVC0PSPcueH7whTGY+hghKJ2DK8LPmYZOLMUib//iGVrDkI9YTaODjT9p+Ef3b44P00A7diE90+IOYnYvYGVoaYE55ebyYMxClEq/C4KmxBrsHUZTnzKoWNHfNqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887695; c=relaxed/simple;
	bh=ofazySFC81vyyWifIxKn03mdBwsTstjvWNV/8XW81E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbcUWpkrJNJhvYi5W7XOMuXjj+Z+UaVCg50vVXQbwl0w13jx7FUjxU0BlVbu3FixrdauzQg3VNtM5sWJPogbpstRf5oVQ8aeW2o8IL5KcgIpz1F/IaEKnnoVkdYpOwiybJXxlD757UEbVTbAw6b9mdEo4AFQgVaVdQC4XBATYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdL2YAsR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdL2YAsR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887694; x=1817423694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ofazySFC81vyyWifIxKn03mdBwsTstjvWNV/8XW81E4=;
  b=HdL2YAsRJ2I9MIK+blsPNIprk3lLaE6t4emiRTuRKepOahpfWN/DQ6Az
   1NPy1p1Yxt0pqZgDXxdOrMi+Igzw3Z4HFndI4R0LnxsFePZTUd61CGIxr
   nb3BYULSY6kh5dYZfT1jknqC0Wct3upfsjEYBMR1G6S8Mgg1gxxpQXXwo
   1JwWv1B7+IvRHmgExmB1mCpSw+hcqJe46SEjm3h0HIqC4XkW5wTrbDuJ+
   hINlaUub80ug9LzcISH09CZVMBrarQpwvkRDlrf/zI1cvnEb7/laKOtyi
   RPtiWUCaZW8yt6Gv5Kj+OzMJK5ZJvUBjTwxpYHEQIGvqoh//BNJT5e2hR
   g==;
X-CSE-ConnectionGUID: 0xWFPmuIRiq8vLc5maczFg==
X-CSE-MsgGUID: /wIvIHBcS3i+rHatAFe5dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263324"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263324"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:54 -0700
X-CSE-ConnectionGUID: Qk46S+E6R9aOhmH+iUlUGg==
X-CSE-MsgGUID: bxNFXR1UT0aSqf6xqa9M/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324392"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:51 -0700
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
Subject: [PATCH v2 13/19] iommu/vt-d: Support the new DMA_REMAP_OPT_OUT flag bit
Date: Wed,  5 Aug 2026 07:43:07 +0800
Message-ID: <20260804234314.3087110-14-baolu.lu@linux.intel.com>
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

Some BIOS already provides config options to expose/hide VT-d units
as a whole to/from system software. A new demand is to allow exposing
VT-d units but requesting system software to disable DMA remapping
while sustaining interrupt remapping. This can be communicated now by
setting the new DMA_REMAP_OPT_OUT flag bit in the DMAR table, as
introduced in VT-d spec v5.2 (section 8.1, DMA Remapping Reporting
Structure).

Introduce a new off policy (DMAR_FW_OFF) for DMA_REMAP_OPT_OUT. As
the strongest off policy, it cannot be overridden by user opts or
any force_on types. If tboot is enabled in the meantime, kernel will
panic. It is user responsibility to configure BIOS properly.

One cleanup is left for future - the DMAR flag is parsed multiple
times, in detect_intel_iommu(), dmar_platform_optin() (which can be
called at run-time), etc. Caching it is a cleaner way.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  4 ++++
 include/linux/dmar.h        |  1 +
 drivers/iommu/intel/dmar.c  | 34 ++++++++++++++++++++++++----------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 9805edb8c7df..656cd311ed9a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1375,6 +1375,9 @@ enum dmar_force_on {
  * - DMAR_USER_OFF
  *     turn off by user opts ("intel_iommu=off" or "iommu=off").
  *
+ * - DMAR_FW_OFF
+ *     turn off due to firmware opt-out (DMAR_REMAP_OPT_OUT)
+ *
  * - '0' is invalid, compared to decide the on/off policy
  *
  */
@@ -1382,6 +1385,7 @@ enum dmar_force_on {
 #define DMAR_ON			1
 #define DMAR_DEFAULT_OFF	-1
 #define DMAR_USER_OFF		-2
+#define DMAR_FW_OFF		-3
 extern int dmar_policy;
 
 static inline bool dmar_policy_on(void)
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
 
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index bc2f6597eb27..33bfaeafa7c6 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -930,7 +930,9 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
  *
  * - DMAR_FORCEON_TBOOT: tboot strictly requires DMA remapping for secure
  *   boot hence supersedes any user opts ("iommu=off" or "intel_iommu=off")
- *   and weaker off policies.
+ *   and weaker off policies. But if firmware forces DMA remapping off (by
+ *   setting DMAR_REMAP_OPT_OUT in the DMAR table), no force_on is allowed.
+ *   Firmware settings must be changed to unblock tboot.
  *
  * - DMAR_FORCEON_PLATFORM: external-facing devices requires DMA
  *   remapping to prevent malicious downstream external devices from
@@ -939,6 +941,7 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
  *
  * In a nutshell, "trusted boot environment" is considered stronger than
  * "user choices", which in turn is stronger than "platform opt-in hint".
+ * But they are all meaningless when it's forced off by "firmware".
  */
 bool dmar_can_force_on(enum dmar_force_on force_on)
 {
@@ -976,31 +979,42 @@ static bool dmar_required(void)
 
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
 		dmar_policy = DMAR_USER_OFF;
 
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
+		dmar_policy = DMAR_FW_OFF;
+		pr_info("Firmware forces DMA remapping off\n");
+		pr_info("Any user opt or tboot/platform force_on will be ignored\n");
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
-- 
2.43.0

