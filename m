Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F9B466B68
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487121; cv=none; b=DFeIOrT2nnZKMQ5Ks8kjmMA9vco+YAt7nGEfvxpX1Y0Kash77zzvts/9eUlOu/f8FzyVze0HUSMMu9fROblBe4gISkAjZU7ilIquOZV60KrcQiqpGHiH2yfgp0kWXwReZ7p+FTAFY3TQIXxoWPIaiNc6IZQNBmWFJSceHIJ0UGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487121; c=relaxed/simple;
	bh=6qRWZvVBSjr6ZfK7n4iW3fn8SySXlmLsaQeeelhyTDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bit4XZMNk6m19CKvXEheAHebM2DD3nXkym8ZtqRPFDGZoOdxkz31DItJVp0BtukttBy44M/DZd2ga4LaSvI5EY5qdB34Lzge6ybXn/uiwHbdHU8slSNGsigt2N2VXUvbs8NoMIuAL9j3Oh5DlnwCnD+O5IbaZ2fUDB6S4jGeiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZU+enZI+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZU+enZI+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780487121; x=1812023121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6qRWZvVBSjr6ZfK7n4iW3fn8SySXlmLsaQeeelhyTDA=;
  b=ZU+enZI+0eY7Z1JfnLMe8z01KrMwV0UTSkUpTrGJympIfPNQKTMLvRO+
   dlaf1I9cL4G84SYeGoVvY5A3dr0Q1+VRPXDXpX/e9GBE5RKK/VfW2HXfR
   /HIn+ZOAoQpNglifbRTWLebh1/rfYRdX6abcCJ7qH4PNHhNV9PUWpes75
   66SYlGTZSVgB2an7QCDIrbS2mXpLcVjHIdgvzJIymjH+OOoYrNh1hg4qy
   RTgjelq1+xvxDqyUGEyf2brH+ZTV4Z822qlSrk3dsVRvXAaEA6Yl0klhh
   Q1P6tFuBw2NSHbqcKiKNndAgMyC+vrm6pcF7e4YNcv/UYtIcLASN/2OkO
   g==;
X-CSE-ConnectionGUID: xFEUmm7ETiGmhs3zxGoHcw==
X-CSE-MsgGUID: zVq1H/qQRMiz1eXCKx0rPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85180040"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="85180040"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 04:45:20 -0700
X-CSE-ConnectionGUID: pKOjM60hRLSnjNuLzAd0nA==
X-CSE-MsgGUID: M4rh32R2RTy6GevV2R31Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="243356029"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by orviesa010.jf.intel.com with ESMTP; 03 Jun 2026 04:45:17 -0700
From: Michal Camacho Romero <michal.camacho.romero@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Ning Sun <ning.sun@intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: x86@kernel.org,
	iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@intel.com>
Subject: [PATCH v1 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when TXT TPRs are active
Date: Wed,  3 Jun 2026 13:45:00 +0200
Message-ID: <20260603114500.2771319-3-michal.camacho.romero@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603114500.2771319-1-michal.camacho.romero@intel.com>
References: <20260603114500.2771319-1-michal.camacho.romero@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

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
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
---
 drivers/iommu/intel/dmar.c  | 12 ++++++++++++
 drivers/iommu/intel/iommu.c |  8 +++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index d33c119a935e..3ab09117c79e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -635,6 +635,8 @@ static int __init
 parse_dmar_table(void)
 {
 	struct acpi_table_dmar *dmar;
+	struct acpi_table_dtpr *dtpr;
+	void                   *txt_heap;
 	int drhd_count = 0;
 	int ret;
 	struct dmar_res_callback cb = {
@@ -670,6 +672,16 @@ parse_dmar_table(void)
 		return -EINVAL;
 	}
 
+	dtpr = tboot_get_dtpr_table(&txt_heap);
+	if (dtpr) {
+		/* TPR is enabled
+		 * This will also tell not to establish IOMMU PMRs
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
index 4d0e65bc131d..486693a13dc6 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2540,6 +2540,12 @@ static __init int tboot_force_iommu(void)
 	if (!tboot_enabled())
 		return 0;
 
+	/* If TPR is enabled we don't need to force IOMMU,
+	 * TPR set by SINIT ACM will take care of DMA protection
+	 */
+	if (tboot_is_tpr_enabled())
+		return 0;
+
 	if (no_iommu || dmar_disabled)
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
@@ -2597,7 +2603,7 @@ int __init intel_iommu_init(void)
 		 * calling SENTER, but the kernel is expected to reset/tear
 		 * down the PMRs.
 		 */
-		if (intel_iommu_tboot_noforce) {
+		if (intel_iommu_tboot_noforce || tboot_is_tpr_enabled()) {
 			for_each_iommu(iommu, drhd)
 				iommu_disable_protect_mem_regions(iommu);
 		}
-- 
2.53.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

