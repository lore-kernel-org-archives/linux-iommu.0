Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359329;
	b=BfzE7cj/2W/9lV6bh1LzjkL9N4tRmMbHdTzk6QnEiNQbpaPmn8cSi27ncHz5QE65HH3q
	 dYkA+tZHYW2p+5VJc66l6szhSqSf8A0Ah8XfaBCATLe9vdB1Kmn2VtcyRwy9ImU3rc5We
	 sTiRRhdSoGyvKWkgmk9w9Ew2I2tUIbt1HG6oOwFPlchEcFktKzDEPwI5mpKdFd2Ge4PCZ
	 fQBbhBB0p4YnQn8jHoYy4S5rsW5SYKkCDBW8Dan3soNYMjwKUfeBPVd/pzKwUt4W4+Is8
	 BCv7XfaRuUu3O/wXcq6xg6rfKbA3nwbyn6TwM5O+KCeZEYQURHrjtRwBoKt2kRHfDew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359329;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PMxo0tKZ2uNq7UfgPU1pBYHsL5dtAg8inp26p5xVDiU=;
	b=kHk7OtMMk1BA2QY37LAOjCuv462t/EBD5IvucnUpS2aCdq11Z0dO0adwk9WhAc96355H
	 IAD7EevJvH4VyYoD0lBpGqYGPsAp0GwDtPmGRXKXvY0v+mPX6G4Cjy3OoIFxRzsfVfFOo
	 QPMhJr3vctfivaToIhHHl7b/IfLLp2Z4jajeDLM7qiKCM8JLXef6YxWQjmQUJncq+hmha
	 Zx9kJSgNuqKjhRb0xY3Fc8Zm1r8J8VNR3DgArAIjqvoc0R6jrS+6d++SGhzpyc3EOURcM
	 3ufoKsEvGYWAqVp17I0FjonXvUNtDR/VALiy32NTJgnHLS4FX7aaTapIkMKeqrSuwBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R0daRYv2;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F938606A31F
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 11:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F938606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R0daRYv2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793359328; x=1824895328;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z3NhLfj1UqbvTSE1LMM7BgBTAVJZugHpz+h0zX3Mjy8=;
  b=R0daRYv2EtEYmU0NIL6dYvKBKLYHaguT4EucPrXLJasW0S7XvRDnDj4G
   ssI/g+DkFREPV9OC3kC0rAvFJ6GKFeu5poBEIucjGJW+JbLpJ1+Qa4h6u
   qkwx0g2KN6mZkVNOCrvQJsZCLDgRG/t62+TjRyOTYTEG4lFBkGA/KW+nS
   UnMQO0yMQpbTIjIcr+fMiG7VltNbJvYU+3kLznuX+pNqAvncwwQ2kspOb
   P1b7Rx517exbMxhtSJh0fIVsvUUwhBt3tcEtrR2N3NwlW0V/iywNaEPAT
   u/a6IXmSU5vAxiC9i4deHm8lbD6ioq9HZvQx7kzJKN8SW700WuH223khR
   g==;
X-CSE-ConnectionGUID: xeZOZpjaSqOBFjR4VaULrQ==
X-CSE-MsgGUID: EL+kNZOAR0CYQY0XBUmaBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2135256"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2135256"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 04:22:08 -0700
X-CSE-ConnectionGUID: h15cKfcnSFem9lFJqm1q/w==
X-CSE-MsgGUID: 1+IA4HZFR4SYpFsHB4gPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5375432"
Received: from gklab-096-123.igk.intel.com ([10.91.96.123])
  by orviesa001.jf.intel.com with ESMTP; 30 Oct 2026 04:22:05 -0700
From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Ning Sun <ning.sun@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Michal Camacho Romero <michal.camacho.romero@intel.com>,
	x86@kernel.org,
	iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
Subject: [PATCH v8 2/2] iommu/vt-d: Disable TXT TPRs before enabling queued invalidation
Date: Fri, 30 Oct 2026 12:20:09 +0100
Message-ID: <c7c6a9e88e0ce6ef0e4bf868b87e1f388b04bc9e.1793357321.git.michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261029134149.3498677-1-michal.camacho.romero@intel.com>
References: <20261029134149.3498677-1-michal.camacho.romero@intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Changes since v7:
- Renamed tboot_free_txt_heap_mem() to tboot_unmap_txt_heap() to match
  the rename in patch 1.

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
index 2e3b3ab216f8f..3ad6542f83e41 100644
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
+	tboot_unmap_txt_heap();
+
 	up_read(&dmar_global_lock);
 
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
@@ -2707,6 +2724,7 @@ int __init intel_iommu_init(void)
 	return 0;
 
 out_free_dmar:
+	tboot_unmap_txt_heap();
 	intel_iommu_free_dmars();
 	up_write(&dmar_global_lock);
 	return ret;
-- 
2.43.0

