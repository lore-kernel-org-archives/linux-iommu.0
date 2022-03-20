Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C75E0C433F5
	for <iommu@archiver.kernel.org>; Sun, 20 Mar 2022 06:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85E1340198;
	Sun, 20 Mar 2022 06:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aPWPy8aC-Hq2; Sun, 20 Mar 2022 06:43:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 427154013A;
	Sun, 20 Mar 2022 06:43:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D0BFC001A;
	Sun, 20 Mar 2022 06:43:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F362C000B
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 710644016B
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3bGAUk_g0ddN for <iommu@lists.linux-foundation.org>;
 Sun, 20 Mar 2022 06:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C25424013A
 for <iommu@lists.linux-foundation.org>; Sun, 20 Mar 2022 06:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647758594; x=1679294594;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+ksKtDMEEtaLT6vJgCE98Ji13pfwwUwPpsgVxnykxKA=;
 b=CFZRW0IVEOx0D9yBOD9ai+VsHzQURtLKCrXudYwBH77JkZbcG7UoILT6
 G/vL69AT5nvVNaZJZ9l8oYeUUPntPaIDdhiz+KQNwG5cxKzHyetQmSA96
 QkHITS8GLJrzDDU5ndobNsdzzX7ObkZphJIMPyhLZzNdhUh0vTQTneO7g
 2IV8R4/CGYF7hcfS8XJhMQ6khVI6SMxwK3ofVG3lmIJwyF8916s4DosO+
 P7gxzXI0qzAuH1UliZEEqS8oeEoap4yJYkDOFPruFUsrx0HtMZ7Kcd2P9
 tpfldK7u37XSTt3O+ckYTpTws5SCkPILBkpeujHa7SFJZMnCbJsmhPx/b A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="237961425"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="237961425"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2022 23:43:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; d="scan'208";a="691839978"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:43:11 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Date: Sun, 20 Mar 2022 14:40:29 +0800
Message-Id: <20220320064030.2936936-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
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

The existing IOPF handling framework only handles the I/O page faults for
SVA. Ginven that we are able to link iommu domain with each I/O page fault,
we can now make the I/O page fault handling framework more general for
more types of page faults.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         |  4 +++
 drivers/iommu/io-pgfault.c    | 67 ++++++-----------------------------
 drivers/iommu/iommu-sva-lib.c | 59 ++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 57 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 803e7b07605e..11c65a7bed88 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -50,6 +50,8 @@ struct iommu_dma_cookie;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
+typedef enum iommu_page_response_code (*iommu_domain_iopf_handler_t)
+			(struct iommu_fault *, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -101,6 +103,8 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
 	struct mm_struct *sva_cookie;
+	iommu_domain_iopf_handler_t fault_handler;
+	void *fault_data;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 1df8c1dcae77..dad0e40cd8d2 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -69,62 +69,6 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
 	return iommu_page_response(dev, &resp);
 }
 
-static enum iommu_page_response_code
-iopf_handle_single(struct iopf_fault *iopf)
-{
-	vm_fault_t ret;
-	struct mm_struct *mm;
-	struct vm_area_struct *vma;
-	unsigned int access_flags = 0;
-	unsigned int fault_flags = FAULT_FLAG_REMOTE;
-	struct iommu_fault_page_request *prm = &iopf->fault.prm;
-	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
-
-	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
-		return status;
-
-	mm = iommu_sva_find(prm->pasid);
-	if (IS_ERR_OR_NULL(mm))
-		return status;
-
-	mmap_read_lock(mm);
-
-	vma = find_extend_vma(mm, prm->addr);
-	if (!vma)
-		/* Unmapped area */
-		goto out_put_mm;
-
-	if (prm->perm & IOMMU_FAULT_PERM_READ)
-		access_flags |= VM_READ;
-
-	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
-		access_flags |= VM_WRITE;
-		fault_flags |= FAULT_FLAG_WRITE;
-	}
-
-	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
-		access_flags |= VM_EXEC;
-		fault_flags |= FAULT_FLAG_INSTRUCTION;
-	}
-
-	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
-		fault_flags |= FAULT_FLAG_USER;
-
-	if (access_flags & ~vma->vm_flags)
-		/* Access fault */
-		goto out_put_mm;
-
-	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
-	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
-		IOMMU_PAGE_RESP_SUCCESS;
-
-out_put_mm:
-	mmap_read_unlock(mm);
-	mmput(mm);
-
-	return status;
-}
-
 static void iopf_handle_group(struct work_struct *work)
 {
 	struct iopf_group *group;
@@ -134,12 +78,21 @@ static void iopf_handle_group(struct work_struct *work)
 	group = container_of(work, struct iopf_group, work);
 
 	list_for_each_entry_safe(iopf, next, &group->faults, list) {
+		struct iommu_domain *domain;
+
+		domain = iommu_get_domain_for_dev_pasid(group->dev,
+							iopf->fault.prm.pasid);
+
+		if (!domain || !domain->fault_handler)
+			status = IOMMU_PAGE_RESP_INVALID;
+
 		/*
 		 * For the moment, errors are sticky: don't handle subsequent
 		 * faults in the group if there is an error.
 		 */
 		if (status == IOMMU_PAGE_RESP_SUCCESS)
-			status = iopf_handle_single(iopf);
+			status = domain->fault_handler(&iopf->fault,
+						       domain->fault_data);
 
 		if (!(iopf->fault.prm.flags &
 		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 47cf98e661ff..01fa8096bd02 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -87,6 +87,63 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev)
 	return domain;
 }
 
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
+	mm = domain->sva_cookie;
+	if (IS_ERR_OR_NULL(mm))
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
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
@@ -124,6 +181,8 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
 		goto out;
 	}
 	domain->sva_cookie = mm;
+	domain->fault_handler = iommu_sva_handle_iopf;
+	domain->fault_data = domain;
 
 	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
 	if (ret)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
