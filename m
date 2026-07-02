Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDF12E2286
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972086; cv=none; b=TW369486aL0y8DJuGTnpvr0o0xG0rj30g5/4aSOc0a+iskPgZCAsl6AubN6vL+tj9MZIIyNYKO0QfKhzt6AxVj/sgonYUrJXZWvJWQhRN8ZELkYTj3TE59l0RZM8+HnGJtddJNuWrjYINBBbB6Gt4/BPH1o5/zisoE7lSKAcLQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972086; c=relaxed/simple;
	bh=B/asl3BYWzIU0Y1W398Lm8ckSLzL2fuDqTaH7fEx4oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuzSOFfB6kkIojXRY6pib4bxAKWTsqqRl2rvHVesHbXD7lQ+2pxdWAvhbz2rTeWDdBTGvmobkNS+AD11325VCsaKOPuozBLcdS5KgSZf9y6YYvdjtSDq4xni2K5oLd/CgzN6FGdYLy/QTfzDElMIn9Aa9TFiPWoJtavmeMeis/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPKkOaWp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPKkOaWp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972084; x=1814508084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B/asl3BYWzIU0Y1W398Lm8ckSLzL2fuDqTaH7fEx4oQ=;
  b=PPKkOaWp1j72oKLxEUIWaXjPLIasGvVRffrYPURjPN+woVXAbFPaPlik
   2anqiOJsmtUD/jUCopXeyKgUPSd2IzhJEtgKYFKFnbdXL97ZCBAs0THCk
   QNcDM4JxDKbPz6+v0sGhu5x/sufGpVldYKGqmoqw0GCxveLdXEdtqGs1E
   UKB9TbTfOsvChKfcH5zQUlTY+7RzRge2A17/IYkD1yrPn4NocOq5RIXQg
   3i+b/wafq7m+Ytk6L2iEd+hc6qtOvWtIbUoWTtkgfxhc4r3WgumNZvk9T
   RcwChssjlWSnhLfOjbM4RJlmXXTsalz5QC6oEoKPAwvRTREbWiXeUU1YD
   A==;
X-CSE-ConnectionGUID: FtnD5FjPT6C2dE4ZqGA0qA==
X-CSE-MsgGUID: HCp37vvPSh2Jab0Dy5+7vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256484"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256484"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:24 -0700
X-CSE-ConnectionGUID: Sfoc1Uu0SGCxhriOO4jwOA==
X-CSE-MsgGUID: oR5c1UnFRjKydljhrE/QZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425857"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:21 -0700
From: Kevin Tian <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Kevin Tian <kevin.tian@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Chris Wright <chrisw@sous-sol.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Asit Mallick <asit.k.mallick@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] iommu/vt-d: Use dmar_can_force_on() for platform optin
Date: Thu,  2 Jul 2026 06:12:12 +0000
Message-ID: <20260702061216.388743-6-kevin.tian@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702061216.388743-1-kevin.tian@intel.com>
References: <20260702061216.388743-1-kevin.tian@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So the policy of requesting ACS in detect_intel_iommu() is consistent
with that in platform_optin_force_iommu().

While at it, remove no_platform_optin which is unnecessary now.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index c66909b8e33b..94cf144b4b70 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -58,7 +58,6 @@ static int rwbf_quirk;
  */
 static int force_on = 0;
 int intel_iommu_tboot_noforce;
-static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
 
@@ -251,7 +250,6 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "off", 3)) {
 			dmar_policy = DMAR_USER_OFF;
 			dmar_disabled = 1;
-			no_platform_optin = 1;
 			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
 			disable_igfx_iommu = 1;
@@ -2489,20 +2487,23 @@ static bool has_external_pci(void)
 
 static int __init platform_optin_force_iommu(void)
 {
-	if (no_iommu || !dmar_platform_optin() || no_platform_optin ||
-	    !has_external_pci())
+	if (!dmar_platform_optin() || !dmar_can_force_on(DMAR_FORCEON_PLATFORM))
 		return 0;
 
-	if (dmar_disabled)
-		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
+	if (!has_external_pci())
+		return 0;
 
 	/*
 	 * If Intel-IOMMU is disabled by default, we will apply identity
 	 * map for all devices except those marked as being untrusted.
 	 */
-	if (dmar_disabled)
+	if (dmar_policy_off()) {
+		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
 		iommu_set_default_passthrough(false);
+	}
 
+	/* No concurrent access to dmar_policy at this point. */
+	dmar_policy = DMAR_FORCE_ON;
 	dmar_disabled = 0;
 
 	return 1;
-- 
2.43.0

