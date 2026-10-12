Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0544F54A
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800555; cv=none; b=cTlECOlh+M7X2tVtlCLYxjHMpg3wo1bfyGKjb2tXfAkcBugjZ+rjGMGtsc2mgvHZQa8W8BkK/m8kC+H6mbpvpl/cbaWmrzCKpulWpK8QjPrYTwPj+1KjX5ml99Tr6hBNqumZVs1kDmFuzvUttVeuxpX/BhampSckp19QLP+0p38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800555; c=relaxed/simple;
	bh=M1Sj3kzNC+GMMWQ2nazgRKa95NoWiNxGs2o+qP8xuTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWBEs+V7AQBtNUF9WKtzwHHvNIefhUy0PW92wpWXGD3C1Gfb/1QfgHAefg6ErOdh80zG2NtWbvkH7r6lBWPdWXzw3Vas2Lnu4jHsuWmWIsEvwC9eR1Efb893ReWJ0dzD9JUrR78MkqEEB8rR82nLujV16GGzGR0S2sYmZslW7dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIHJO2z/; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIHJO2z/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791800541; x=1823336541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M1Sj3kzNC+GMMWQ2nazgRKa95NoWiNxGs2o+qP8xuTo=;
  b=PIHJO2z/N9ZDTD+3/OWjK4+G3BNotwP7JMQDNihi0b3KSbww+f7odu4E
   t2kePag7ZZVJHjCw1iy+Wz1FVm52FUCiDgqdGz0IHeTha/f/wXYJN6SxR
   BVHYSTNElg01zRxMbk4wDZoz5vXf8xJy5YlaG7/xOpqFcHnhX1h2+n0rt
   UtH+wTu+IoRGskPUpq6MSjN31me4nF6bbRGOXri2gutnm2Tk4sWWqhGgE
   Wo3U9ZxEOWwZrcVoaJPOjSgQWpCJT6J1skvIc7+p5sfJDhkPZv0QTjSPh
   XkRi/52ZcI+cWSXOQFPQC+Uh7a79zdBRwRy7cJknxOm5HC44frdKHxZnz
   g==;
X-CSE-ConnectionGUID: 6S0308ECRaWk/krmlZF7mQ==
X-CSE-MsgGUID: n5L40CjVTuWnFKuwCtWqPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="498595"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="498595"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 03:22:20 -0700
X-CSE-ConnectionGUID: a5g6dXxORMeX0LymIqJyHw==
X-CSE-MsgGUID: sMDpN8WpTFeLs8ylClHjTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="1048223"
Received: from gklab-103a-104.igk.intel.com ([10.91.103.104])
  by fmviesa001.fm.intel.com with ESMTP; 12 Oct 2026 03:22:18 -0700
From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Ning Sun <ning.sun@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@intel.com>,
	x86@kernel.org,
	iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
Subject: [PATCH v5 2/2] iommu/vt-d: Disable PMRs and skip force-IOMMU when TXT TPRs are active
Date: Mon, 12 Oct 2026 12:22:11 +0200
Message-ID: <20261012102211.1739615-1-michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <7f637b22-110b-4e49-b083-6062bcad37c4@linux.intel.com>
References: <7f637b22-110b-4e49-b083-6062bcad37c4@linux.intel.com>
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

- Parse DTPR Table and count number of enabled TPRs,
  by using tboot_check_tprs() function.
- Skip forcing IOMMU enablement in tboot_force_iommu(), since TPRs
  already provide DMA protection.
- Tear down PMRs during intel_iommu_init() when TPRs are active,
  while PMRs are redundant with TPR-based protection.
- While TPR protection is enabled, call tboot_disable_tprs()
  from intel_iommu_init() to disable TPR protection, after the IOMMU
  adresses translation mechanism is set up.
- Deallocate TXT heap memory using tboot_free_txt_heap_mem() when it is
  no longer needed.

Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA_Protection_Ranges_rev_0p73.pdf
Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.pdf

Signed-off-by: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
---
Hi Baolu,

Thanks for the careful review, and for catching the timing problem. You
are right. In the v4 patch version the disabling of TPRs was done too early.
I've introduced both in the IOMMU and TBOOT code sections a new
improvements, which eliminate the timing problem. Summary of how
each point is handled:

Answer for Question No.1 (DMA protection gap between disabling TPRs and
                          IOMMU taking over):
   The actual tboot_disable_tprs() call was moved to the very end
   of intel_iommu_init(), after the loop that enables the DMA
   remapping hardware (iommu_enable_translation() function call). Until IOMMU
   address translation mechanism is set up, the TPRs remain enabled.

Answer for Question No.2 (the commit message sentence "disable TPR
                          regions early, allowing the kernel to manage
                          DMA protection prior to the OS boot"):
   That sentence was wrong and I apologise for the confusion - it
   described exactly the broken behaviour you pointed out. Two things
   were incorrect in it:

     - "disable TPR regions early" - as you noticed, by disabling the only
       active DMA protection before the IOMMU is set up is precisely what created the
       unprotected window. "Early" was the wrong thing to do, not a
       feature.

     - "allowing the kernel to manage DMA protection prior to the OS
       boot" - this message was also unnecessary and misleading.

   What I actually meant to describe is a hand-off: the TPRs provide the
   pre-IOMMU DMA protection, and the kernel must tear them down only once
   IOMMU-based DMA protection is active. The commit message has
   been corrected to reflect the real flow:

Answer for Question No.3 (how can tboot_is_tpr_enabled() return true
                          when TPRs were already disabled):
   In the Patch v4 this was indeed contradictory because the disabling happened
   earlier. With the reworked flow it is consistent:

     - The helper was renamed to tboot_is_tpr_protection_enabled() and
       now takes num_of_enabled_tprs, the value recieved from the
       tboot_check_tprs() at the start of intel_iommu_init(), before any
       TPR is touched. Basing on the number of enabled TPRs, the helper can
       determine whether the TPR protection is currently active.

     - Because the actual tboot_disable_tprs() call is now the last step,
       the TPRs are still active. They are disabled after activating the
       IOMMU-based DMA protection.

I have also dropped the stale "Reviewed-by: Lu Baolu" tag as requested,
since the changes are substantial enough that the earlier review no
longer covers them.

Regards,
Michal Camacho Romero

 drivers/iommu/intel/iommu.c | 42 ++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2e3b3ab216f8..ea32730701cf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2558,11 +2558,18 @@ static int __init probe_acpi_namespace_devices(void)
 	return 0;
 }
 
-static __init void tboot_force_iommu(void)
+static __init void tboot_force_iommu(s64 num_of_enabled_tprs)
 {
 	if (!tboot_enabled() || intel_iommu_tboot_noforce)
 		return;
 
+	/*
+	 * If TPR is enabled we don't need to force IOMMU, TPR set by SINIT
+	 * ACM will take care of DMA protection.
+	 */
+	if (tboot_is_tpr_protection_enabled(num_of_enabled_tprs))
+		return;
+
 	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
 		panic("tboot: Failed to force IOMMU on\n");
 
@@ -2584,7 +2591,15 @@ int __init intel_iommu_init(void)
 	 * Intel IOMMU is required for a TXT/tboot launch or platform
 	 * opt in, so enforce that.
 	 */
-	tboot_force_iommu();
+	void __iomem           *txt_heap = NULL;
+	struct acpi_table_dtpr *dtpr     = tboot_get_dtpr_table(&txt_heap);
+	s64 num_of_enabled_tprs = 0;
+	if (dtpr) {
+		/* For the existing DTPR Table, verify TPRs activity status */
+		num_of_enabled_tprs = tboot_check_tprs(dtpr, &txt_heap);
+	}
+	
+	tboot_force_iommu(num_of_enabled_tprs);
 	if (!dmar_policy_force_on())
 		platform_optin_force_iommu();
 
@@ -2623,7 +2638,8 @@ int __init intel_iommu_init(void)
 		 * calling SENTER, but the kernel is expected to reset/tear
 		 * down the PMRs.
 		 */
-		if (intel_iommu_tboot_noforce) {
+		if (intel_iommu_tboot_noforce ||
+			tboot_is_tpr_protection_enabled(num_of_enabled_tprs)) {
 			for_each_iommu(iommu, drhd)
 				iommu_disable_protect_mem_regions(iommu);
 		}
@@ -2697,7 +2713,24 @@ int __init intel_iommu_init(void)
 			iommu_enable_translation(iommu);
 
 		iommu_disable_protect_mem_regions(iommu);
+
 	}
+
+	if (tboot_is_tpr_protection_enabled(num_of_enabled_tprs) && dtpr) {
+		/*
+		 * TPRs are enabled. It is necessary to disable active TPRs
+		 * to enable DMA usage by the system.
+		 */
+		num_of_enabled_tprs = tboot_disable_tprs(dtpr, &txt_heap,
+		                                         num_of_enabled_tprs);
+		if (num_of_enabled_tprs != 0)
+			panic("tboot: Failed to disable TPRs. DMA is still blocked.\n");
+	}
+
+	/* Release the TXT heap memory if it was allocated */
+	if (txt_heap)
+		tboot_free_txt_heap_mem(&txt_heap);
+
 	up_read(&dmar_global_lock);
 
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
@@ -2707,6 +2740,9 @@ int __init intel_iommu_init(void)
 	return 0;
 
 out_free_dmar:
+	if (txt_heap)
+		tboot_free_txt_heap_mem(&txt_heap);
+
 	intel_iommu_free_dmars();
 	up_write(&dmar_global_lock);
 	return ret;
-- 
2.55.0

