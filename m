Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED786493D45
	for <iommu@lists.linux.dev>; Thu,  1 Oct 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856762; cv=none; b=TN/IJRu/1BWj0JbCYLqumCSPCeSggzVvyCf4rVKdYo8q3z4UDfFg5GTjP+0gsj0t/u1SG7XHM5XyAvJdjUTtgWVpY9qcccPBSC9VL0WNX5dEc4Oni0VLP5VJJ48KgYFJAisaaCsb1xvb3CJOVRSRnbZBm7rUm7BjN1CfHvCXP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856762; c=relaxed/simple;
	bh=ZxCdFAWOLjxobLBrBzF661B0SGWR9qyPAncoZzYhjH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lpc2jcJGP2hu/Fr+FERu/rYuLcWNb2+yj9xdxxqaIbm9tL0pkDAZERbBmqv/yn4+9nEwi8WFLVgFlOwBkoovl3ti83+c0DHfwW/INlL+qBS+7Zz/NEHd0miD9ZZxRL5uGj4ajzHcov7bra/fPS3NoCJvcC/eYJ6GhP+BRhf2xKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q9RoBUC7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q9RoBUC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790856758; x=1822392758;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZxCdFAWOLjxobLBrBzF661B0SGWR9qyPAncoZzYhjH8=;
  b=Q9RoBUC7Spgkx9365peiuXtVBkt8YnocKZLD5RDJbIXy6J0r6uglS67h
   F3r85QRL6uVOu1dZzvjlxCS+KBZk4AlJeOZIMl7ZMOc4CfOVcWn/byLX1
   GiBJ6ORfzwcmJxYJdcdA4bUBBLOP33awzldnaVUI3R0jaFglc/d9DeTU4
   o03w5/iQmokpMEqaJ9k0OEKcoION8QiRF7RZsV0Y1PB9SvFDYl2G85vtX
   TMSdSfyVj23QVkqN+WumELw/y/M4mO/A4/AY0jgUm25x1s+/nqeLSbVOt
   YjmXnjk8jpYD7NV1bz8Vt7mOSE/HfcP67a70so+isSIP6196JkIihpa8M
   w==;
X-CSE-ConnectionGUID: 8DyIB+wMRZemHCsX2u9/SA==
X-CSE-MsgGUID: i0jm0bjMTZqAN5G+c7zQvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94092092"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="94092092"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 05:12:32 -0700
X-CSE-ConnectionGUID: pM/eqZF2Q+GzBtWytpXk0g==
X-CSE-MsgGUID: bl/fAGK8R8SX7BWvdSzOtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="302222527"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by fmviesa002.fm.intel.com with ESMTP; 01 Oct 2026 05:12:30 -0700
From: michal.camacho.romero@linux.intel.com
To: Baolu Lu <baolu.lu@linux.intel.com>,
	Ning Sun <ning.sun@intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Michal Camacho Romero <michal.camacho.romero@intel.com>,
	x86@kernel.org,
	iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
Subject: [PATCH v4 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when TXT TPRs are active
Date: Thu,  1 Oct 2026 14:12:29 +0200
Message-ID: <20261001121229.1486711-1-michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <c88f7c82-1b48-4ab2-95d6-73f920879f76@linux.intel.com>
References: <c88f7c82-1b48-4ab2-95d6-73f920879f76@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>

When Intel TXT Protection Regions (TPRs) are present in the DTPR table,
hardware-level DMA protection is already enforced by the SINIT ACM.
In this case:

- Skip forcing IOMMU enablement in tboot_force_iommu(), since TPRs
  already provide DMA protection.
- Tear down PMRs during intel_iommu_init() when TPRs are active,
  while PMRs are redundant with TPR-based protection.
- Call tboot_disable_tprs() from parse_dmar_table() to disable
  TPR regions early, allowing the kernel to manage DMA protection
  prior to the OS boot.

Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.pdf
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
---
Thanks for the careful review. Summary of how each point is handled:

Answer for Question No.1:
   The DTPR handling is now invoked only after dmar_walk_dmar_table()
   returns success. If DMAR parsing fails, parse_dmar_table() returns the error
   and IOMMU initialization aborts before any TPR teardown, so the TPRs stay
   active and DMA protection is retained. They are disabled only, if DMAR parse
   succeeds.

Answer for Question No.2:
   I've replaced tboot_parse_dtpr_table function with the tboot_disable_tprs(),
   which is defined in the Kernel patch
   "[PATCH v5 1/2] x86/tboot: Add support for parsing DTPR table and disabling TPRs".
   It is void type function. It verifies now, both if the DTPR Table is
   present and if TXT Heap exists. If not then function prints a proper warning
   message and returns.

The rest of your suggestions (including the stale txt_heap = NULL cleanup) have
been applied in the current patch version.

Regards,
Michal Camacho Romero

 drivers/iommu/intel/dmar.c  | 18 ++++++++++++++++--
 drivers/iommu/intel/iommu.c |  9 ++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b08cd20..e8ec2dfe3e33 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -672,8 +672,22 @@ parse_dmar_table(void)
 
 	pr_info("Host address width %d\n", dmar->width + 1);
 	ret = dmar_walk_dmar_table(dmar, &cb);
-	if (ret == 0 && drhd_count == 0)
-		pr_warn(FW_BUG "No DRHD structure found in DMAR table\n");
+	if (ret == 0) {
+		/* After DMAR Table successful parsing disable TPRs if necessary */
+		void __iomem           *txt_heap;
+		struct acpi_table_dtpr *dtpr = tboot_get_dtpr_table(&txt_heap);
+
+		if (dtpr) {
+			/*
+			 * TPRs are enabled. This will also tell not to establish IOMMU
+			 * PMRs. It is necessary to parse DTPR Table and disable active TPRs.
+			 */
+			tboot_disable_tprs(dtpr, &txt_heap);
+		}
+
+		if (drhd_count == 0)
+			pr_warn(FW_BUG "No DRHD structure found in DMAR table\n");
+	}
 
 	return ret;
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8..ce40b1bf0296 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2563,6 +2563,13 @@ static __init void tboot_force_iommu(void)
 	if (!tboot_enabled() || intel_iommu_tboot_noforce)
 		return;
 
+	/*
+	 * If TPR is enabled we don't need to force IOMMU, TPR set by SINIT
+	 * ACM will take care of DMA protection.
+	 */
+	if (tboot_is_tpr_enabled())
+		return;
+
 	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
 		panic("tboot: Failed to force IOMMU on\n");
 
@@ -2623,7 +2630,7 @@ int __init intel_iommu_init(void)
 		 * calling SENTER, but the kernel is expected to reset/tear
 		 * down the PMRs.
 		 */
-		if (intel_iommu_tboot_noforce) {
+		if (intel_iommu_tboot_noforce || tboot_is_tpr_enabled()) {
 			for_each_iommu(iommu, drhd)
 				iommu_disable_protect_mem_regions(iommu);
 		}
-- 
2.55.0

