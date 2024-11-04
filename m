Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372741AB526
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730684507; cv=none; b=OzbGue1+ey9Hsuwn7fZtgZSllovu3OoZQqm8zn5qcqII7PvVccDRLpeGVEed5O9k10eauJ7CLVzQcHKmSUQoZRoi6wF4lteZEATEUiT6zg9ajegyAptdDUzZbVZ5+PNLXJ1nVudeyDMsej+YlfB+/teG4PGndEPGrtcr/4AfU7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730684507; c=relaxed/simple;
	bh=7d3csjJ3DYXPQKUIp1GBHIvCPxoLtAyeR0KKMwyATM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEqGA7+8YHfYxYkBwcW+9uAP1sMf09F2MoOUrVirCjoGxmHuJXpaZIH7O7zBMqIu6aLpKLUjlBboYMkGkIoCrNCiW/s94fkdt1FTlizA1Glhn9daeml13+TjGtm5UItIjeu0EoS1rnbif5cfBc+UfyMlThmS8ryMQGIIzfLhPV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SCWfnPIz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SCWfnPIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730684506; x=1762220506;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7d3csjJ3DYXPQKUIp1GBHIvCPxoLtAyeR0KKMwyATM0=;
  b=SCWfnPIzv9t+FzY6nC8wuooDiZ1hsx3GTKZcrGHDazxHPOCwhCwGmIpF
   5l4uHuxZuum2UfQHArISgkEgHZdhHa+I7Fa1H7pPJ+yjn2xY5M8UQ5TQC
   eYh4ZjiMsCeg3v/1QW9+gayqXViaGqqZtZAhXR7qPMzpdjpQQlW6PlNdm
   qlJoAIwWiRBgaZIfsikPWSLVxMvbfDIq3CBBunHuvkSIFy90CtkJCBIPP
   wssJjNtoOoIY1/96v2crCrruTS6T8dkqcNtd64msb/ebM1+vvq/tODc2v
   qbbTH8xvFwfGSrOFqCpNsQuLn9IxudRcrzpH8jS5pv+YLl1RMVPA39O6s
   w==;
X-CSE-ConnectionGUID: nF2PTwxyRYuv5Wi1fThStA==
X-CSE-MsgGUID: UCJo8alyTcuoHG110Es66Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30221966"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="30221966"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2024 17:41:46 -0800
X-CSE-ConnectionGUID: +I98svfDQn2OxAfdLPFW7w==
X-CSE-MsgGUID: 2XeJd0MVQUGI3+Nv6gF51Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="88020909"
Received: from allen-sbox.sh.intel.com ([10.239.159.30])
  by fmviesa005.fm.intel.com with ESMTP; 03 Nov 2024 17:41:45 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/19] iommu/vt-d: Drop pasid requirement for prq initialization
Date: Mon,  4 Nov 2024 09:40:38 +0800
Message-ID: <20241104014040.106100-19-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104014040.106100-1-baolu.lu@linux.intel.com>
References: <20241104014040.106100-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Klaus Jensen <k.jensen@samsung.com>

PASID support within the IOMMU is not required to enable the Page
Request Queue, only the PRS capability.

Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Joel Granados <joel.granados@kernel.org>
Link: https://lore.kernel.org/r/20241015-jag-iopfv8-v4-5-b696ca89ba29@kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 1e432729ea09..87a3563dfe54 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1329,10 +1329,8 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	/* free context mapping */
 	free_context_table(iommu);
 
-	if (pasid_supported(iommu)) {
-		if (ecap_prs(iommu->ecap))
-			intel_iommu_finish_prq(iommu);
-	}
+	if (ecap_prs(iommu->ecap))
+		intel_iommu_finish_prq(iommu);
 }
 
 /*
@@ -2192,7 +2190,7 @@ static int __init init_dmars(void)
 
 		iommu_flush_write_buffer(iommu);
 
-		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+		if (ecap_prs(iommu->ecap)) {
 			/*
 			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
 			 * could cause possible lock race condition.
@@ -2616,7 +2614,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	intel_iommu_init_qi(iommu);
 	iommu_flush_write_buffer(iommu);
 
-	if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
+	if (ecap_prs(iommu->ecap)) {
 		ret = intel_iommu_enable_prq(iommu);
 		if (ret)
 			goto disable_iommu;
-- 
2.43.0

