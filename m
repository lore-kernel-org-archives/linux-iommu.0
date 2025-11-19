Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E032D9789
	for <iommu@lists.linux.dev>; Wed, 19 Nov 2025 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763529510; cv=none; b=Ong5jsHzUKHGt5fbnLIt6KtlCaUi5LFYVr+AGeIbw/TZoh+SqZ8EDMuXQD/W1zMpGZ33y6Rj7M7GpFrQ3tdWJOBmgwkzcefs/GXbstGNL3lk3oLrZwjM4fkvOpDpE9Ppdob9wBq/GexPT8jabmRh5Fl/2uFc8Z9maRsX2tmUNcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763529510; c=relaxed/simple;
	bh=zkc+53DcpKH9wdS4PWEt3+lElHa89+k0CfVROm7fMQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFp4tYfVb4xWNGNbKbqemDmJuugOmjlaCCdX8RZt3RM3t/ElITVXRR3F4LTmq03htHWdfvPUUmThpfW4xfVYl76o37vN6cyikgE/gi2Kt57Zx0Hv1J29VQ2ZzkvA/67xD6PpU6tamVWqRxcpLzbxQ8/0GNMf9QM/wwWLQwsHZDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N7pxRavn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N7pxRavn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763529509; x=1795065509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zkc+53DcpKH9wdS4PWEt3+lElHa89+k0CfVROm7fMQU=;
  b=N7pxRavn/UqyIFapFb6O2MzoKofzRR4e8tj6+tFrfH7dLOOlmjAVHE7r
   6oYYYPWuZW9pOIHiBOAKJJGPWsHv+5E/xajGPidBiS+DyqqRL0g7eKp3e
   Fw+L0clO9uZTsZzHlnd/ov95bOVHEp1N/pebYCiSeyNu3rLskFUaZF+4M
   Q4ysF3b0BMu4yviqTSqcCfl+Ej17RSzYUujSDlsPH1TwcBtecJjH5bKzZ
   gXqWgLch3+jDSnxrfzRe09yLiCbrw9JthCbCky+L03fizkP0cINfxfCIM
   4apscMEB0i1g16En5T/+z7PISYQBTo+aLjXDjN3g3F79NbWBoxV2yOKWq
   w==;
X-CSE-ConnectionGUID: Oz0jRS6XS+iBp518UCCKkg==
X-CSE-MsgGUID: TEZcviPiRBC/dNZ1GtOQIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65604697"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65604697"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 21:18:28 -0800
X-CSE-ConnectionGUID: eo7sK78OQxWGyL+1cWfZhA==
X-CSE-MsgGUID: wWJo4y3xTlKsnFx/mHJUzg==
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 21:18:27 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/vt-d: Set INTEL_IOMMU_FLOPPY_WA depend on BLK_DEV_FD
Date: Wed, 19 Nov 2025 13:16:12 +0800
Message-ID: <20251119051613.2604261-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119051613.2604261-1-baolu.lu@linux.intel.com>
References: <20251119051613.2604261-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>

INTEL_IOMMU_FLOPPY_WA workaround was introduced to create direct mappings
for first 16MB for floppy devices as the floppy drivers were not using
dma apis. We need not do this direct map if floppy driver is not
enabled.

INTEL_IOMMU_FLOPPY_WA is generally not a good idea. Iommu will be
mapping pages in this address range while kernel would also be
allocating from this range(mostly on memory stress). A misbehaving
device using this domain will have access to the pages that the
kernel might be actively using. We noticed this while running a test
that was trying to figure out if any pages used by kernel is in iommu
page tables.

This patch reduces the scope of the above issue by disabling the
workaround when floppy driver is not enabled. But we would still need to
fix the floppy driver to use dma apis so that we need not do direct map
without reserving the pages. Or the other option is to reserve this
memory range in firmware so that kernel will not use the pages.

Fixes: d850c2ee5fe2 ("iommu/vt-d: Expose ISA direct mapping region via iommu_get_resv_regions")
Fixes: 49a0429e53f2 ("Intel IOMMU: Iommu floppy workaround")
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Link: https://lore.kernel.org/r/20251002161625.1155133-1-vineeth@bitbyteword.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index f2f538c70650..17a91f881b2e 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -66,7 +66,7 @@ config INTEL_IOMMU_DEFAULT_ON
 
 config INTEL_IOMMU_FLOPPY_WA
 	def_bool y
-	depends on X86
+	depends on X86 && BLK_DEV_FD
 	help
 	  Floppy disk drivers are known to bypass DMA API calls
 	  thereby failing to work when IOMMU is enabled. This
-- 
2.43.0

