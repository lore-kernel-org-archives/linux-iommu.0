Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA32330305
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 06:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972091; cv=none; b=UhPUESDu5OZfQ8vdgRf9hy7V9db7AmQU4Ij+eugZVc1Crx6d7u7ZsAjFB2iILHe9huXFvDbDWAzbVpjpJqSY2+ClfSw2ZDy8IMtHGYRGQMm/zGcXXoaznLJSUItQLYsCEaREpjQjyjC0F7xCXQonzOolgp5uqzjxQvDzVG9mTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972091; c=relaxed/simple;
	bh=gGeO9z5X2SJRN+vc294gSHIsnC8wI3DlrrbZKliaqEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAci9vMMs6MNF7YEA7uvylAuvSbVUPhioncgIfV+63tm8bizQypivu11/EIQkXe9MU/tC6s5jWwV+e7802WoKvMg72Pyblmx2m6JZt1VxqdzbFVeTuT4Wn8iDS8JsFne3xGBbDMyODdkFoJ948v2dwTipWpnHqXvH5ChKsIaIi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnwpXqJJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnwpXqJJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972088; x=1814508088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gGeO9z5X2SJRN+vc294gSHIsnC8wI3DlrrbZKliaqEA=;
  b=GnwpXqJJpw6AfFM8BRZK+sSOl6Nxj7ntnE63GEPLSYzr5ZwV0IvfsouG
   yNAeRxJwDmXKPKwKNj/YYsrIlhbYNRoxvj2/aldGPzPBjAgQG/Z840d0g
   HSlS8l7f8sa2w5h9ESNwCq4mYasPvazhUdN7mraP5J0Y3hEqRJ0d1Tv6m
   qz4GEyI8360Ow0vXJ1fHKXdTiZ2IqC3pfevJV/7DnosTPE+CBl90kXJ90
   XYml8DHe0gJWXImWaL5IsSZnSlHae6QX/1egl+bK5mSTDIAARmACA8Q3j
   sxbVo5prXU5+/4ALCGEbjA4Brq2UkpKNAQQokNI6A4VqL8jK4Vlqvahj3
   Q==;
X-CSE-ConnectionGUID: P8LoRwcJSIu3Slj70SrI0Q==
X-CSE-MsgGUID: SEL22VLFSVKPNxLhh4vhwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256495"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256495"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:28 -0700
X-CSE-ConnectionGUID: iOwxIMbVTF27x9UR7r4Rzg==
X-CSE-MsgGUID: GncyN1feRIeAkuHHmJ3j9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425874"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:24 -0700
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
Subject: [PATCH v2 6/9] iommu/vt-d: Call dmar_can_force_on() for tboot optin
Date: Thu,  2 Jul 2026 06:12:13 +0000
Message-ID: <20260702061216.388743-7-kevin.tian@intel.com>
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
with that in tboot_force_iommu().

Though tboot is the strongest override so far, dmar_can_force_on() may
return false due to future extensions. In this case panic the kernel,
as is already done when failing to initialize DMA remapping for tboot.

No functional impact at this point.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 94cf144b4b70..cddd3ab215cf 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2548,12 +2548,17 @@ static int __init probe_acpi_namespace_devices(void)
 
 static __init int tboot_force_iommu(void)
 {
-	if (!tboot_enabled())
+	if (!tboot_enabled() || intel_iommu_tboot_noforce)
 		return 0;
 
-	if (no_iommu || dmar_disabled)
+	if (!dmar_can_force_on(DMAR_FORCEON_TBOOT))
+		panic("tboot: Failed to force IOMMU on\n");
+
+	if (dmar_policy_off())
 		pr_warn("Forcing Intel-IOMMU to enabled\n");
 
+	/* No concurrent access to dmar_policy at this point. */
+	dmar_policy = DMAR_FORCE_ON;
 	dmar_disabled = 0;
 	no_iommu = 0;
 
@@ -2570,8 +2575,7 @@ int __init intel_iommu_init(void)
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

