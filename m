Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0B2F37
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 20:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679515455; x=1711051455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKVfWMpIPWoiZ/aB8Wo2J/u99AjpxombAxUewYxaeoQ=;
  b=kWZ9FQ912pOojHWP85+p3QFc8v7vPLmdNMLQKHKmNCSNkKQa54JNqQvs
   c69M71DBw+gh8/jn8GPIVL4K5lrMobKbmAooD80ZDr47MK3Dn4HxuVIuu
   T9l26NiwlSnK0/JKDgSCVfuBUOLheGyPXwhxZZ4fvw9BVipvz0RjNw0GF
   ls6HL/3NesfAvTv9aKoQy9aTYoCUQK4bK9kxtKdJhDyz/NJyI+d+mI2Vj
   8xRBiYUYZn39YU+rwoyfGHeOXVZaWBz93k+Uvu/kLvnOwFCXLY1C8i+F9
   /RP9NvJuV1ZrqEeTle5EvI8iXNTapK60n82t0qGO4KCxvaZaA3njjTOxd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="339356807"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="339356807"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 13:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="682039328"
X-IronPort-AV: E=Sophos;i="5.98,282,1673942400"; 
   d="scan'208";a="682039328"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.39.106])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2023 13:04:04 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	"Lu Baolu" <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	"Robin Murphy" <robin.murphy@arm.com>,
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
Cc: "Will Deacon" <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Kirill Shutemov <kirill.shutemov@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 2/7] iommu/sva: Move PASID helpers to sva code
Date: Wed, 22 Mar 2023 13:07:58 -0700
Message-Id: <20230322200803.869130-3-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
References: <20230322200803.869130-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparing to remove IOASID infrastructure, PASID management will be
under SVA code. Decouple mm code from IOASID.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v8:
	-remove dummy inline pasid_valid() and #ifdef CONFIG_IOMMU_SVA
v7:
	- use CONFIG_IOMMU_SVA around PASID helpers in fork.c, Fixes a
	compile problem.
v6:
	- put helpers under iommu.h instead of iommu-helper.h
v5:
	- move definition of helpers to iommu code to be consistent with
	  declarations. (Kevin)
	- fix patch partitioning bug (Baolu)
v4:
	- delete and open code mm_set_pasid
	- keep mm_init_pasid() as inline for fork performance
---
 drivers/iommu/iommu-sva.c | 10 +++++++++-
 include/linux/ioasid.h    | 11 +----------
 include/linux/iommu.h     | 14 +++++++++++++-
 include/linux/sched/mm.h  | 26 --------------------------
 kernel/fork.c             |  1 +
 5 files changed, 24 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 24bf9b2b58aa..fcfdc80a3939 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -44,7 +44,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	if (!pasid_valid(pasid))
 		ret = -ENOMEM;
 	else
-		mm_pasid_set(mm, pasid);
+		mm->pasid = pasid;
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
index af1c9d62e642..734bf0e036ee 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -4,8 +4,8 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/iommu.h>
 
-#define INVALID_IOASID ((ioasid_t)-1)
 typedef unsigned int ioasid_t;
 typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max, void *data);
 typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void *data);
@@ -40,10 +40,6 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return ioasid != INVALID_IOASID;
-}
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -74,10 +70,5 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
-static inline bool pasid_valid(ioasid_t ioasid)
-{
-	return false;
-}
-
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6595454d4f48..d3f81dc6e4dd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -13,7 +13,6 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <linux/ioasid.h>
 #include <uapi/linux/iommu.h>
 
 #define IOMMU_READ	(1 << 0)
@@ -192,6 +191,8 @@ enum iommu_dev_features {
 };
 
 #define IOMMU_PASID_INVALID	(-1U)
+typedef unsigned int ioasid_t;
+#define INVALID_IOASID ((ioasid_t)-1)
 
 #ifdef CONFIG_IOMMU_API
 
@@ -1172,7 +1173,16 @@ static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream
 	return false;
 }
 
+static inline bool pasid_valid(ioasid_t ioasid)
+{
+	return ioasid != INVALID_IOASID;
+}
 #ifdef CONFIG_IOMMU_SVA
+static inline void mm_pasid_init(struct mm_struct *mm)
+{
+	mm->pasid = INVALID_IOASID;
+}
+void mm_pasid_drop(struct mm_struct *mm);
 struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 					struct mm_struct *mm);
 void iommu_sva_unbind_device(struct iommu_sva *handle);
@@ -1192,6 +1202,8 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 {
 	return IOMMU_PASID_INVALID;
 }
+static inline void mm_pasid_init(struct mm_struct *mm) {}
+static inline void mm_pasid_drop(struct mm_struct *mm) {}
 #endif /* CONFIG_IOMMU_SVA */
 
 #endif /* __LINUX_IOMMU_H */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2a243616f222..da9712a3ba73 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,7 +8,6 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
-#include <linux/ioasid.h>
 
 /*
  * Routines for handling mm_structs
@@ -451,29 +450,4 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
 }
 #endif
 
-#ifdef CONFIG_IOMMU_SVA
-static inline void mm_pasid_init(struct mm_struct *mm)
-{
-	mm->pasid = INVALID_IOASID;
-}
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
-#else
-static inline void mm_pasid_init(struct mm_struct *mm) {}
-static inline void mm_pasid_set(struct mm_struct *mm, u32 pasid) {}
-static inline void mm_pasid_drop(struct mm_struct *mm) {}
-#endif
-
 #endif /* _LINUX_SCHED_MM_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index f68954d05e89..a0ea68a2bd19 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
 #include <linux/stackprotector.h>
+#include <linux/iommu.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
-- 
2.25.1

