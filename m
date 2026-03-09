Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7CC34F255
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036591; cv=none; b=KQUSdVfZEdQUXoO4Ckj6hSjdCJF4Leca54ZemISV5xycjZNXtYbBfZVeZIJ1WeBAyuqqx/boO5CFpWgXSV0GJrzpYsvc29AACBzRXDaTn31/VUuO1JhYtKDf2nr/LR+7yP9IBXTRREnRdu4LVtZvhN9hKeSFrAmzEWOJF9Hgbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036591; c=relaxed/simple;
	bh=hh2uOktjahAxQZlSnY1/zk5puptgnvDXUVoF/w/9cGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1eWnrEh1nQ19uAvgpnFqJ6NgLO3UQflelqEFHi4RBMbK38LG072ia5QOMP8XkGbVCMV/c7wD2IdWAmeOe/1uMscIhnFa1621M5ubUflY1ZRna1Zkt3FnjC0sS9ZxbCLCYrc//EcYWyAg3Phd89fVAPgxsniW2egI8GUMrFcbW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHOqSh8w; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MHOqSh8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773036590; x=1804572590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hh2uOktjahAxQZlSnY1/zk5puptgnvDXUVoF/w/9cGo=;
  b=MHOqSh8wEvqqKAY07it8gcEmAZp+kXfCSZobXsx0Ui3LReCjUNIRRoTP
   YIPD0e/4wMuNgonRNlye3G6UiQSotik/nDez/TPUz8ZK8sXa3zkQ0eq8D
   PNC4bgcezatkTgALGHry0It8q7xpNotvWoRabINRtDQWO2By90Ic33p4K
   UeyrmBrqpZFuQhhJeQLYZwbSqd+ZcECKDRRDb6L27hf/ug8d3CldR1WsW
   hmoAsaEoDk+FBNsiHCnHuhfzCZhfQNy+CJhx+0QwAg7ZZB0VSElURsIq4
   IS+7f+xWcl6LtXpRrEq7IkFUDpc0hPYLPQzJWgTPIOB4YlBsHCxnAIkJc
   Q==;
X-CSE-ConnectionGUID: Enho0ClNQkqkZ6YQFsaH+A==
X-CSE-MsgGUID: z22QRuZKT8uOh6SXkpdDmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="73248267"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="73248267"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 23:09:50 -0700
X-CSE-ConnectionGUID: zHm29YHkQK6tmG9AN4sSNg==
X-CSE-MsgGUID: I+ZcCJjiS7WqFoB8xwLwTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="245669165"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 08 Mar 2026 23:09:48 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Dmytro Maluka <dmaluka@chromium.org>,
	Samiullah Khawaja <skhawaja@google.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 3/8] iommu/vt-d: Require CMPXCHG16B for PASID support
Date: Mon,  9 Mar 2026 14:06:43 +0800
Message-ID: <20260309060648.276762-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309060648.276762-1-baolu.lu@linux.intel.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Intel IOMMU driver is moving toward using the generic entry_sync
library for PASID table entry updates. This library requires 128-bit
atomic write operations (cmpxchg128) to update 512-bit PASID entries in
atomic quanta, ensuring the hardware never observes a torn entry.

On x86_64, 128-bit atomicity is provided by the CMPXCHG16B instruction.
Update the driver to:

1. Limit INTEL_IOMMU to X86_64, as 128-bit atomic operations are not
   available on 32-bit x86.
2. Gate pasid_supported() on the presence of X86_FEATURE_CX16.
3. Provide a boot-time warning if a PASID-capable IOMMU is detected on
   a CPU lacking the required instruction.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/Kconfig | 2 +-
 drivers/iommu/intel/iommu.h | 3 ++-
 drivers/iommu/intel/iommu.c | 4 ++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 7fa31b9d4ef4..fee7fea9dfcb 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -11,7 +11,7 @@ config DMAR_DEBUG
 
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
-	depends on PCI_MSI && ACPI && X86
+	depends on PCI_MSI && ACPI && X86_64
 	select IOMMU_API
 	select GENERIC_PT
 	select IOMMU_PT
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 599913fb65d5..54b58d01d0cb 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -535,7 +535,8 @@ enum {
 
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
-				 ecap_pasid((iommu)->ecap))
+				 ecap_pasid((iommu)->ecap) &&		\
+				 boot_cpu_has(X86_FEATURE_CX16))
 #define ssads_supported(iommu) (sm_supported(iommu) &&                 \
 				ecap_slads((iommu)->ecap) &&           \
 				ecap_smpwc(iommu->ecap))
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ef7613b177b9..5369526e89d0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2647,6 +2647,10 @@ int __init intel_iommu_init(void)
 			pr_info_once("IOMMU batching disallowed due to virtualization\n");
 			iommu_set_dma_strict();
 		}
+
+		if (ecap_pasid(iommu->ecap) && !boot_cpu_has(X86_FEATURE_CX16))
+			pr_info_once("PASID disabled due to lack of CMPXCHG16B support.\n");
+
 		iommu_device_sysfs_add(&iommu->iommu, NULL,
 				       intel_iommu_groups,
 				       "%s", iommu->name);
-- 
2.43.0

