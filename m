Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527BCD51E
	for <iommu@lists.linux.dev>; Wed,  1 Mar 2023 23:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677714829; x=1709250829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmchmeFQuGlSdMLx91I/F0FSRiJuQKOQ2C+PJU8/67A=;
  b=agMKKtJhJym/gHekpV0Sj5Ug8GNJ0Prbc+FcRS27DxX9VWWjYDndJbvb
   Xt/VFFJ/dz9LmaZned3j5nORraQy21CJMfxj610EQlJes25Y6FdkZ6PmA
   RE9gJHK5pJKkbTQUrwycvq6h/tbYylzaz1MuoxZOwwg/8pcVsvE1e0PPB
   F3x8upSoGRHGzrnROycPBbG1VeEDLWIgmvWmBzhiaGxgfTSETLlCIysGR
   9OZTAsoiuDh5264bPBu10TVzJ/U6vH34OETHBxXQwJwnxCxyUYzJMkyRd
   QpRAzrWlQDvPMUrOVxJOlqwJbsfDUY46T4+kHySeXmhq3DBfSWdpcZSKE
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="397127645"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="397127645"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 15:53:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003880324"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="1003880324"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 15:53:01 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	X86 Kernel <x86@kernel.org>,
	bp@alien8.de,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	corbet@lwn.net,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: "Robin Murphy" <robin.murphy@arm.com>,
	"Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 2/6] iommu/sva: Move PASID helpers to sva code
Date: Wed,  1 Mar 2023 15:56:42 -0800
Message-Id: <20230301235646.2692846-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparing to remove IOASID infrastructure, PASID management will be
under SVA code. Decouple mm code from IOASID. Use iommu-help.h instead
of iommu.h to prevent circular inclusion.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v4: (Jason's comments)
	- delete and open code mm_set_pasid
	- keep mm_init_pasid() as inline for fork performance
---
 drivers/iommu/iommu-sva.c    | 10 +++++++++-
 include/linux/ioasid.h       |  2 +-
 include/linux/iommu-helper.h |  1 +
 include/linux/sched/mm.h     | 18 ++----------------
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..376b2a9e2543 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -44,7 +44,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	if (!pasid_valid(pasid))
 		ret = -ENOMEM;
 	else
-		mm_pasid_set(mm, pasid);
+		mm->pasid = ret;
 out:
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
@@ -238,3 +238,11 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 
 	return status;
 }
+
+void mm_pasid_drop(struct mm_struct *mm)
+{
+	if (pasid_valid(mm->pasid)) {
+		ioasid_free(mm->pasid);
+		mm->pasid = INVALID_IOASID;
+	}
+}
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index af1c9d62e642..2c502e77ee78 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -4,8 +4,8 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/iommu-helper.h>
 
-#define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
diff --git a/include/linux/iommu-helper.h b/include/linux/iommu-helper.h
index 74be34f3a20a..0aa922f6bfad 100644
--- a/include/linux/iommu-helper.h
+++ b/include/linux/iommu-helper.h
@@ -40,5 +40,6 @@ static inline unsigned long iommu_num_pages(unsigned long addr,
 
 	return DIV_ROUND_UP(size, io_page_size);
 }
+#define INVALID_IOASID	(-1U)
 
 #endif
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..ae5a3f16b321 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,7 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
-#include <linux/ioasid.h>
+#include <linux/iommu-helper.h>
 
 /*
  * Routines for handling mm_structs
@@ -456,23 +456,9 @@ static inline void mm_pasid_init(struct mm_struct *mm)
 {
 	mm->pasid = INVALID_IOASID;
 }
-
-/* Associate a PASID with an mm_struct: */
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid)
-{
-	mm->pasid = pasid;
-}
-
-static inline void mm_pasid_drop(struct mm_struct *mm)
-{
-	if (pasid_valid(mm->pasid)) {
-		ioasid_free(mm->pasid);
-		mm->pasid = INVALID_IOASID;
-	}
-}
+void mm_pasid_drop(struct mm_struct *mm);
 #else
 static inline void mm_pasid_init(struct mm_struct *mm) {}
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
 static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif
 
-- 
2.25.1

