Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E98C433FE
	for <iommu@archiver.kernel.org>; Sun, 10 Apr 2022 10:27:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BECFB4047D;
	Sun, 10 Apr 2022 10:27:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W1_79tuYP66e; Sun, 10 Apr 2022 10:27:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 942E840491;
	Sun, 10 Apr 2022 10:27:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FD87C0084;
	Sun, 10 Apr 2022 10:27:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CAB52C002C
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A98354175D
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tkyf0Bs6Ukc5 for <iommu@lists.linux-foundation.org>;
 Sun, 10 Apr 2022 10:27:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C4F1417DA
 for <iommu@lists.linux-foundation.org>; Sun, 10 Apr 2022 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649586466; x=1681122466;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LBTukToFqW26M3LPZNT+iWr0f/beL6755SjAv9KaxvQ=;
 b=LFdReoPPrfXzwWdvJK/hUcG/KxFRjICHlfPg1rCLHRM4BaAieXjk20Fk
 +osM/OlMpI2AlJzEoCBI7S91YHB2IH4OnUmy2p1/Ilw5d3gOlvJZtXy7f
 gljn+7S/3KqmzL0EqA+bIyxon4xbeHA1ZDwz9B/gkMe2gwFRuk3XPGyDh
 be2F9nLeE3pl6esRKeRDPACF7DKIMKJ/AEZpQlyYlDCc36GMMp4EFj5AP
 IauiEsczTwjR0nYOutp/0IcHiLFrcXr+SfMqi9Um80NHuDaxoz7wa/C2K
 +cphVHg1smkxXKLkQaGxr221JBUIqo/+Pc7ryyycrbLy/aAhmoWyooJzB A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="249238501"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="249238501"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2022 03:27:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; d="scan'208";a="699019649"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:42 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC v3 10/12] iommu: Prepare IOMMU domain for IOPF
Date: Sun, 10 Apr 2022 18:24:41 +0800
Message-Id: <20220410102443.294128-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410102443.294128-1-baolu.lu@linux.intel.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This adds some mechanisms around the iommu_domain so that the I/O page
fault handling framework could route a page fault to the domain and
call the fault handler from it.

It includes:

- A reference counter for the iommu domain. The page fault handler is
  a different context from the bind()/unbind() thread. A reference
  counter is added to struct iommu_domain so that the life cycle of
  the iommu_domain could be synced between different threads.

- A pointer to the page fault handler and its private data. The fault
  handler will be called with the private data as a parameter once a
  page fault is routed to the domain. Any kernel component which owns
  an iommu domain could install handler and its parameter so that the
  page fault could be further routed or handled.

This also prepares the SVA implementation to be the first consumer of
the per-domain page fault handling model.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         | 19 ++++++++++
 drivers/iommu/iommu-sva-lib.c | 68 ++++++++++++++++++++++++++++++++++-
 drivers/iommu/iommu.c         | 29 +++++++++++++++
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 57650b773f3f..e23ec718515d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -51,6 +51,8 @@ struct iommu_sva_ioas;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
+typedef enum iommu_page_response_code (*iommu_domain_iopf_handler_t)
+			(struct iommu_fault *, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -102,6 +104,9 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
 	struct iommu_sva_ioas *sva_ioas;
+	iommu_domain_iopf_handler_t iopf_handler;
+	void *fault_data;
+	refcount_t async_users;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -680,6 +685,14 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid);
+
+static inline void iommu_domain_put_async(struct iommu_domain *domain)
+{
+	if (refcount_dec_and_test(&domain->async_users))
+		iommu_domain_free(domain);
+}
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1044,6 +1057,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
 					     struct device *dev, ioasid_t pasid)
 {
 }
+
+static inline struct iommu_domain *
+iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_SVA
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 8df39893726f..1206423acc12 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -138,6 +138,69 @@ void iommu_sva_ioas_put(struct iommu_sva_ioas *ioas)
 	}
 }
 
+/*
+ * I/O page fault handler for SVA
+ *
+ * Copied from io-pgfault.c with mmget_not_zero() added before
+ * mmap_read_lock().
+ */
+static enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+{
+	vm_fault_t ret;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned int access_flags = 0;
+	struct iommu_domain *domain = data;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_page_request *prm = &fault->prm;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
+
+	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
+		return status;
+
+	mm = iommu_sva_domain_mm(domain);
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
+
 /*
  * IOMMU SVA driver-oriented interfaces
  */
@@ -157,6 +220,9 @@ iommu_sva_alloc_domain(struct device *dev, struct iommu_sva_ioas *ioas)
 	/* The caller must hold a reference to ioas. */
 	domain->sva_ioas = ioas;
 	domain->type = IOMMU_DOMAIN_SVA;
+	domain->iopf_handler = iommu_sva_handle_iopf;
+	domain->fault_data = domain;
+	refcount_set(&domain->async_users, 1);
 
 	return domain;
 }
@@ -271,7 +337,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	if (refcount_dec_and_test(&handle->users)) {
 		list_del(&handle->node);
 		iommu_detach_device_pasid(domain, dev, ioas->pasid);
-		iommu_domain_free(domain);
+		iommu_domain_put_async(domain);
 		kfree(handle);
 	}
 	mutex_unlock(&iommu_sva_lock);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1c4db9148608..ba9a687490c9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3173,3 +3173,32 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 
 	iommu_group_put(group);
 }
+
+/*
+ * Get the attached domain for asynchronous usage, for example the I/O
+ * page fault handling framework. The caller get a reference counter
+ * of the domain automatically on a successful return and should put
+ * it with iommu_domain_put() after usage.
+ */
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+
+	if (!pasid_valid(pasid))
+		return NULL;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return NULL;
+
+	mutex_lock(&group->mutex);
+	domain = xa_load(&group->pasid_array, pasid);
+	if (domain)
+		refcount_inc(&domain->async_users);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return domain;
+}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
