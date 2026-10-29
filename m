Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793281428;
	b=N0FBC5obmciX+DngihUFjCMfYOD/V6hTkXP1ZxO2ACYFa/RQLOIX5QkK/+5tEh4JgyRi
	 2M4CE0GsNE2prrALef0eJc7zUk/ET45/WpHmE2OfePDvSjhgDLn3JPZ1xGI6gKm33OUJB
	 KFiexrZ60PBmjB5K6T4JaY1GVk9gAasE6y6n4sfNzQGQAPcWkZZwPS84zxYf2AguV6IyF
	 52CmzLC/io6bTTXJ67qVXQwGVchYaGbDo4omF5g/dFJ5d1fTslbGYLk5M/9v24sUj3HjI
	 HYfyY8PB3+DYMAGAuZLJX8NwA+X8XdBleBh41okBLdVVmgKP0ylj3FwvFLTRyxQFhtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793281428;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=MJn0jfefkcjE8a3q5VwEl1+DWK/Z06yd9iQxNjsHeT0=;
	b=DsoZccfoh9iyv8h/3VBHRx0Kn8Lzy5z00d0zkNhbZtQpSGoOAjsPAf3fm7RXZMeZs3UU
	 Z5lXiQn5KL8ZBCqysdRta2MrF5Rd/XKujKKYT+HUOYnlj70x+F6BSvxUcz4Wi997llhKo
	 GmK8vk6vaNayc3ehaGgRthu67UDECATGbIYxUIwrZDcHnAGjQn5j58dYiheUromAd/eom
	 pmRSiOL+DZYdiT3eSNZRZ30IY70gABeFSX/dIlS1AZ/Ce3rzXbe2ter+ALDWRCbruD4DD
	 Sp3VKQF+NHWnU5TbYJ3z/88/ugQHfzvtq6J0G3JgCMye85coccXrsNvPFEC6hLicyHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Q//xnx6C";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6A606A31C
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q//xnx6C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793281427; x=1824817427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zFZt8PgITT+BpaBniFh8F+LtZH9LpS21POyhExpYbzI=;
  b=Q//xnx6CPNFDKf3befvtC6ep6vYj87P6Ce1RnCn8eyVNPixl3gbaFGpe
   lOTnLPw6USpEg16KK/PNaj0m+Tli3Yov+xHG4QxtArskm/XOz4wSFnkjh
   MB3YzdtJf/KcIE6LdyPYmVk8De6kVO4XNuaXiotc8HLMlbMLnSuM2kKb6
   LOMzcSGpREWp91aPhCbPBEXosdUShNSGSJ0QHRCOmBiBz1f52Z9SDORtM
   Wle25zEh9Rcr54h4ftFv6D4btIXaobHx0kZjYMwFSiJWOXIOnUdiB3JkD
   yll96v8B/YjWy/vTKp9itqjQrxXa9rSx2jHUArx8UzUgtxwUoIOHhQNFb
   g==;
X-CSE-ConnectionGUID: 1YQjN7U+QX6NP9FoQ7oA8w==
X-CSE-MsgGUID: QF8pmrj5TGafsfIHNinZfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2058290"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2058290"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 06:43:46 -0700
X-CSE-ConnectionGUID: W4dphpgISpy646ilS2SgmA==
X-CSE-MsgGUID: azdHLBbSTVu7n+GAonnHtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5489030"
Received: from gklab-096-123.igk.intel.com ([10.91.96.123])
  by fmviesa008.fm.intel.com with ESMTP; 29 Oct 2026 06:43:44 -0700
From: Michal Camacho Romero <michal.camacho.romero@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Ning Sun <ning.sun@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Michal Camacho Romero <michal.camacho.romero@intel.com>,
	x86@kernel.org,
	iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
Subject: [PATCH v7 2/2] iommu/vt-d: Disable TXT TPRs before enabling queued invalidation
Date: Thu, 29 Oct 2026 14:41:49 +0100
Message-ID: <20261029134149.3498677-1-michal.camacho.romero@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3a78df93-845a-4432-8aa1-fc4939f4f400@linux.intel.com>
References: <3a78df93-845a-4432-8aa1-fc4939f4f400@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>

When the SINIT ACM establishes TXT Protection Regions (TPRs), they block
all inbound DMA to their protected range, including the IOMMU's own
queued invalidation (QI) ring. If the TPRs are still active when QI is
first enabled, the first invalidation faults with an Invalidation Queue
Error and the boot hangs. On systems with interrupt remapping enabled
this happens very early, in intel_setup_irq_remapping() ->
dmar_enable_qi(), well before init_dmars().

Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.pdf

Tested-by: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
---
Changes since v6:
- Retitled from "iommu/vt-d: Disable PMRs and skip force-IOMMU when TXT
  TPRs are active", reflecting a substantially reworked approach:
  * TPRs are now torn down early in parse_dmar_table(), before any
    dmar_enable_qi() (the real fix for the IQE boot hang on IR/x2apic
    systems), instead of in intel_iommu_init() after translation is
    enabled.
  * tboot_force_iommu() is no longer modified. The IOMMU is forced on
    exactly as before, so booting intel_iommu=off on a TPR-capable
    platform behaves as upstream.
  * All TPR/DTPR/txt_heap states are kept internal to tboot.c. The IOMMU
    driver now uses only parameterless helpers (tboot_check_tprs(),
    tboot_teardown_tprs(), tboot_is_tpr_protection_enabled(),
    tboot_free_txt_heap_mem()). All TBOOT state leaks into the driver
    have been eliminated.
  * TPR teardown runs only on a successful DMAR table parse.
  * Using intel_iommu=tboot_noforce now suppresses the TPR-related panic.

 drivers/iommu/intel/dmar.c  | 19 +++++++++++++++++++
 drivers/iommu/intel/iommu.c | 18 ++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index ba675b08cd208..5e59aa46721e6 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -675,6 +675,25 @@ parse_dmar_table(void)
 	if (ret == 0 && drhd_count == 0)
 		pr_warn(FW_BUG "No DRHD structure found in DMAR table\n");
 
+	/*
+	 * Only on a successful DMAR parse: if SINIT programmed TXT TPRs for DMA
+	 * protection, disable them here, before any queued invalidation (QI) is
+	 * enabled. TPRs block all inbound DMA to their protected range, including
+	 * the IOMMU's own QI ring, so leaving them active makes the first queued
+	 * invalidation fault (Invalidation Queue Error) and hangs the boot on any
+	 * system with interrupt remapping enabled.
+	 *
+	 * If parsing failed, dmar_table_init() propagates the error and both the
+	 * IOMMU and IRQ remmaping preparation will be aborted, before QI will
+	 * be enabled, so the TPRs are left in place and SINIT's DMA protection
+	 * will be retained.
+	 */
+	if (ret == 0 && tboot_enabled()) {
+		tboot_check_tprs();
+		if (tboot_teardown_tprs() != 0)
+			pr_warn("tboot: Failed to disable TPRs. DMA is still blocked.\n");
+	}
+
 	return ret;
 }
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8f..8cb9096b8d732 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2648,6 +2648,15 @@ int __init intel_iommu_init(void)
 
 	init_no_remapping_devices();
 
+	/*
+	 * SINIT TPRs (if any were active) should be already torn down during DMAR
+	 * Table parsing process. If the teardown failed, DMA (including the IOMMU's
+	 * own QI ring) is still blocked, so refuse to continue a forced launch
+	 * rather than hang mid-init.
+	 */
+	if (tboot_is_tpr_protection_enabled() && !intel_iommu_tboot_noforce)
+		panic("tboot: Failed to disable TPRs. DMA is still blocked.\n");
+
 	ret = init_dmars();
 	if (ret) {
 		if (dmar_policy_force_on())
@@ -2698,6 +2707,14 @@ int __init intel_iommu_init(void)
 
 		iommu_disable_protect_mem_regions(iommu);
 	}
+
+	/*
+	 * Release the TXT heap mapping if it is still held. TPRs (and the
+	 * heap) are normally torn down in parse_dmar_table(); this is a
+	 * safety net for paths where no TPRs were active.
+	 */
+	tboot_free_txt_heap_mem();
+
 	up_read(&dmar_global_lock);
 
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
@@ -2707,6 +2724,7 @@ int __init intel_iommu_init(void)
 	return 0;
 
 out_free_dmar:
+	tboot_free_txt_heap_mem();
 	intel_iommu_free_dmars();
 	up_write(&dmar_global_lock);
 	return ret;
-- 
2.43.0

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

