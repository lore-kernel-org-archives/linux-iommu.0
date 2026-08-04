Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4CF44CAFC
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887678; cv=none; b=Kz47rkuzOjimFwW2mffHPfEb0EFIvYsS4hqIdjHEgYzwYPHxl1R2qr6HecNLF47zef+LjfwbnV8U31Vbaxg7EvDKTcwjDLnXaVFpX2f4wyv2kRElX5zwUu33JkyV4tuIvXGQzPd2h3l6uzo8vMb0kv+iv7xJPOh5O3msYlSjmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887678; c=relaxed/simple;
	bh=RHtZyNIndU8qQJD0heWZbkAT4r7eUBHP8fHD/4aUctk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQ+ipn0ucyNAAx34uguegxR9NKHGD09iPI1xmSvywwnqOthSAkX+1/iI1sFbPRT6aEeU/GCpAd0rzVqqN8+Ee7KXe9xlp+SFlFtgqapSKC3ErXns5HXylE6+rMF9wKhEJf2J2B4M0DpJLvuc28u1eB9JAu9kn0ipyFenmGKnzHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gm5SDzze; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gm5SDzze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785887677; x=1817423677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RHtZyNIndU8qQJD0heWZbkAT4r7eUBHP8fHD/4aUctk=;
  b=Gm5SDzzeBTmFJdq0ygwJy+DQY8siMPdxWLeAHuFfxp69RhNREqxjzeLH
   lZ1vVb1VYgnp/6kCVeE4HqirAHANhc9jXIChieSvC60s0YunWMlOuE5nr
   ZHZ/7N9I76XKAsn45o6WkCqDOSMdTBeXfzo6yOcx82c8oPrOnODLg1p+L
   zK3nKvX2qH2HqNmHnddMD/XktwXLw1ie08etdIt0eGRmf+3D3uO7/2ZwE
   tHtXsVIImG1blyq2NjxDaWvw+KzQj7tw62MeHBDoX5p+//M2b3IPPKEWS
   cI34FbWeWOWN3XPjrKM8iAZtkNqW6+6/ArjpYg5/V0lwsm69NSSziKZCK
   w==;
X-CSE-ConnectionGUID: mePiARkERu+w4GHabyyXjg==
X-CSE-MsgGUID: pYzo40qFTCe3YDJo/wD/AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="90263241"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="90263241"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:54:37 -0700
X-CSE-ConnectionGUID: U6p2i+/mShu/pe00WoWDGQ==
X-CSE-MsgGUID: U/RU7AxpR4u0Sy/suQSTbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257324350"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 16:54:35 -0700
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
Subject: [PATCH v2 06/19] iommu/vt-d: Force requesting ACS when tboot is enabled
Date: Wed,  5 Aug 2026 07:43:00 +0800
Message-ID: <20260804234314.3087110-7-baolu.lu@linux.intel.com>
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

Currently the conditions of requesting ACS in detect_intel_iommu()
don't include tboot, leading to a possible misconfiguration with ACS
disabled (e.g. due to user opts) while iommu is later forced on by
tboot_force_iommu().

Fix it by checking tboot in detect_intel_iommu().

Fixes: 5d990b627537 ("PCI: add pci_request_acs")
Cc: stable@vger.kernel.org
Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h |  2 ++
 drivers/iommu/intel/dmar.c  | 15 +++++++++++++--
 drivers/iommu/intel/iommu.c |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 775f1c4ae346..2cee36138d6e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1354,6 +1354,7 @@ static inline bool ecmd_has_pmu_essential(struct intel_iommu *iommu)
 
 extern int dmar_disabled;
 extern int intel_iommu_enabled;
+extern int intel_iommu_tboot_noforce;
 #else
 static inline int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
@@ -1366,6 +1367,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
 #define intel_iommu_sm (0)
+#define intel_iommu_tboot_noforce (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 767ec092accd..e32685402f74 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -915,6 +915,18 @@ dmar_validate_one_drhd(struct acpi_dmar_header *entry, void *arg)
 	return 0;
 }
 
+static bool dmar_required(void)
+{
+	/* tboot supersedes any user/platform opt */
+	if (!intel_iommu_tboot_noforce && tboot_enabled())
+		return true;
+
+	if (!no_iommu && (!dmar_disabled || dmar_platform_optin()))
+		return true;
+
+	return false;
+}
+
 void __init detect_intel_iommu(void)
 {
 	int ret;
@@ -928,8 +940,7 @@ void __init detect_intel_iommu(void)
 	if (!ret)
 		ret = dmar_walk_dmar_table((struct acpi_table_dmar *)dmar_tbl,
 					   &validate_drhd_cb);
-	if (!ret && !no_iommu && !iommu_detected &&
-	    (!dmar_disabled || dmar_platform_optin())) {
+	if (!ret && !iommu_detected && dmar_required()) {
 		iommu_detected = 1;
 		/* Make sure ACS will be enabled */
 		pci_request_acs();
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1a1f27a51063..4d03d9a517de 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -57,7 +57,7 @@ static int rwbf_quirk;
  * (used when kernel is launched w/ TXT)
  */
 static int force_on = 0;
-static int intel_iommu_tboot_noforce;
+int intel_iommu_tboot_noforce;
 static int no_platform_optin;
 
 #define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
-- 
2.43.0

