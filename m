Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9672F50
	for <iommu@lists.linux.dev>; Mon, 26 Sep 2022 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664198499; x=1695734499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xLujIRTj17nrnMKvg1CiEngbHNEpsa7tZnJMoZQG/+Y=;
  b=BbkoGVOUy2o+26DXrOLJcXD//OXb9AqB9WHfWxNytcFFzjCShs6V3RJS
   pxBPmQcNH/KataDEcAgrhhfqga56uD0+Tb5cDleABZHoFQKexTrJu4YCh
   DV9wkvg1d+w3FMCk/wma1r0Y9LFNei43JjjLabvC9bnrUYAMynHincJ+1
   pN5bu3Zts5XLMl4e/CqMoC+R3pDdh/chdpGVry/WfvWd59E+0dKKi94eY
   0RXn9L8F45c5EfUY6Vn4dpqayHVm8lM/K2rJwAGPyHu/x9LX1aLKPuS9X
   97lZ2jJDY7I+3EZUkKbyBaoFPPjsOaKrojn/q0UdrFxzQsqDDnh4Z22Lq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="288162558"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="288162558"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="683525686"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="683525686"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2022 06:21:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] iommu/vt-d: Avoid unnecessary global DMA cache invalidation
Date: Mon, 26 Sep 2022 21:15:29 +0800
Message-Id: <20220926131529.4045281-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
References: <20220926131529.4045281-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some VT-d hardware implementations invalidate all DMA remapping hardware
translation caches as part of SRTP flow. The VT-d spec adds a ESRTPS
(Enhanced Set Root Table Pointer Support, section 11.4.2 in VT-d spec)
capability bit to indicate this. With this bit set, software has no need
to issue the global invalidation request.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220919062523.3438951-3-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.h | 1 +
 drivers/iommu/intel/iommu.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index bddf6c69587d..92023dff9513 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -146,6 +146,7 @@
 /*
  * Decoding Capability Register
  */
+#define cap_esrtps(c)		(((c) >> 63) & 1)
 #define cap_esirtps(c)		(((c) >> 62) & 1)
 #define cap_fl5lp_support(c)	(((c) >> 60) & 1)
 #define cap_pi_support(c)	(((c) >> 59) & 1)
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7410d6232cbb..2d142ee7bbfa 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1239,6 +1239,13 @@ static void iommu_set_root_entry(struct intel_iommu *iommu)
 
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 
+	/*
+	 * Hardware invalidates all DMA remapping hardware translation
+	 * caches as part of SRTP flow.
+	 */
+	if (cap_esrtps(iommu->cap))
+		return;
+
 	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
 	if (sm_supported(iommu))
 		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
-- 
2.34.1

