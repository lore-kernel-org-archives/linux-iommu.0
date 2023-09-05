Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A928D190
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693872597; x=1725408597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/dTUhYfeM2klMNq88hQ3YcjdcaNnjWoTfjR9d0kJiac=;
  b=g5D7ps1sk0ZoXoc0IiADbY3lZNJkoM0hf2E4P/xyPvDPAlary/rVRIfF
   H1+mvzgGG6OkhDwL2Lr8QWx3DOXAHowoe7dSdQjx5ECYKUnGkIoZFHvxc
   Yi3TNIGPh56jTU+xZADSCpZlxaniGhiOgMYzpx7TIhCmtaX+ksQrQBE1N
   UkagXm0Wmfj2T4ss9A9OMXde2ZrXQp1Od7p65dW3ZcB3HZaDjUo8rrQLy
   3bvgnxDpUdqxKy6q6QZvCnTYfEiX4H6OuUitVFOvlOhqAETW1MqedzXiL
   EUReLIm02WxuRXlRUdyXWWHUaG2LkoEoRCGbK5OIpKrcC2hinLAI608yD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="463039958"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="463039958"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 17:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="884125109"
X-IronPort-AV: E=Sophos;i="6.02,227,1688454000"; 
   d="scan'208";a="884125109"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2023 17:09:48 -0700
From: Tina Zhang <tina.zhang@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: Michael Shavit <mshavit@google.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v3 1/6] iommu: Add mm_get_enqcmd_pasid() helper function
Date: Tue,  5 Sep 2023 08:09:25 +0800
Message-Id: <20230905000930.24515-2-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230905000930.24515-1-tina.zhang@intel.com>
References: <20230905000930.24515-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

mm_get_enqcmd_pasid() is for getting enqcmd pasid value.

The motivation is to replace mm->pasid with an iommu private data
structure that is introduced in a later patch.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---

Changes in v2:
- Change mm_get_pasid() to mm_get_enqcmd_pasid()

 arch/x86/kernel/traps.c | 2 +-
 include/linux/iommu.h   | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4a817d20ce3b..d9034b1bbfdd 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -678,7 +678,7 @@ static bool try_fixup_enqcmd_gp(void)
 	if (!mm_valid_pasid(current->mm))
 		return false;
 
-	pasid = current->mm->pasid;
+	pasid = mm_get_enqcmd_pasid(current->mm);
 
 	/*
 	 * Did this thread already have its PASID activated?
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d31642596675..ab9919746fd3 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1180,6 +1180,10 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
 {
 	return mm->pasid != IOMMU_PASID_INVALID;
 }
+static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
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
+static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
+{
+	return IOMMU_PASID_INVALID;
+}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
 
-- 
2.17.1

