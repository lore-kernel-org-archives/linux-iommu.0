Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CC369991
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972101; cv=none; b=i0kSqTaqkxyi1z6/EK0l2nrcPnBpxLehWfxfAoTh+00gfZ9RY0zNIxT/BH+YutvcDDyP5OWsmx7rj7ur/ui/Q6rQ2LyM+y1w00/iba0PRLqgvCE+XiZ814GZTdWvJb/Zs9OJUoUFHblVUCH6D3R3r7e9nGoBzh7aMDXBZu4uNkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972101; c=relaxed/simple;
	bh=xB+gddHtAGekDaFJDNCPBJN1YOZsl9Fbjjf0WUAyJfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0pnD8RfrnTkcSjpab80vnaEjz7+jYED99j5SG9YSDG5W16sGqBY8An2xteQuEZn+QvGqDDX6DJlV467/14L5hbgI2HhGzX0Cgz0/ivT+iyLglirf18EmfbIo3gbW/LEY8gFOiFUSjW94HiVTifS7JitpdlyMMLmBR3IqcP8rp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvF4dApn; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvF4dApn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972099; x=1814508099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xB+gddHtAGekDaFJDNCPBJN1YOZsl9Fbjjf0WUAyJfc=;
  b=KvF4dApnMwz8C6D9Szy8hYoBk6+EAXOEIfdonxr67IullYyTx+HVtHSK
   prsuZFQaGkQiaAcvIZzUmbFkSd/LSXa3sG9HW7q/lvtCbgVrnnNAjQTxV
   rWqSz7l8kzgVLt0bHVaYqxmfzkQj4D6x//NaIY2wd9F27qeEXKnIYwiER
   3Y3SNUpGZEP3TqKvMr0FPT5nEdCbpJRLxZ8nGiqxQ9SXgWdBx7pjctRID
   m6ta3Plr5ezxMt6pWnB62YR5RAgE4rcOkj0/LzhddBEV8dgX3sLpGVgqy
   n+IfyAJjxKd4sp7KzBpUHHCue3x+NeLgnkOwgw9bA/R1Kb0XnDPYxTLug
   A==;
X-CSE-ConnectionGUID: IGgD5SP2QUuB5q3Fm81Fjg==
X-CSE-MsgGUID: HdowKgC+QKCWkCGkP5C8yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256528"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256528"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:37 -0700
X-CSE-ConnectionGUID: qkMIHEaPRwyH2y2zaROMYg==
X-CSE-MsgGUID: 2iiExLxnS+WUOM8y/Hz69g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425922"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:34 -0700
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
Subject: [PATCH v2 9/9] iommu/vt-d: Support the new DMA_REMAP_OPT_OUT flag bit
Date: Thu,  2 Jul 2026 06:12:16 +0000
Message-ID: <20260702061216.388743-10-kevin.tian@intel.com>
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
---
 drivers/iommu/intel/dmar.c  | 34 ++++++++++++++++++++++++----------
 drivers/iommu/intel/iommu.h |  4 ++++
 include/linux/dmar.h        |  1 +
 3 files changed, 29 insertions(+), 10 deletions(-)

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
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ad4d1aafd12c..bad7db37d899 100644
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
 
-- 
2.43.0

