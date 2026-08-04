Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794D144E66C
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887685; cv=none; b=WopfsDr2lWmVtlwZo6bu9sKVnsFhGqSRQHKF42AZobeoppKeeO7MfOugaECdoI87ds0bfiv5rXMCm5h0zouq/4ful5WkJxdUqcJinaw4O3vyE9Jt91EfAIIelQwaEAt6b0OKW4w9YEESz+bbsfcMjoKYwvqtu8wxdYjTEk+U5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887685; c=relaxed/simple;
	bh=A+gsmRHhQ65EGjIdwCREM1GXzXS4uN/8v+W2J6N27oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FElUlj43a9P948jVUekx5Xa2ZZkbkflEx2uFw1RLdShUhq21MssnBjB4wmuz9Ovd8mkmg4uS94rtgDZQfYryDrt9cBgYSNlVQjkpY4pSMdv+KflHKKgoFI0PDSslvdwBBxiajePIlqGqlRetEjr1HIl73R8+UAXSwz2D2V7PS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=At17JKp0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="At17JKp0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887685; x=1817423685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A+gsmRHhQ65EGjIdwCREM1GXzXS4uN/8v+W2J6N27oU=;
  b=At17JKp0nCK/vxEa7j+sb27t78Vl2z8ITRzurYmI0LbbPaGgXSFHuFrS
   +hZH1TFDyRC1alTx7XyZ7Jrd8lDBhUS4dYkflxFm1bo4xkse3Y/lDWonQ
   Q8JjzF8hsJXWcpLifDzfzGraux1ogyPPxOP/uXs7WU+IQIKByCtDC7YdL
   Nj9mpP4ArgkPwPDUGk/7+5MO7roS8CDYZuczPDpz6SbiR5u+pDkLdIkbL
   vGkn8MDUqiuaL9sLFnp/rk1IPGUlEpYAF1X0DGNlNk9hInPjSfnZXZqpb
   RwUKtu5qf0VD0M/P0gpv8lO34DIm4EhXfHbCT39GkdMLpt1b7utrrv/Y1
   A==;
X-CSE-ConnectionGUID: FSZOiF11TteY4tntUjONmw==
X-CSE-MsgGUID: 1Aim518VT2KW5RXUOdIkNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263272"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263272"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:44 -0700
X-CSE-ConnectionGUID: FmMSGh/tSHmi+OWGHO1ExQ==
X-CSE-MsgGUID: UDhXmBsaTiKEWd/XRRdzWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324367"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:42 -0700
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
Subject: [PATCH v2 09/19] iommu/vt-d: Use dmar_can_force_on() for platform opt-in
Date: Wed,  5 Aug 2026 07:43:03 +0800
Message-ID: <20260804234314.3087110-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
References: <20260804234314.3087110-1-baolu.lu@linux.intel.com>
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

