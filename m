Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F222777F3
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786094216; cv=none; b=loy0Alz4Nts5fPiixU5zLh3pBHCAd2m8kENFFdN0uuO3Ngy6JczzdHARwGXOoibghPSIxgOHBI9OeTGJy3u9LkSGV+BVpulnP8DZR3AvEfuJcJJ36Hx7V56f7DrGXM+RvLLLCScSxze2BpufF6gnLyNvZit0LbxXJJIzSa6G+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786094216; c=relaxed/simple;
	bh=SlT9f8tdsjssuDzpMXIOwjTSxLfHdf56exCPEZpwW74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKPnyinCLiCT+9lW6uMhTnqyaOykE/QiGGBmuZw5ExEF9r1U7ca0AAI/5dnScREqlywtDQ7+ZzRTJJvDRoHQ1hLJvEMi7UzR1z4Fj9eGIB736bMo0opJwbuBxXNulEiPYDOGmEnBm9pM6hnzqZF+Z7bkdhKvEhQpCUydxtpaGrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lm+9hy6K; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lm+9hy6K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786094213; x=1817630213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SlT9f8tdsjssuDzpMXIOwjTSxLfHdf56exCPEZpwW74=;
  b=Lm+9hy6KCag0BzB+Zeivmft24xtHAQPk/mtzesO9cpdpUaPGqTzCHSyL
   AQaY6sGYZGK50IcDh2jeFo+HeH9qTDWFHi+fNIRdPVciJOln7O0nxIeIz
   OCYCH1oUCG44qftDWLoLZ78bElxa3WXd8iT9FZ9qbFrf11dacxpqJCrgD
   VNG7qOms2uvpR/cPC+rvBEN/qvqCNMKHDyBMn5rwJPIWdKZ1Mkr4t/Hi0
   YksVUETfUADqeMBLfGnYpWkRltV4w1uhOrRmGWk/r7tM8QjdbLTNwqmL9
   h7Yxq3ZF+qSpeXSVsjiAwOgiMjjm9mKVGcLC8J3P1l5C2yV/LtFC6rCf8
   w==;
X-CSE-ConnectionGUID: 6I9KkdTBTq+iwlMDUVreLA==
X-CSE-MsgGUID: 8gmpYBXWRgeRHuuCaDD6Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="97853924"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="97853924"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 02:16:52 -0700
X-CSE-ConnectionGUID: B3/Sak72SEyCjQb6Nmo8ww==
X-CSE-MsgGUID: 5lyI2mpoQIWiSW6LiLEpzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; 
   d="scan'208";a="258494611"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by fmviesa010.fm.intel.com with ESMTP; 07 Aug 2026 02:16:50 -0700
From: Michal Camacho Romero <michal.camacho.romero@intel.com>
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
Date: Fri,  7 Aug 2026 11:16:31 +0200
Message-ID: <20260807091631.53485-1-michal.camacho.romero@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260603114500.2771319-3-michal.camacho.romero@intel.com>
References: <20260603114500.2771319-3-michal.camacho.romero@intel.com>
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

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

