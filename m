Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866F415F1A
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811716; cv=none; b=rrQ2xo2InL7zM9PhiFw36a8RsPmIo9zI7dcM3+kwkxvfIb7IzOGVYN6d9MXb1992MR/SG1TeeLnkVBz58O+7eJ0Gf9xNuFY8ejsF94VyLC+RiMmLO+p9sOpwwxveweU0zGsRkcCZHnCQN9SyeskUsfroedvqpWdHc8wPWpwzea0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811716; c=relaxed/simple;
	bh=YDlwD9/B7SoUh5Cw/Q8HBWUAKwRQP4CubhpluDGbVfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AvBHkElHF1UaliJ+1i0pnouYDM6V7K7fUOEZOWDM1TwUGTbgWFVerxd2FalA03vRUpZJI+7xC8+Z4L8BBNsUE02gP5UHOthRhrSAA0ZaiP+GgpsRNKWCA2KBtP1X1whpdnOPDI1ze52G12pdFPbPolSd3/Ccj/02lZPfcHbabio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3tjeRy+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3tjeRy+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811715; x=1817347715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YDlwD9/B7SoUh5Cw/Q8HBWUAKwRQP4CubhpluDGbVfg=;
  b=V3tjeRy+21daXBBtZAVLtuj2mkBJjBXbyWoMEUNtXnZgQxRJsfn/lV37
   Ezg+VopjFQ7b/XPOXLC+KmVgeeKqlDrjWAS0UECgXywyAoz9FVQwHnGFj
   xQZP3m+oFpQvis6tffThLbeGhKLRu3hqXPDQFLH5OeFy37pDbwoVvnw1I
   4gQ3tLbINouWj/EjsIy+aKqcAcUWfxkZJ0NeBCBkOIn4mLlnOdFWCgecu
   zixMYWpNXPxz0FR5IqFc7bSG51dnzXJcMU0nBETi0oslgfYRGPgsZIPEu
   b9FCkZ9nzTxkNcICE2e5/OWKmrGnFjV4PVROsLiuspWAKj7CGljhjJnjh
   w==;
X-CSE-ConnectionGUID: VD+YZ9bARnSk2eJ+V18xDA==
X-CSE-MsgGUID: VPct6m2JSYiZzJLciIAxHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231256"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231256"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:34 -0700
X-CSE-ConnectionGUID: reCLnf5YTBGBfaYwrWoyGg==
X-CSE-MsgGUID: usZu3U3GTWKJsENiGkZKPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587470"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:33 -0700
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
Subject: [PATCH 05/20] iommu/vt-d: Fix no_iommu to disable platform opt-in
Date: Tue,  4 Aug 2026 10:36:59 +0800
Message-ID: <20260804023714.3080506-6-baolu.lu@linux.intel.com>
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

If user explicitly requests to disable iommu (via "iommu=off" or
"intel_iommu=off"), there is no reason to force enabling it due
to platform opt-in (for external-facing devices). User should be
aware of any security implication of doing so.

"intel_iommu=off" implements this policy by setting no_platform_optin
to skip platform opt-in in platform_optin_force_iommu().

However, "iommu=off" (no_iommu=1) doesn't set no_platform_optin
hence is broken in this aspect:

  - detect_intel_iommu() doesn't request ACS if no_iommu=1
  - platform_optin_force_iommu() forces iommu on if external-facing
    devices exist and no_platform_optin is not set

This leads to a bad configuration with ACS disabled while DMA
remapping is enabled.

Instead of setting no_platform_optin (will soon be removed) for
no_iommu=1, directly check no_iommu in platform_optin_force_iommu().

Fixes: 89a6079df791 ("iommu/vt-d: Force IOMMU on for platform opt in hint")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index cf5f92619943..1a1f27a51063 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2484,10 +2484,11 @@ static bool has_external_pci(void)
 
 static int __init platform_optin_force_iommu(void)
 {
-	if (!dmar_platform_optin() || no_platform_optin || !has_external_pci())
+	if (no_iommu || !dmar_platform_optin() || no_platform_optin ||
+	    !has_external_pci())
 		return 0;
 
-	if (no_iommu || dmar_disabled)
+	if (dmar_disabled)
 		pr_info("Intel-IOMMU force enabled due to platform opt in\n");
 
 	/*
@@ -2498,7 +2499,6 @@ static int __init platform_optin_force_iommu(void)
 		iommu_set_default_passthrough(false);
 
 	dmar_disabled = 0;
-	no_iommu = 0;
 
 	return 1;
 }
-- 
2.43.0

