Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527531ED80
	for <iommu@lists.linux.dev>; Thu,  3 Sep 2026 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428040; cv=none; b=m95r67JVmo2/n9ZN3Zj90//16xvJ8D1d+02oQOFBND0By9O5rXgyap9tP10nqOLud3cQeWbENF7CzxuS+iU0eM0d9zal+Wlazw5okCLXo3JrlEsVw08OS82qTF0ol5I45rGnD5XMP2y+3ec5Yvbs0lJqYaJKyZafBtjdiJZSLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428040; c=relaxed/simple;
	bh=JjaM8Q8pbXhUf77DZRM/RB98M4kYQ/sqUEXUiWhIolw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEdTxBh0wsFoDGgpqjr7ozt8Ml/gUZoxwi8/gxu1YrWMrfW2Ucbk01pDEqgyePJztU23xgPjBNmGgsEGMkQN1gOkQ0ZOkHJZj3b9G5/37SZflc5YpC/EohWPG8WZVOf3X9yG1xi4iYMMcqcK8mmI/UUvOfPEygYubgHwmkbftIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUPyg5mh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUPyg5mh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788428038; x=1819964038;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JjaM8Q8pbXhUf77DZRM/RB98M4kYQ/sqUEXUiWhIolw=;
  b=WUPyg5mhVsXl92vlSTEuwqR42P1+gsIke05hIBxDGbq+81EcO0Dw05zC
   VHmkROD7NM8+VEiMVsxOmM9GRTua0sL5nsUttOgSLMiCVnFmC/pSdPJ+P
   VwMsm+A1Y2TEoqvKTR3O1y4P00XbaaUu1NiA4DC7aWTF5t0TW4Mq/ehIx
   /dIQeoppGbaJ310nQdLkBPUc1dC+Ti0hYhKavdbqoCewr1l9StLVHMzT7
   CDzig9O3gswCY5b1nzk7mz67Khu0n4aOMh9YSKJL+tvTNNW7wq6qozKoe
   674BLTur9l2TKgTL8Xt0jZqRb28PU9Frq0lgAccpnM2qcj4OZ0zVJuQKb
   w==;
X-CSE-ConnectionGUID: jqUZe6TiRWCq3rReRK/4ng==
X-CSE-MsgGUID: Zofz5SRJQXqxh067cC8M3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="114450462"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="114450462"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 02:33:57 -0700
X-CSE-ConnectionGUID: fSQA+ubEQ12sRtiu4LMmhQ==
X-CSE-MsgGUID: ozEUE560Qwyi/XTLAJGsBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="270210511"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by orviesa009.jf.intel.com with ESMTP; 03 Sep 2026 02:33:54 -0700
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
	Pawel Randzio <pawel.randzio@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
Subject: [PATCH v3 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when TXT TPRs are active
Date: Thu,  3 Sep 2026 11:33:53 +0200
Message-ID: <20260903093353.415170-1-michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <d32d505b-5985-4139-86da-97d902c9aeb9@linux.intel.com>
References: <d32d505b-5985-4139-86da-97d902c9aeb9@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 13 +++++++++++++
 drivers/iommu/intel/iommu.c |  9 ++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b08cd20..c98a44487706 100644
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

