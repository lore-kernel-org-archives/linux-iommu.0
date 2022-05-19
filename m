Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A64AC433EF
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 07:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48FB1843F8;
	Thu, 19 May 2022 07:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpI9ifBiDc3M; Thu, 19 May 2022 07:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1A1D883FA0;
	Thu, 19 May 2022 07:24:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1065C0032;
	Thu, 19 May 2022 07:24:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C8E6C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 07:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A5114091F
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 07:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JGqI45bnxHfA for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 07:24:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B91624091A
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 07:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652945094; x=1684481094;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZhVJrH8ZIL7/etGs0byavRR7lBKr0I4+Mu5OuvDVjHU=;
 b=aAm41nF9JHFK2ktzz2Ch3GpRjs/olGHuVLFXW2hPV3E8F9wzaaKjILId
 3oMWRspiF3X9FJXmvMdA9BCd1A6QF1hC6nkmerZwJoVv4rdVPdhIModn5
 YVUxfF8nXK/tSEMJShTexHPoUsGMfmCr35dCKCEBIc7udb41DfpnpTU11
 YTWtfA3QwoOPF2KGAthE88TBP7JmPiDh5321t3DmioqlmLw4FckRBQP3a
 bEY0VQdl8M9P92j/2Ljxr6bOciO0mjqWQFk8QuM0U359qLXVKAKjNVWTf
 ld/5UGjAQsPEsvlwWjzVLI3fdwnWbL0mvy2SQmjem7uvmaZ8x337W5k3E g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="335113280"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; d="scan'208";a="335113280"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2022 00:24:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; d="scan'208";a="714853169"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 19 May 2022 00:24:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v7 09/10] iommu: Per-domain I/O page fault handling
Date: Thu, 19 May 2022 15:20:46 +0800
Message-Id: <20220519072047.2996983-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

Tweak the I/O page fault handling framework to route the page faults to
the domain and call the page fault handler retrieved from the domain.
This makes the I/O page fault handling framework possible to serve more
usage scenarios as long as they have an IOMMU domain and install a page
fault handler in it. Some unused functions are also removed to avoid
dead code.

The iommu_get_domain_for_dev_pasid() which retrieves attached domain
for a {device, PASID} pair is used. It will be used by the page fault
handling framework which knows {device, PASID} reported from the iommu
driver. We have a guarantee that the SVA domain doesn't go away during
IOPF handling, because unbind() waits for pending faults with
iopf_queue_flush_dev() before freeing the domain. Hence, there's no need
to synchronize life cycle of the iommu domains between the unbind() and
the interrupt threads.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/io-pgfault.c | 64 +++++---------------------------------
 1 file changed, 7 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index aee9e033012f..4f24ec703479 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -69,69 +69,18 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
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
+	struct iommu_domain *domain;
 	struct iopf_fault *iopf, *next;
 	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
 
 	group = container_of(work, struct iopf_group, work);
+	domain = iommu_get_domain_for_dev_pasid(group->dev,
+				group->last_fault.fault.prm.pasid);
+	if (!domain || !domain->iopf_handler)
+		status = IOMMU_PAGE_RESP_INVALID;
 
 	list_for_each_entry_safe(iopf, next, &group->faults, list) {
 		/*
@@ -139,7 +88,8 @@ static void iopf_handle_group(struct work_struct *work)
 		 * faults in the group if there is an error.
 		 */
 		if (status == IOMMU_PAGE_RESP_SUCCESS)
-			status = iopf_handle_single(iopf);
+			status = domain->iopf_handler(&iopf->fault,
+						      domain->fault_data);
 
 		if (!(iopf->fault.prm.flags &
 		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
