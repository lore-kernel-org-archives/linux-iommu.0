Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275165;
	b=4mp40tkLfrE3F+XrkJhkpERChD8D/Q3Fs3tCt11Sbk5DBZvN/lRCkkPD/q5cuTfY0b95
	 n86sawzIO9FDqR9jTHbNG9iFjurHoSnj44NxqZSMe/TmBwh31OJk3e85x8fpyNa7SOpnV
	 7T0G0baZf61YBJw2oeM+gRKb8prWsgFrI6rpGA8z2Cbc0nzhABPwLxLMrvDITc71UCF7z
	 Y7QATvvTOH9V2TNylIXnPjrISO7tM+8ZdKpDBCb4ftcWI68GwrfetTc9qBRkRx6TTYZur
	 dvBQk7WnuDg7+JfWYQie6HxfGOTMIRCEhzei5mpNaVVYkMueh1iGrlaUVBqGlIy2hMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275165;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kH1Xo/SnGjpQuH8XqpM89LlNx1dcWwl3irWSPbUu4NA=;
	b=XIdvUJz1pYYgHB12GVvBTl+hpzvZpxYQ1oSt0olCLi3/xxUUlRyhpUOWxPM3MPHjWqk/
	 pT6fXuVRihFtT4dz9wy/fPj8Bwy9gMfOHmBftEw2OLSaSsNZ1x76J1nP8lUr+rKfPCDQy
	 s9VBkAbLV/FcEBhqGPkHsHE7jytyfs539Hm3CP3h2XavjbEeSrvJk519EJVORhtyq2gM2
	 53gUd3UQmztgN5mNZ1joqTb1rNXmhwFfPF8awqFRZdpDY5TVcNpKhVOs2vALYEPx1Orm0
	 FGiEIQD+PyyJzZrYP5jqknKhdOuNfzC9mgdgBBDz7PAnNMSP9T88iBSCjFOVBjqUR4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jvZBANT6;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1A606A31A
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 11:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CC1A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jvZBANT6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793275164; x=1824811164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZKUiOkswja6CWcjrOUGsG1g1zWrRguXO4q/84j3b2j8=;
  b=jvZBANT6eacdz+x4eJjj73dtM0nKcYbYE7WJnPnlS6UhfsNAOUZJeCIh
   zHf6Cxh0CJMK5tZ8lqaVVODxsz04zXtItoku/JOuUrxXPSnemMJEFQXHj
   V6egEZfPhjVrj572fMLrSSbeKSAvobWqRHhWcfMSZYv6SdhWZhbi0YJkJ
   urASpTRdbnNGZO+DI3oMd+vJ6pWoON7MT19htCyEN0baUfMYhyuECcSlw
   R5GVEhcRHYuWmeniARjonZCuzq32qtQo8gL6QYf803vcOdNRaETM+Uylz
   IOS+Nlb/8NaFqOy+6xjcKzcs+sPNwT9OYj1O+/ubkJEEfrY34m8ECs4x4
   A==;
X-CSE-ConnectionGUID: /p43dDrqS7WpNL2VHZ1j8w==
X-CSE-MsgGUID: pkYN7Ye/Q7WQMkppJ2vTbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1892710"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1892710"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 04:59:23 -0700
X-CSE-ConnectionGUID: mKxjnXd+RVmdccZt9eNNzw==
X-CSE-MsgGUID: 6yTqOMJOR0uqdSzzf3TJNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5260185"
Received: from gklab-096-123.igk.intel.com ([10.91.96.123])
  by fmviesa005.fm.intel.com with ESMTP; 29 Oct 2026 04:59:21 -0700
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
Subject: [PATCH v7 0/2] x86/tboot: Add Intel TXT Protection Regions (TPR) support
Date: Thu, 29 Oct 2026 12:57:25 +0100
Message-ID: <cover.1793273244.git.michal.camacho.romero@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

This series adds support for parsing the Intel TXT DMA Protection Ranges
(DTPR) table and tearing down the SINIT ACM-established TXT Protection
Regions (TPRs) during early kernel boot.

Background
==========
When a measured launch is performed, the SINIT ACM programs TXT
Protection Regions (TPRs) that block all inbound DMA requests.
These ranges also cover the Intel IOMMU's own queued
invalidation (QI) ring. If the TPRs are still active when QI is first
enabled, the very first invalidation faults with an Invalidation Queue
Error (IQE) and the boot hangs. The kernel must earlier locate and disable
the TPRs, before any QI is enabled, after which the IOMMU is the sole runtime
DMA protection.

Patch 1 adds the tboot-internal DTPR parsing and TPR teardown helpers.
Patch 2 wires them into the Intel VT-d driver, disabling TPRs in
parse_dmar_table() (which runs before every dmar_enable_qi() call site)
once DMAR parsing has succeeded.

Changes since v6
================
- Patch 2 retitled "iommu/vt-d: Disable PMRs and skip force-IOMMU when
  TXT TPRs are active" -> "iommu/vt-d: Disable TXT TPRs before enabling
  queued invalidation", reflecting a substantially reworked approach:
  * TPRs are now torn down early in parse_dmar_table(), before any
    dmar_enable_qi() (the real fix for the IQE boot hang on IR/x2apic
    systems), instead of in intel_iommu_init() after translation is
    enabled.
  * The tboot_force_iommu() is no longer modified. The IOMMU is forced on
    exactly as before, so booting intel_iommu=off on a TPR-capable
    platform behaves as upstream.
  * All TPR/DTPR/txt_heap states are kept internal to tboot.c. The IOMMU
    driver now uses only parameterless helpers (tboot_check_tprs(),
    tboot_teardown_tprs(), tboot_is_tpr_protection_enabled(),
    tboot_free_txt_heap_mem()). All TBOOT state leaks into the driver have been
    eliminated.
  * TPRs teardown runs only on a successful DMAR Table parse.
  * Using intel_iommu=tboot_noforce now suppresses the TPR-related panic
- Patch 1 is functionally unchanged; it only picks up checkpatch --strict
  cleanups: statics are no longer explicitly initialised, the TPR count is
  now signed (s64), and tab indentation, pointer/cast style,
  NULL-comparison and brace style, and unsplit log strings were fixed.

Michal Camacho Romero (2):
  x86/tboot: Add support for parsing DTPR table and disabling TPRs
  iommu/vt-d: Disable TXT TPRs before enabling queued invalidation

 arch/x86/kernel/tboot.c     | 515 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel/dmar.c  |  19 ++
 drivers/iommu/intel/iommu.c |  18 ++
 include/linux/tboot.h       |  28 +-
 4 files changed, 560 insertions(+), 20 deletions(-)

-- 
2.43.0

