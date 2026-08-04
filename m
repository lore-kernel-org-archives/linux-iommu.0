Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CAC44C4EB
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887688; cv=none; b=DEQahUBH1BWdAdDS4+c41i6Yc5lLVO+ehAKoO9fTj5rUEhsTFfwgmjpDTx2SZnubEacMKDS3aujPfXZrRp4zaWqrFVYZttE6CDDB3DFfDPkWnfFVWrvTUMN3I+huLKmaTJhdZIAfhdKmKycTw/H8p9Uf8xkAdFl8XJ0olUcF968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887688; c=relaxed/simple;
	bh=8FoqMs3ZYEeu3bLuLfkxhhxNSLw1by1xUZ5wqDUZOY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amJT2RAoketzHCODo/GViV7Lyt6MDQGDpLwpCtkMWtH2VqbIVNOT8LG8Nsj7Vz5IAumhB57ZsCHIW9A8Ac/5BZB4hb1odv0Ap055Jf3zToOE6u4RPwefdTAqkDWdF7TD7RVC11iqmqD6RQY6erpI3i1Sq2TDxiHd4t7YT8ww0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DSEaoNHe; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DSEaoNHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887687; x=1817423687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8FoqMs3ZYEeu3bLuLfkxhhxNSLw1by1xUZ5wqDUZOY4=;
  b=DSEaoNHel1HaZZa8JzVOdP123hQA+M25M8Tg9HMvWiDMuzFVDl3iEmIC
   W1ivI5mojiSK6CoWp6v6Qc7utmV49rVqDK4K2PQyIRzgHcG89ZLpqv1ws
   Rc+xVA2kDaDonzY+jWtmfVmvFY/Ba2lROqdN3izS241nUlfKfmUdMX3W6
   qHgJcjmJMQQ3NUT3BZJ6LYB8Hips6QoFc4mQX0PAZtnolOKn3/68li171
   Cih1k7WmRELMsvR8UNXG2SchCbE939QuTuu3Cym/IOXHGP+cQ5fT+TdMW
   gztJgVkSTrCgrh0JDQauZfSd+GXGOMt1FCI91T/Ncd1otKc5zS24EoLCM
   w==;
X-CSE-ConnectionGUID: hGcx4xggRUaFAYJjozTH/Q==
X-CSE-MsgGUID: YlgKd7HUSey2lCc49a6kQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263284"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263284"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:46 -0700
X-CSE-ConnectionGUID: 1cqK8tBlTACzvvVmxU3djg==
X-CSE-MsgGUID: Z1YrbryETTStT11KKZJVgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324372"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:44 -0700
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
Subject: [PATCH v2 10/19] iommu/vt-d: Call dmar_can_force_on() for tboot opt-in
Date: Wed,  5 Aug 2026 07:43:04 +0800
Message-ID: <20260804234314.3087110-11-baolu.lu@linux.intel.com>
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
with that in tboot_force_iommu().

Though tboot is the strongest override so far, dmar_can_force_on() may
return false due to future extensions. In this case panic the kernel,
as is already done when failing to initialize DMA remapping for tboot.

No functional impact at this point.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ce0794e82e55..5eb80aeec274 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2550,12 +2550,17 @@ static int __init probe_acpi_namespace_devices(void)
 
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
 
@@ -2572,8 +2577,7 @@ int __init intel_iommu_init(void)
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

