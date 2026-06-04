Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B93C09F2
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549591; cv=none; b=EUOTJj3cMLZB06n+cO2VwluRwfaw/Jf1A8sSjCe88YoXUXVoM6jXIuzyTyuY4THuZBG5kVvm/Ny9PqVMJBwY5j6Chwg+h2ltQ9+MFt/vRKGmXPXgjdP+czdsmsucWlHBsWBOFQOjiwJ7Owgh+NLw/kTJtpJN5MOfQHl91xTKsJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549591; c=relaxed/simple;
	bh=jY5aeVIY4aAPUpGNGzok2g1Aiip9o4fqglGRkjQpHuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XduzaBchQKvgnMAkr1R6wIqLk2PIKucbRSV5vEKOPU/C74bPWi/CccLrqgG4ks18RdURISAIhbEekB35tELsSl970mGu7g/pgD69CiDARuylHABTKsJNrQo+t40tdlFDW+ECV78PRaKleKFxahbOT8WzJyDF/T5AiaEF3J7NsDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOWVC8LN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOWVC8LN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780549589; x=1812085589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jY5aeVIY4aAPUpGNGzok2g1Aiip9o4fqglGRkjQpHuY=;
  b=XOWVC8LNIxSmM54R9SKdq4rgY0R91j1fCNjrMu8c3gjM5XBya0caZVR+
   5cYNohURSqMzjv+pGPnRmU1i3yu6Uy97IBnhz1cGIRR8dULEVPvZ6BVd0
   3Fmx17aRRvCB5na06TEU2Ndkyd8AaP3QIlphAhi+ffBb+O34WbgbGbsmh
   bfNelupt8qdLaSwnWX2imDnm8q0UvWAoC0Imm2ofjui5LSeX/rGyYY/Me
   GQP/paCciBkefsw/2vx8vq0bCqvPeKTNkkC3zX7sia8vZBoe8xXd+jOpC
   yGABUY/4hJ30bbJ7cMsL++WhGY699QsFYtiNb1XHqh/AMzTlZROYbmD+/
   g==;
X-CSE-ConnectionGUID: 9mHmLZUdQ/CQzZyc9X1Cmw==
X-CSE-MsgGUID: A58CDlcET9e3Vahdv0WdNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91943515"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91943515"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:06:29 -0700
X-CSE-ConnectionGUID: GxBThEBNSD2I+tRBcAP6+w==
X-CSE-MsgGUID: A0WskyejQCC3vV81P7tLMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246266534"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 22:06:26 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] iommu/vt-d: Call dmar_can_force_on() for tboot optin
Date: Thu,  4 Jun 2026 05:15:37 +0000
Message-ID: <20260604051540.592925-7-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604051540.592925-1-kevin.tian@intel.com>
References: <20260604051540.592925-1-kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So the policy of requesting ACS in detect_intel_iommu() is consistent
with that in tboot_force_iommu().

Though tboot is the strongest override so far, add a panic() in case
dmar_can_force_on() may return false due to future extensions.

No functional impact at this point.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index edf01261a41d..ed227de6d0ba 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2544,12 +2544,16 @@ static int __init probe_acpi_namespace_devices(void)
 
 static __init int tboot_force_iommu(void)
 {
-	if (!tboot_enabled())
+	if (!tboot_enabled() || intel_iommu_tboot_noforce)
 		return 0;
 
-	if (no_iommu || dmar_disabled)
+	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
+		panic("tboot: Failed to force IOMMU on\n");
+
+	if (dmar_is_disabled())
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
+	dmar_state = DMAR_ENABLED_FORCE;
 	dmar_disabled = 0;
 	no_iommu = 0;
 
@@ -2566,8 +2570,7 @@ int __init intel_iommu_init(void)
 	 * Intel IOMMU is required for a TXT/tboot launch or platform
 	 * opt in, so enforce that.
 	 */
-	force_on = (!intel_iommu_tboot_noforce && tboot_force_iommu()) ||
-		    platform_optin_force_iommu();
+	force_on = tboot_force_iommu() || platform_optin_force_iommu();
 
 	down_write(&dmar_global_lock);
 	if (dmar_table_init()) {
-- 
2.43.0

