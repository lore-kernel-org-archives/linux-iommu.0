Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E545367F5E
	for <iommu@lists.linux.dev>; Thu,  2 Jul 2026 06:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972096; cv=none; b=Ewn7s2Jpd6MDxdI46oLQzd+qeJz11XFsat2HAEqqMXoDVi12uCBCc8RKaK7mb6xlefnOSMOuPm02sRVZ/GZruKAx32SWDMQVQihtzPp9kVTRaJazUJMfeFpGpScYTCcVdjE/bqYiDKw6XDnd3Rq61Jvl/ws+QRmKvD79ethtWWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972096; c=relaxed/simple;
	bh=nw6vqerEKtMjQGpFpah8ivdXT2RFXgLoQvqrJslgSkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAyEOcbFgOqnx/YYiqgoQPI5JC8r9N/GN//9HGA7wsko3tYrJNj9YlGxi0gfS7hQntp+jsh+StOW/089FPogZ3DcAjMdsQPAYNJ+hv5VUxN/67eOWaiYaSsoN8wPMB8YsvDB4AR22uqz57qkp6qzjkQ1D6Mzy2p2gc18UD+/gxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mo/sjiHG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mo/sjiHG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782972094; x=1814508094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nw6vqerEKtMjQGpFpah8ivdXT2RFXgLoQvqrJslgSkE=;
  b=mo/sjiHG7O6Hi0f77sl1RL5U26J13xCf+o9zeDM2cUzHgobzkUApE1j/
   V3mRIcy7hb6RVpcB8xcZG6Sfr1w+t8Mt0KNz6cDrQ10IclEDhBS5fPm1/
   7KH+pNWKSTtTfBT+8ztyXOflugN63X9zHy/5wRAzv9iItDsSb6NZh+FQQ
   bFPaUDxHAxB+2OJSTrSR+L/iapKakfZTnnt78BmS2p+WYss4YG+MCdG5m
   mETLFvlMe1hK8CmBiO3VAqZGRKp0oqyCWaAW2d5kqbUZqEhqbQcEqLCaU
   VtXmTU/HozAiARCQzA45FhM2b1BpttGhEL71/pS7qpksXO6cFscWg9iGF
   A==;
X-CSE-ConnectionGUID: ZrIboxC3QpmvWRLwtDom3Q==
X-CSE-MsgGUID: hkKWpSK7TaCNk6ANOTXp0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="101256516"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="101256516"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:01:33 -0700
X-CSE-ConnectionGUID: ig2qslc/SGS2fd1ty2brxQ==
X-CSE-MsgGUID: Rt6sOD3GQfaoGsl6nES/hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="253425910"
Received: from ktian1-pkvm.sh.intel.com ([10.239.48.205])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2026 23:01:31 -0700
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
Subject: [PATCH v2 8/9] iommu/vt-d: Remove dmar_disabled
Date: Thu,  2 Jul 2026 06:12:15 +0000
Message-ID: <20260702061216.388743-9-kevin.tian@intel.com>
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

It's replaced by dmar_policy_off() now, covering both "iommu=off"
and "intel_iommu=off". Also remove unnecessary checks on no_iommu,
leaving only one exception in intel_iommu_init() which skips debugfs
init for "iommu=off" but not "intel_iommu=off". Keep it to avoid
surprise for now.

Signed-off-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 9 ++-------
 drivers/iommu/intel/iommu.h | 1 -
 drivers/iommu/intel/svm.c   | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 50dfe426322f..3312ee28db11 100644
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
@@ -2369,7 +2366,7 @@ void intel_iommu_shutdown(void)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu = NULL;
 
-	if (no_iommu || dmar_disabled)
+	if (dmar_policy_off())
 		return;
 
 	/*
@@ -2503,7 +2500,6 @@ static void __init platform_optin_force_iommu(void)
 
 	/* No concurrent access to dmar_policy at this point. */
 	dmar_policy = DMAR_FORCE_ON;
-	dmar_disabled = 0;
 }
 
 static int __init probe_acpi_namespace_devices(void)
@@ -2556,7 +2552,6 @@ static __init void tboot_force_iommu(void)
 
 	/* No concurrent access to dmar_policy at this point. */
 	dmar_policy = DMAR_FORCE_ON;
-	dmar_disabled = 0;
 	no_iommu = 0;
 }
 
@@ -2600,7 +2595,7 @@ int __init intel_iommu_init(void)
 	if (!no_iommu)
 		intel_iommu_debugfs_init();
 
-	if (no_iommu || dmar_disabled) {
+	if (dmar_policy_off()) {
 		/*
 		 * We exit the function here to ensure IOMMU's remapping and
 		 * mempool aren't setup, which means that the IOMMU's PMRs
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 95962a45ac36..ad4d1aafd12c 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1401,7 +1401,6 @@ static inline bool dmar_policy_force_on(void)
 
 bool dmar_can_force_on(enum dmar_force_on force_on);
 
-extern int dmar_disabled;
 extern int intel_iommu_enabled;
 extern int intel_iommu_tboot_noforce;
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index fea10acd4f02..0636987f03c8 100644
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

