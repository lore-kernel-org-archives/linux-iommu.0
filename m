Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6D418A55
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811732; cv=none; b=WJoghEbPoH+f6V+Vqk31dSmwqIvT18eGJllOnhl/J0/Ms3u8I00m/pimScgyG1FyENd0Yqg60lvwYLEy3dZvftkPbosLegp2zTObPzcxLyNWZ6WqhatMris6D3sqQp4jE+sUtBDjOKdDEtwPFpdl4BJgmrkhE6NskWI9MYnu2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811732; c=relaxed/simple;
	bh=I0opl1w8B2GbMLseY7HCMG0uR/eGIL6O6uLirKXdHBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmM0LKA1RCm7dArKGyD255QxQc9ANQJD95Ud5ZSAXKDcdlusfmFwQpy4RA/9bJjkSXvPnflv8PGt1YbPyNLupz9EMNhL74PXee9lowW4Ivsn0dOF6Hr7lPbZc2JUpLmEZQVNdDk3eLVTmNdBEuNSyon+No2IDMb6GHQvR4Ba7D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=am1HUdvR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="am1HUdvR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811732; x=1817347732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I0opl1w8B2GbMLseY7HCMG0uR/eGIL6O6uLirKXdHBI=;
  b=am1HUdvR5jQXB5HdOkOGax18EcPK7kGo9DxnxwuFXZonU/9YwMxA7LhS
   ikF63hNa4wky5YboZtbkwXBa1/x0zyYWcP0AD2gVoBBXtMPrenQMBQiL8
   cTgtbPzXmbEx5JlPd00fB6fbqa3rdHPUz2pF4AQEqTz6iBp9biqUE4uMr
   fi7Zz4JYfc47Gwt884xzST89xY3FFbX0zfzHd3/i6RpOoCr1Walgx0syp
   sWJ1vQiOOThFiR04/zhbR6+j8qlfY2Kphjt4rKzA5gRZ10aL/S9kqBQZ5
   n/NiZN/bk/qnWTKOSq4p5x7/uO8SfDxPUCQ2CpSqlZ8zb1u+uwUTXlNfm
   A==;
X-CSE-ConnectionGUID: LwecYtLNQb+aJSQVqyRL8A==
X-CSE-MsgGUID: xcCGmPQnSH2kreeFXitgKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231321"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231321"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:50 -0700
X-CSE-ConnectionGUID: Ma5gFujNQ1q3dYTrtiz8wg==
X-CSE-MsgGUID: htWB2DaUQQW3Pqxa14xdlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587553"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:48 -0700
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
Subject: [PATCH 12/20] iommu/vt-d: Remove dmar_disabled
Date: Tue,  4 Aug 2026 10:37:06 +0800
Message-ID: <20260804023714.3080506-13-baolu.lu@linux.intel.com>
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

It's replaced by dmar_policy_off() now, covering both "iommu=off"
and "intel_iommu=off". Also remove unnecessary checks on no_iommu,
leaving only one exception in intel_iommu_init() which skips debugfs
init for "iommu=off" but not "intel_iommu=off". Keep it to avoid
surprise for now.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.h | 1 -
 drivers/iommu/intel/iommu.c | 9 ++-------
 drivers/iommu/intel/svm.c   | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 40da2ed7e254..9805edb8c7df 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1401,7 +1401,6 @@ static inline bool dmar_policy_force_on(void)
 
 bool dmar_can_force_on(enum dmar_force_on force_on);
 
-extern int dmar_disabled;
 extern int intel_iommu_enabled;
 extern int intel_iommu_tboot_noforce;
 
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 118c62e859fd..a996b72aca57 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -202,7 +202,6 @@ int dmar_policy = DMAR_ON;
 #else
 int dmar_policy = DMAR_DEFAULT_OFF;
 #endif
-int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
 
 int intel_iommu_enabled = 0;
@@ -244,11 +243,9 @@ static int __init intel_iommu_setup(char *str)
 	while (*str) {
 		if (!strncmp(str, "on", 2)) {
 			dmar_policy = DMAR_ON;
-			dmar_disabled = 0;
 			pr_info("IOMMU enabled\n");
 		} else if (!strncmp(str, "off", 3)) {
 			dmar_policy = DMAR_USER_OFF;
-			dmar_disabled = 1;
 			pr_info("IOMMU disabled\n");
 		} else if (!strncmp(str, "igfx_off", 8)) {
 			disable_igfx_iommu = 1;
@@ -2371,7 +2368,7 @@ void intel_iommu_shutdown(void)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
 
-	if (no_iommu || dmar_disabled)
+	if (dmar_policy_off())
 		return;
 
 	/*
@@ -2505,7 +2502,6 @@ static void __init platform_optin_force_iommu(void)
 
 	/* No concurrent access to dmar_policy at this point. */
 	dmar_policy = DMAR_FORCE_ON;
-	dmar_disabled = 0;
 }
 
 static int __init probe_acpi_namespace_devices(void)
@@ -2558,7 +2554,6 @@ static __init void tboot_force_iommu(void)
 
 	/* No concurrent access to dmar_policy at this point. */
 	dmar_policy = DMAR_FORCE_ON;
-	dmar_disabled = 0;
 	no_iommu = 0;
 }
 
@@ -2602,7 +2597,7 @@ int __init intel_iommu_init(void)
 	if (!no_iommu)
 		intel_iommu_debugfs_init();
 
-	if (no_iommu || dmar_disabled) {
+	if (dmar_policy_off()) {
 		/*
 		 * We exit the function here to ensure IOMMU's remapping and
 		 * mempool aren't setup, which means that the IOMMU's PMRs
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 726f7b6d0bff..432e35723ce9 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -115,7 +115,7 @@ static int intel_iommu_sva_supported(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
 
-	if (!info || dmar_disabled)
+	if (!info || dmar_policy_off())
 		return -EINVAL;
 
 	iommu = info->iommu;
-- 
2.43.0

