Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275170;
	b=bwMqIHidvdVRcsawSscC8M2egxd8svC+vGOGO8Lb1jU9oIYtkdwAUWfB/mdpjJ+Bs066
	 2LTatjt4AgSLANUTxTHis6N3/56cgjUeO+1SaqJmdeZyp40oCnWSIPEz1BMjmWeHFsVzC
	 H7Fk5Ex6nSxzTE5mN9x3D0Up+f8GUHXwm+3FrgEtS57662LqSB4Q4SYV6sW9soKhGidJk
	 ZEO4hk8CTcuWm7xUjgrCAJMbxU03XfKfbNW0FZNL1hojwKgDDLROzp6eIt6VOBAT7kpA2
	 E7221+XBOGdI9m7jpTeqt9AkD45qyd+Ne6wzB3yjuCkMDkH1xPmkIMYKh2d1t5osyjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275170;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Kd+swtvYfZs0J8oFeVX+a8iSMPxbbJG8efLH2k8fSb8=;
	b=VLye/+8oSvTKUBJhhQpg0FvYJyNDNbRr1Sds6O4e56bGgDxsW7ZaxeX4CtRnisWMKhsM
	 PLgrVMP+GEAIRRTkKqBE3NpYgTgMUXvZPn009Vg6iUWODLUGWG5sRA4hzw0GCDlNBNGmB
	 YPkzVLmY6+lplYmuMv2YJ/PqbWLpKQPqlkB0L3LUY/DjaLHOGQhRDW2XHNwZfkm5PsUsF
	 cI8n9Xk9mpZrv/Uo0zk60hxq0cl8857J4u5QuaFKnMJMIGpftptgxRE6nqlp9+FBXZSxn
	 7NveiSIC10jOUN+V1r/yDjEYIB+ehswoIGjkHefeZ+FQdtqrvtRC6u739I7oJ9jnosg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Os/RE/89";
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84397606A327
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 11:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84397606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Os/RE/89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793275169; x=1824811169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Whob8W8/E6AHzK3NRC5hMEQe3c5hrq5OPCUcin04J/c=;
  b=Os/RE/89P4wdUYAjQVq+dbnDMTjj6lHPraYHgI9d+3cmDBUSHdXmk3b5
   dvZ6WCx3ccubvqjs3xSg4hNLdAJ12J8vbG/Lm+xEiQ6WXj2upRpnQM4wP
   szZcI6eMeBYhxjWmeZ364NXxlldFt8hKDTGiRwyO6XJWLNNktIEBNtH4W
   8CWiuU6CYku+9nouhPZr45iIPkHUq/EIpkE+IeB8kQVUDlRy46xPKJIBr
   NO6xnU1y+Y8UsfqfNjlAUuUgt9INa4+ziJy1cdTJ/mkXY3zuMtk4Ilija
   0oN9FNxth1yf4cG4jrIeNbjbOaUtmdbE1SmYD8Qlm400A78mev4I1Vtjy
   Q==;
X-CSE-ConnectionGUID: 2IX69ezPTPyDWAGI36anbQ==
X-CSE-MsgGUID: rR1QgowvQ1a1PjuQ4BFHUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1892736"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1892736"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:59:29 -0700
X-CSE-ConnectionGUID: 6Jg50fcWTlm6UmMAu/oSHA==
X-CSE-MsgGUID: KFm0A/mlRrm3jTbAA5FXLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5260201"
Received: from gklab-096-123.igk.intel.com ([10.91.96.123])
  by fmviesa005.fm.intel.com with ESMTP; 29 Oct 2026 04:59:26 -0700
From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ning Sun <ning.sun@intel.com>
Cc: Michal Camacho Romero <michal.camacho.romero@intel.com>,
	x86@kernel.org,
	iommu@lists.linux.dev,
	tboot-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mateusz Mowka <mateusz.mowka@intel.com>,
	Adam Pawlicki <adamx.pawlicki@intel.com>,
	Pawel Randzio <pawel.randzio@intel.com>,
	Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
Subject: [PATCH v7 2/2] iommu/vt-d: Disable TXT TPRs before enabling queued invalidation
Date: Thu, 29 Oct 2026 12:57:27 +0100
Message-ID: <fa4cf46c2f7613806c47f7c39bd05980b7b0024e.1793273244.git.michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793273244.git.michal.camacho.romero@linux.intel.com>
References: <cover.1793273244.git.michal.camacho.romero@linux.intel.com>
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

