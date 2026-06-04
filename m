Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47213C062D
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 05:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780549588; cv=none; b=gR50SaK89My3Pic0oHqx5FRsZMKx9Z/ZEDP7KGV78Nk0VYLB7fCUsl7cLktrWoQH8ox7rZH43n7kM6GdSRPhwMZip9dX66bJHbmlgVsVFUltBRGPQquYAcdhGO3Q/omTtYaLG2/d378vAN6pRlLZVicVgCBcroY+qH38fMBkf6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780549588; c=relaxed/simple;
	bh=C9MWJDIe6ZS9hUiK4TUZ7uaQn1rHg6ccXBQ88lEZGy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyzIfUpqosIEeu/Gw0CWhf2F5loHJT5HIXb2fY/REkyjlDLCNqSZR8Lc+PsyAuAFQ7Ws23T1cj4zVmCLK1D5IIuupnX+G/F4t9ofCDQW3eicxsD++EA7bEzOmS1x4laeNqyKxrVxySmPNiPlcnRzE8bWEPa61UcN5n+dPkyajcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HQwthoC7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HQwthoC7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780549587; x=1812085587;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C9MWJDIe6ZS9hUiK4TUZ7uaQn1rHg6ccXBQ88lEZGy4=;
  b=HQwthoC73o/AA6Ygl0apBy8p1vRTC0vgHBS1Ktw3yKt6FmWOvHXi4MMF
   kikdU5PiXxs1u1JaoBRU3fNHOpEQsMqxzd0vWMSTUjH5n9Zyaw1OmblvT
   un/6vQr4t5bshVyhZ+8OBtKGeaU8Liw1Vc4ObC7S/QQf6IYSTKEPCE2O9
   tvq9JfcOE8E3Hg0AqhhUUOkeeKVsCSPKiK0Lk/irdY1TkMyI9gMKAjXyX
   pvAfM32MXlfTo78rWQylL0P2yqTXSc+YIjsq4j4VcrYHLcZOu9cA9O4TU
   pMLNn+UrqxKMC3qATPBoXTgrCmzDTZL+OWkYkhx7NgKWh6/adWCxYFDfL
   w==;
X-CSE-ConnectionGUID: m5mrdW0SQ7qXmmP3Hii/fQ==
X-CSE-MsgGUID: Xs15zJb7SrCvZzqywu88pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91943503"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91943503"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 22:06:26 -0700
X-CSE-ConnectionGUID: F3iLzGhnT9eNavWV43125w==
X-CSE-MsgGUID: 7Evjv6SaQOO7TG4+i9flmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="246266491"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by fmviesa004.fm.intel.com with ESMTP; 03 Jun 2026 22:06:23 -0700
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
Subject: [PATCH 5/9] iommu/vt-d: Use dmar_can_force_on() for platform optin
Date: Thu,  4 Jun 2026 05:15:36 +0000
Message-ID: <20260604051540.592925-6-kevin.tian@intel.com>
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
with that in platform_optin_force_iommu().

While at it, remove no_platform_optin which is unnecessary now.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0fc131a34963..edf01261a41d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -58,7 +58,6 @@ static int rwbf_quirk;
  */
 static int force_on = 0;
 int intel_iommu_tboot_noforce;
-static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
 
@@ -248,7 +247,6 @@ static int __init intel_iommu_setup(char *str)
 		} else if (!strncmp(str, "off", 3)) {
 			dmar_state = DMAR_DISABLED_USER;
 			dmar_disabled = 1;
-			no_platform_optin = 1;
 			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
 			disable_igfx_iommu = 1;
@@ -2486,20 +2484,22 @@ static bool has_external_pci(void)
 
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
+	if (dmar_is_disabled()) {
+		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
 		iommu_set_default_passthrough(false);
+	}
 
+	dmar_state = DMAR_ENABLED_FORCE;
 	dmar_disabled = 0;
 
 	return 1;
-- 
2.43.0

