Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83B41834B
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097651; cv=none; b=bsZV+UDItZ85jcLFoO20SCSqvR9/F4Zj6Xo7P8hD1ZXmjsxcll+PGjjrIXf3nwA5E+atj7Om2FyRoiu3bwrEjFoSSIxy3+1yiy+uauCtY2qykOeo10spEPLA1duwZ2Sx9I2wJHzFVy39dVEl07eUai+5XHF2o+yWzMgZP9XP2CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097651; c=relaxed/simple;
	bh=0a79vO7UMi8mDAskP0yWAWAEi/DJOJkGZ2+ZqCU2qOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWAP9BstYSdGbQvoIk14S/e9eriN+BZZsD6RqkBWOP000Mi0pFJA/hS+r0hnyMBrrwtX8SNp5HJk/I76UuJebRWPmggKD7OggVauf6DcIV+NUiVjAQAfuhj7SGnR1vc/G1fzyeDnRwlfEp0wEUU5M/XFBjQSkILViVK94lLHv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bhEN1Sib; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bhEN1Sib"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786097649; x=1817633649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0a79vO7UMi8mDAskP0yWAWAEi/DJOJkGZ2+ZqCU2qOc=;
  b=bhEN1SibZDYoTJFsffVXbsSLTDVHiTw+ZYItYFap7idlbJS5hDAoQj9A
   KVtoQLX2JLQkGgkQHR1DfeSm2Z5+6175XL6PvCiGvWSIh8rl78DlR/+fv
   Ys/Jyz/AnhpMhhNOd2Cl9c9Nx8zynAoIPKZnnUXLCJOuUWxW2nfjwlnSW
   rfMqDsJHam4rAlIpIpgLSH3QwqLeGsgHLOTs44t54pjJVA9gLw8/BICzK
   p90HhmZ2QdnL2KIjPYhhYyA/J3memVlXYqL1wVAUIGSEUDuhJkivSDeAr
   4wXU0ePnCyfnfxYca5ElHZnvMVBNh1UqTbrSIkGC+v+kNEsK1zLEt28rX
   w==;
X-CSE-ConnectionGUID: zKF8Dmn0R3yef9V+RZ+RQA==
X-CSE-MsgGUID: 9Y9Biwm9R0+hgSF1FLcYjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86554748"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="86554748"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 03:14:08 -0700
X-CSE-ConnectionGUID: omYkOdapTUG0zVWIACloyg==
X-CSE-MsgGUID: Fzp9inHVTVOuxAktjyXaYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="259754448"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by fmviesa008.fm.intel.com with ESMTP; 07 Aug 2026 03:14:06 -0700
From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
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
	Pawel Randzio <pawel.randzio@intel.com>
Subject: [PATCH v2 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when TXT TPRs are active
Date: Fri,  7 Aug 2026 12:14:03 +0200
Message-ID: <20260807101403.61259-1-michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260603114500.2771319-3-michal.camacho.romero@intel.com>
References: <20260603114500.2771319-3-michal.camacho.romero@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Camacho Romero <michal.camacho.romero@intel.com>

When Intel TXT Protection Regions (TPRs) are present in the DTPR table,
hardware-level DMA protection is already enforced by the SINIT ACM.
In this case:

- Skip forcing IOMMU enablement in tboot_force_iommu(), since TPRs
  already provide DMA protection.
- Tear down PMRs during intel_iommu_init() when TPRs are active,
  while PMRs are redundant with TPR-based protection.
- Call tboot_parse_dtpr_table() from parse_dmar_table() to disable
  TPR regions early, allowing the kernel to manage DMA protection
  prior to the OS boot.

Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.pdf
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
---
 drivers/iommu/intel/dmar.c  | 13 +++++++++++++
 drivers/iommu/intel/iommu.c |  9 ++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 767ec092accd..17c26d222253 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -635,6 +635,8 @@ static int __init
 parse_dmar_table(void)
 {
 	struct acpi_table_dmar *dmar;
+	struct acpi_table_dtpr *dtpr;
+	void *txt_heap;
 	int drhd_count = 0;
 	int ret;
 	struct dmar_res_callback cb = {
@@ -670,6 +672,17 @@ parse_dmar_table(void)
 		return -EINVAL;
 	}
 
+	dtpr = tboot_get_dtpr_table(&txt_heap);
+	if (dtpr) {
+		/*
+		 * TPR is enabled. This will also tell not to establish IOMMU
+		 * PMRs.
+		 */
+		tboot_parse_dtpr_table(dtpr);
+		iounmap(txt_heap);
+	}
+
+	txt_heap = NULL;
 	pr_info("Host address width %d\n", dmar->width + 1);
 	ret = dmar_walk_dmar_table(dmar, &cb);
 	if (ret == 0 && drhd_count == 0)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 849d06dfe1ae..5bc6f2dd25c4 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2543,6 +2543,13 @@ static __init int tboot_force_iommu(void)
 	if (!tboot_enabled())
 		return 0;
 
+	/*
+	 * If TPR is enabled we don't need to force IOMMU, TPR set by SINIT
+	 * ACM will take care of DMA protection.
+	 */
+	if (tboot_is_tpr_enabled())
+		return 0;
+
 	if (no_iommu || dmar_disabled)
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
@@ -2600,7 +2607,7 @@ int __init intel_iommu_init(void)
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

