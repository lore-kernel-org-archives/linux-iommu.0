Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA361598E5
	for <iommu@lists.linux.dev>; Wed, 24 Apr 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963962; cv=none; b=EVrvEGPPUi8+H0jaI+MeWpwpC1ZJmmED74RPGvzGAFDYB3Yawbjs8GoCJHyVeQ4jpklpIXu0ZQ4Hwn3E1ZXAeTRvHT/oHLk0iRJr0ah0i+zY7B0eyECD7qqH8SjEh8qkAK7DsYa95cWM5mTBbPaRyeZUKzkdRS+t8IzyNhw2gzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963962; c=relaxed/simple;
	bh=viivNmGepG1MIuQie3zNxU/hsNFOPvsbAJiT/FJhqdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xg8AJD8x1WW4N4u5u4u01tj3n1grX1dK7RxlTFIJslgH/B9DhJ4D3xvaa7m7luCOd3umW3sGRFO1xDnvylmX9Y/ZS6vXdc6Pm2Shjrhc9LL38wY8tVheCH/kPt7KLlbfRdUo6Io01FawhYsp3G9dW+jZDzgqNlQtBVAVVCKmMUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2Alh3yU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2Alh3yU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713963961; x=1745499961;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=viivNmGepG1MIuQie3zNxU/hsNFOPvsbAJiT/FJhqdA=;
  b=f2Alh3yUjne/23tyxpYcPrrqCSqNmc8Ahk8kocgT02ltC2DXCQG6eY/l
   GLA635dUsVCxnEA5/tAv+4gt/ZzbcosC6bsZADXMeypoyOaH5bX8c4KEz
   jgYxosiFB0iQywf4F5Ie1lR5iPRsw8ytrhVsjR8uHsvdifDngLkMyR/S8
   djjJder8fwVWOHH/FJ4nbEfNzJAk662zipGHwJ/kqV9twePYLbMeqp4j7
   8IX8z0CigmasCjMbTwzL6R+GHPIjGvItqQTc56yk84ezr9e/hKtuyl4K/
   S/KKtN99bwlwBUxnlf4Bhug5uSqKvfs0NnRArg6oeRmvgsfIH1uSXMBPC
   w==;
X-CSE-ConnectionGUID: nZs2YnQPQtKKL+GdpG4vug==
X-CSE-MsgGUID: T3eyLbhWSWuAeQV4TR0IMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9462860"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9462860"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 06:06:00 -0700
X-CSE-ConnectionGUID: G/GASjhURuqGVpdcL5wL3Q==
X-CSE-MsgGUID: UcZS+KsfQdeL1ob2Ja+iog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29183328"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 24 Apr 2024 06:05:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7B736136; Wed, 24 Apr 2024 16:05:56 +0300 (EEST)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] iommu/vt-d: No need to export dmar_platform_optin()
Date: Wed, 24 Apr 2024 16:05:56 +0300
Message-ID: <20240424130556.357897-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function is not called anymore outside of this driver so we can
drop the export and move the declaration to the driver private header.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/iommu/intel/dmar.c  | 1 -
 drivers/iommu/intel/iommu.h | 2 ++
 include/linux/dmar.h        | 7 -------
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 36d7427b1202..42b79043241c 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -2480,4 +2480,3 @@ bool dmar_platform_optin(void)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(dmar_platform_optin);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 404d2476a877..4a965848ea0f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1041,6 +1041,8 @@ static inline void context_set_sm_pre(struct context_entry *context)
 /* Convert value to context PASID directory size field coding. */
 #define context_pdts(pds)	(((pds) & 0x7) << 9)
 
+bool dmar_platform_optin(void);
+
 struct dmar_drhd_unit *dmar_find_matched_drhd_unit(struct pci_dev *dev);
 
 int dmar_enable_qi(struct intel_iommu *iommu);
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index e34b601b71fd..233ef518dc99 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -173,8 +173,6 @@ static inline int dmar_ir_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
 { return 0; }
 #endif /* CONFIG_IRQ_REMAP */
 
-extern bool dmar_platform_optin(void);
-
 #else /* CONFIG_DMAR_TABLE */
 
 static inline int dmar_device_add(void *handle)
@@ -187,11 +185,6 @@ static inline int dmar_device_remove(void *handle)
 	return 0;
 }
 
-static inline bool dmar_platform_optin(void)
-{
-	return false;
-}
-
 static inline void detect_intel_iommu(void)
 {
 }
-- 
2.43.0

