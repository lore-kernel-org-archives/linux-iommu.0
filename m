Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCC1FD6
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 07:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691481000; x=1723017000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=A507Xs1crKDCNKJRmv5uCTlfgOCIAdl3cBwBkuALTds=;
  b=j21pHWPq8NXvuBc5th1FSLH5NQeYgY8mQViRP5V211bA8f286MZMETlq
   GYutjCqQiixff/s6feaAFmSUVG2XHtWds07z0kbbC2+ZZoeVPUq4o1phw
   59LvValt+j0QPFSFPwOgqHstvq2d/9Ldvyv0y1yijbvLoyUyRUwb2f4Yy
   oNf7Tan5MoOIjz/PbClESUICQqcBg7dl/YILm6xDggFfr4i6d9JyYWQYc
   eWOoniAxuoXvg+NYXlQ8I8XIvzT5aJgGQEj5F5u0LkbDya/8WoxYlh865
   7fInsnC2mug9WhNgJpBW7JO1WYK9heRYDoVrFnGmnFi7FM36BaDTF0raF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437078658"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437078658"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 00:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681146272"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="681146272"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.156.126])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 00:49:51 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 1/5] iommu: Add mm_get_pasid() helper function
Date: Tue,  8 Aug 2023 15:49:40 +0800
Message-Id: <20230808074944.7825-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230808074944.7825-1-tina.zhang@intel.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

mm_get_pasid() is for getting mm pasid value.

The motivation is to replace mm->pasid with an iommu private data
structure that is introduced in a later patch.

Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 arch/x86/kernel/traps.c | 2 +-
 include/linux/iommu.h   | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4a817d20ce3b..6e259b11cd87 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -678,7 +678,7 @@ static bool try_fixup_enqcmd_gp(void)
 	if (!mm_valid_pasid(current->mm))
 		return false;
 
-	pasid = current->mm->pasid;
+	pasid = mm_get_pasid(current->mm);
 
 	/*
 	 * Did this thread already have its PASID activated?
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d31642596675..30e4d1ca39b5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1180,6 +1180,10 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
 	return mm->pasid != IOMMU_PASID_INVALID;
 }
+static inline u32 mm_get_pasid(struct mm_struct *mm)
+{
+	return mm->pasid;
+}
 void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
@@ -1202,6 +1206,10 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 static inline void mm_pasid_init(struct mm_struct *mm) {}
 static inline bool mm_valid_pasid(struct mm_struct *mm) { return false; }
+static inline u32 mm_get_pasid(struct mm_struct *mm)
+{
+	return IOMMU_PASID_INVALID;
+}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
 
-- 
2.17.1

