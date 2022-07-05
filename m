Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24DB7C
	for <iommu@lists.linux.dev>; Tue,  5 Jul 2022 05:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656997946; x=1688533946;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OWwHhF07L7X9H3VNJvCd6Ts1+Ao5qc0bFPamGJaYSpE=;
  b=avHG/pzfn2+Zs6MOf19oVya5lIs2sEwReYXaLEs0ofNKAJ2AU9PvGQNt
   ioSnly/sobLeuLHo+Fr33RkR11FbUQ9K25gBl5cdI5PbR8TZn33aqm8Jp
   3JSQnbWlw5kLRIwE6kP0X+iLd9hTCMCyV2DmNywMves7oX5QbpDuNtmoi
   sHwwCqPK96OUP6mEBDIVPPei9HK6FjghnzM3NnP6fIPKZcP8LDVwiggEj
   fCUEAz3EX8ep4nf0IvPIFqPAnIfRS5exxlHibaheu+KeH1RVtI975nGxu
   pqnXV0t+wjnSfW58IYvm7e/JBfaA1VpxZX4pjvVrOygjV7nBHXtYNvT3G
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263046170"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263046170"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 22:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="542807605"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 22:12:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: Eric Auger <eric.auger@redhat.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhu Tony <tony.zhu@intel.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v10 10/12] iommu: Prepare IOMMU domain for IOPF
Date: Tue,  5 Jul 2022 13:07:08 +0800
Message-Id: <20220705050710.2887204-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds some mechanisms around the iommu_domain so that the I/O page
fault handling framework could route a page fault to the domain and
call the fault handler from it.

Add pointers to the page fault handler and its private data in struct
iommu_domain. The fault handler will be called with the private data
as a parameter once a page fault is routed to the domain. Any kernel
component which owns an iommu domain could install handler and its
private parameter so that the page fault could be further routed and
handled.

This also prepares the SVA implementation to be the first consumer of
the per-domain page fault handling model. The I/O page fault handler
for SVA is copied to the SVA file with mmget_not_zero() added before
mmap_read_lock().

Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/iommu.h         |  3 ++
 drivers/iommu/iommu-sva-lib.h |  8 +++++
 drivers/iommu/io-pgfault.c    |  7 +++++
 drivers/iommu/iommu-sva-lib.c | 58 +++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |  4 +++
 5 files changed, 80 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ae0cfca064e6..47610f21d451 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -105,6 +105,9 @@ struct iommu_domain {
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
+						      void *data);
+	void *fault_data;
 	union {
 		struct {
 			iommu_fault_handler_t handler;
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 8909ea1094e3..1b3ace4b5863 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -26,6 +26,8 @@ int iopf_queue_flush_dev(struct device *dev);
 struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
+enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, void *data);
 
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
@@ -63,5 +65,11 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 {
 	return -ENODEV;
 }
+
+static inline enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+{
+	return IOMMU_PAGE_RESP_INVALID;
+}
 #endif /* CONFIG_IOMMU_SVA */
 #endif /* _IOMMU_SVA_LIB_H */
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 1df8c1dcae77..aee9e033012f 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -181,6 +181,13 @@ static void iopf_handle_group(struct work_struct *work)
  * request completes, outstanding faults will have been dealt with by the time
  * the PASID is freed.
  *
+ * Any valid page fault will be eventually routed to an iommu domain and the
+ * page fault handler installed there will get called. The users of this
+ * handling framework should guarantee that the iommu domain could only be
+ * freed after the device has stopped generating page faults (or the iommu
+ * hardware has been set to block the page faults) and the pending page faults
+ * have been flushed.
+ *
  * Return: 0 on success and <0 on error.
  */
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 751366980232..536d34855c74 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -167,3 +167,61 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 	return domain->mm->pasid;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
+
+/*
+ * I/O page fault handler for SVA
+ */
+enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+{
+	vm_fault_t ret;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = data;
+	unsigned int access_flags = 0;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_page_request *prm = &fault->prm;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
+
+	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
+		return status;
+
+	if (IS_ERR_OR_NULL(mm) || !mmget_not_zero(mm))
+		return status;
+
+	mmap_read_lock(mm);
+
+	vma = find_extend_vma(mm, prm->addr);
+	if (!vma)
+		/* Unmapped area */
+		goto out_put_mm;
+
+	if (prm->perm & IOMMU_FAULT_PERM_READ)
+		access_flags |= VM_READ;
+
+	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
+		fault_flags |= FAULT_FLAG_USER;
+
+	if (access_flags & ~vma->vm_flags)
+		/* Access fault */
+		goto out_put_mm;
+
+	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
+	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
+		IOMMU_PAGE_RESP_SUCCESS;
+
+out_put_mm:
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	return status;
+}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e1491eb3c7b6..c6e9c8e82771 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,6 +29,8 @@
 #include <trace/events/iommu.h>
 #include <linux/sched/mm.h>
 
+#include "iommu-sva-lib.h"
+
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
@@ -3199,6 +3201,8 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
 	domain->mm = mm;
+	domain->iopf_handler = iommu_sva_handle_iopf;
+	domain->fault_data = mm;
 
 	return domain;
 }
-- 
2.25.1

