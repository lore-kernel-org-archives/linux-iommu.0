Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E489615B0
	for <iommu@lists.linux.dev>; Fri, 23 Sep 2022 00:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663894091; x=1695430091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjQtsc1TPF/QLcdDDuHGmW2FVH4+p2Iqv7hrj01LmOw=;
  b=LQYNHNnnt7QgDHbK3+kw9/rzlsgE171wuENVbtnSLJOJayJVdk1T4qTc
   gxQT3vUt6+M6qvrWL3Jz4cj5SWMe8z/lzFdJ8WW7bw5U+jkkL/Aw6fLfo
   K4Je67kIaRQRZ5nlRz0BV68oRvrhs4prig09gOMy3VRyrsRC3caKuRgAU
   DU7ABWy0t1gFvEkgu5hrH9sJdK4ajQCl+Kt4XVOK+r3NfmTc0veCPD5Dv
   clrFxYNW6EYbdz9KCKFn2CTr9PzMCFjqPbG3HtV293a9I1+5vxj75dAk1
   FGKsCjz4gc59jKHbRIUKV4pLwFHFXqsay39yqxc6TR4pg4FZ7aE/j9+pu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="362278885"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="362278885"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 17:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="650760011"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga008.jf.intel.com with ESMTP; 22 Sep 2022 17:48:10 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] iommu/vt-d: Avoid unnecessary global DMA cache invalidation
Date: Fri, 23 Sep 2022 08:42:06 +0800
Message-Id: <20220923004206.3630441-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
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
index 81a449b5cb91..a8b36c3fddf1 100644
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

