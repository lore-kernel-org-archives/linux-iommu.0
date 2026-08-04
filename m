Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E344210F
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887675; cv=none; b=AaR9ikG68yogMoPkWhABwMNeU99c1zLaFA7FplPk71B6nFSGY0xuOTQoecC1uKF3J0LALc/s4mJOeVaTeUIt4dZW4W7uqdbHWhKpDnspsMZi8AFDEl1pNN7y0Nd8/Hvlrs4PXpq9OnwsUbeOhWRMCt/5Xcz98PL/ZPz1ndhpBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887675; c=relaxed/simple;
	bh=YDlwD9/B7SoUh5Cw/Q8HBWUAKwRQP4CubhpluDGbVfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ur8WxHX6N5bqw+g+uN+R7WxApkvD902QzRdiEbfeiRFKUjnkA65jcg+aX0YaGuzPDn7oJ5n9Lf1LDau8GcyhwOvYE803LVzixY2EA57ONVkV+J0jcRP3l+26/N4DVrGtIY8Q2NvxBE4aXaz/0nxTQGwaakqzUiMFgahDLoqcjVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IbNVlSci; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IbNVlSci"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887675; x=1817423675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YDlwD9/B7SoUh5Cw/Q8HBWUAKwRQP4CubhpluDGbVfg=;
  b=IbNVlSciVQdwUm0M9/7h+NpFJQB7C/7D3lmw8jNJqeWygc4baySiM4ec
   mEVIhCx7dFBvT1Apr966r6xgpiet7MsF97lkjQeROa3hddnCGgQQGaDHj
   Xvg2BEigWJzAQ8I7VgMxnXf4bH+JOh2WWhysoT/1KKDZGzl8JgU3ZsT50
   PRKzb9bRjfQKgqb4/PcwqqSgvJFU0mK1lEcrINTYB+/QJTvVZkjOuWxW9
   7fXNOF9CM+X9P1HFaj8xEdi5AoJCJVKCtvzUmngIlkv1I5bbTnPyybzYH
   JfBgUKPJD2uCjOYyz4cGH978utbfJkC+zE0lA/WxrBs4T6GG9j7SEgsW5
   w==;
X-CSE-ConnectionGUID: T2oimgDpRBy7rwOqqvqtNQ==
X-CSE-MsgGUID: IYfPOWxgTDu2UHXDLAgs3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263230"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:35 -0700
X-CSE-ConnectionGUID: iMEDTU4ORkWONeuykAp4ww==
X-CSE-MsgGUID: VgDoMu1TT4K9t+jCdoFRdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324335"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:32 -0700
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
Subject: [PATCH v2 05/19] iommu/vt-d: Fix no_iommu to disable platform opt-in
Date: Wed,  5 Aug 2026 07:42:59 +0800
Message-ID: <20260804234314.3087110-6-baolu.lu@linux.intel.com>
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

