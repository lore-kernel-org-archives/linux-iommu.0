Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DCD41CB20
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811726; cv=none; b=K362DBJoVXBHiOyT37EeuSSU2wyzu0KmQ+U9A/78tRGANyAEJb57L60ihf8vgAdm0sOgsXIlV9RWCEDcw4lyYpj5e+MKqLrJglPVGPb5QwkfgmnJXyRYeY7FzxcsYsYPacexvs1c5vi0VMOewB8DZprIYIdSfo1Fp8fRJVcFUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811726; c=relaxed/simple;
	bh=A+gsmRHhQ65EGjIdwCREM1GXzXS4uN/8v+W2J6N27oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jmy8WY39eUwOjYIq3XZRm6Z5rDrU4qUCsPUKFkMeGwrQzuFueoaJvtB712k4kZSp4gp8lKZJAbVPyX5u/mDORFtXKc5c4JRvud3c4ZFxOThWhlhLis+MoQf6oPGIjdUmyMLj1dNYwvFBoqmJmbX5AZRHP219nB2u4H3QInavH8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTYLexxS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTYLexxS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811726; x=1817347726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A+gsmRHhQ65EGjIdwCREM1GXzXS4uN/8v+W2J6N27oU=;
  b=LTYLexxSDunjvuB1mmkQrZY/uEQ32KchGsABjpYM5wDJxviN7VGiS5QD
   AnnSydFG18CCFJdYES0ODQK2070Gy16bJGhUMEwuX6XO02B7+6jGCIcXE
   GOLBimqLYyWeEAaUUa6hmyjpFuY1/5bhmuOBB+zI/GxY+ntDHtbsA85Pg
   dIbpFgHiDxc2fOLMbNCHUpRMyp0iejfE8MFZ/HIRUX63mkK7dBWcIeFJS
   4jsGkVWVFwmwNFYjO/Z2PBXaWCawmrbMSN5zIhmExndT/sPis7AHB0Cwl
   8VWYQWEJqOKG7YOsPDC2f0lhaxzS6RBGJ8fReSRV59S1qEvLLoxrJgG1E
   A==;
X-CSE-ConnectionGUID: i8lSF7TbQXCTBxPOvV9JVQ==
X-CSE-MsgGUID: f7LuxLWBTTKiNtZC06QHUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231290"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231290"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:43 -0700
X-CSE-ConnectionGUID: 2Zmy5qyiRReDhKieKlfDgw==
X-CSE-MsgGUID: DJUAhbueRUyGR87sJNYdiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587515"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] iommu/vt-d: Use dmar_can_force_on() for platform opt-in
Date: Tue,  4 Aug 2026 10:37:03 +0800
Message-ID: <20260804023714.3080506-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Tian <kevin.tian@intel.com>

So the policy of requesting ACS in detect_intel_iommu() is consistent
with that in platform_optin_force_iommu().

While at it, remove no_platform_optin which is unnecessary now.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2f0cd1714923..ce0794e82e55 100644
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
@@ -2491,20 +2489,23 @@ static bool has_external_pci(void)
 
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

