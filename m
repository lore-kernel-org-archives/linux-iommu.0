Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865F7C2BB85
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655E82076A
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655E82076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F3CED20530;
	Wed, 15 Apr 2020 05:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F0U5blervAdW; Wed, 15 Apr 2020 05:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 15473204C9;
	Wed, 15 Apr 2020 05:29:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10A86C1D7D;
	Wed, 15 Apr 2020 05:29:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42267C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 31FCB844A5
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xWJWXNXFd2VT for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 05:29:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 31B94844B4
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:09 +0000 (UTC)
IronPort-SDR: yHKlU3BAeuh34kAas+t43zZ19lfLkjmEOCXkGQQGYMclroyQBFuEcViddTqZzRh4haRDlaQP2Z
 QcntKmQTPmVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 22:29:08 -0700
IronPort-SDR: lZptZbeLJ/ybw+uhzFCzSGbQufLCXiwkzbvL5IIHL/oGma7iYjzbDYC0b7xDqSTzZgKzXyn3WI
 FgLFgmwxdyaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; d="scan'208";a="277504213"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 22:29:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 4/7] iommu/vt-d: Refactor prq_event_thread()
Date: Wed, 15 Apr 2020 13:25:39 +0800
Message-Id: <20200415052542.30421-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415052542.30421-1-baolu.lu@linux.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Move the software processing page request descriptors part from
prq_event_thread() into a separated function. No any functional
changes.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-svm.c | 256 ++++++++++++++++++++------------------
 1 file changed, 135 insertions(+), 121 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 83dc4319f661..a1921b462783 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -722,142 +722,156 @@ static bool is_canonical_address(u64 addr)
 	return (((saddr << shift) >> shift) == saddr);
 }
 
-static irqreturn_t prq_event_thread(int irq, void *d)
+static void process_single_prq(struct intel_iommu *iommu,
+			       struct page_req_dsc *req)
 {
-	struct intel_iommu *iommu = d;
-	struct intel_svm *svm = NULL;
-	int head, tail, handled = 0;
-
-	/* Clear PPR bit before reading head/tail registers, to
-	 * ensure that we get a new interrupt if needed. */
-	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
-
-	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
-	while (head != tail) {
-		struct intel_svm_dev *sdev;
-		struct vm_area_struct *vma;
-		struct page_req_dsc *req;
-		struct qi_desc resp;
-		int result;
-		vm_fault_t ret;
-		u64 address;
-
-		handled = 1;
-
-		req = &iommu->prq[head / sizeof(*req)];
+	int result = QI_RESP_FAILURE;
+	struct intel_svm_dev *sdev;
+	struct vm_area_struct *vma;
+	struct intel_svm *svm;
+	struct qi_desc resp;
+	vm_fault_t ret;
+	u64 address;
+
+	address = (u64)req->addr << VTD_PAGE_SHIFT;
+	if (!req->pasid_present) {
+		pr_err("%s: Page request without PASID: %08llx %08llx\n",
+		       iommu->name, ((unsigned long long *)req)[0],
+		       ((unsigned long long *)req)[1]);
+		goto no_pasid;
+	}
 
-		result = QI_RESP_FAILURE;
-		address = (u64)req->addr << VTD_PAGE_SHIFT;
-		if (!req->pasid_present) {
-			pr_err("%s: Page request without PASID: %08llx %08llx\n",
-			       iommu->name, ((unsigned long long *)req)[0],
-			       ((unsigned long long *)req)[1]);
-			goto no_pasid;
-		}
+	rcu_read_lock();
+	svm = ioasid_find(NULL, req->pasid, NULL);
+	/*
+	 * It *can't* go away, because the driver is not permitted
+	 * to unbind the mm while any page faults are outstanding.
+	 * So we only need RCU to protect the internal idr code.
+	 */
+	rcu_read_unlock();
 
-		if (!svm || svm->pasid != req->pasid) {
-			rcu_read_lock();
-			svm = ioasid_find(NULL, req->pasid, NULL);
-			/* It *can't* go away, because the driver is not permitted
-			 * to unbind the mm while any page faults are outstanding.
-			 * So we only need RCU to protect the internal idr code. */
-			rcu_read_unlock();
-			if (IS_ERR_OR_NULL(svm)) {
-				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
-				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
-				       ((unsigned long long *)req)[1]);
-				goto no_pasid;
-			}
-		}
+	if (IS_ERR_OR_NULL(svm)) {
+		pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
+		       iommu->name, req->pasid, ((unsigned long long *)req)[0],
+		       ((unsigned long long *)req)[1]);
+		goto no_pasid;
+	}
 
-		result = QI_RESP_INVALID;
-		/* Since we're using init_mm.pgd directly, we should never take
-		 * any faults on kernel addresses. */
-		if (!svm->mm)
-			goto bad_req;
+	result = QI_RESP_INVALID;
+	/* Since we're using init_mm.pgd directly, we should never take
+	 * any faults on kernel addresses. */
+	if (!svm->mm)
+		goto bad_req;
+
+	/* If address is not canonical, return invalid response */
+	if (!is_canonical_address(address))
+		goto bad_req;
+
+	/* If the mm is already defunct, don't handle faults. */
+	if (!mmget_not_zero(svm->mm))
+		goto bad_req;
+
+	down_read(&svm->mm->mmap_sem);
+	vma = find_extend_vma(svm->mm, address);
+	if (!vma || address < vma->vm_start)
+		goto invalid;
+
+	if (access_error(vma, req))
+		goto invalid;
+
+	ret = handle_mm_fault(vma, address,
+			      req->wr_req ? FAULT_FLAG_WRITE : 0);
+	if (ret & VM_FAULT_ERROR)
+		goto invalid;
+
+	result = QI_RESP_SUCCESS;
+invalid:
+	up_read(&svm->mm->mmap_sem);
+	mmput(svm->mm);
+bad_req:
+	/* Accounting for major/minor faults? */
+	rcu_read_lock();
+	list_for_each_entry_rcu(sdev, &svm->devs, list) {
+		if (sdev->sid == req->rid)
+			break;
+	}
 
-		/* If address is not canonical, return invalid response */
-		if (!is_canonical_address(address))
-			goto bad_req;
+	/* Other devices can go away, but the drivers are not permitted
+	 * to unbind while any page faults might be in flight. So it's
+	 * OK to drop the 'lock' here now we have it. */
+	rcu_read_unlock();
 
-		/* If the mm is already defunct, don't handle faults. */
-		if (!mmget_not_zero(svm->mm))
-			goto bad_req;
+	if (WARN_ON(&sdev->list == &svm->devs))
+		sdev = NULL;
 
-		down_read(&svm->mm->mmap_sem);
-		vma = find_extend_vma(svm->mm, address);
-		if (!vma || address < vma->vm_start)
-			goto invalid;
+	if (sdev && sdev->ops && sdev->ops->fault_cb) {
+		int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
+			(req->exe_req << 1) | (req->pm_req);
+		sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr,
+				    req->priv_data, rwxp, result);
+	}
 
-		if (access_error(vma, req))
-			goto invalid;
+	/* We get here in the error case where the PASID lookup failed,
+	   and these can be NULL. Do not use them below this point! */
+	sdev = NULL;
+	svm = NULL;
+no_pasid:
+	if (req->lpig || req->priv_data_present) {
+		/*
+		 * Per VT-d spec. v3.0 ch7.7, system software must
+		 * respond with page group response if private data
+		 * is present (PDP) or last page in group (LPIG) bit
+		 * is set. This is an additional VT-d feature beyond
+		 * PCI ATS spec.
+		 */
+		resp.qw0 = QI_PGRP_PASID(req->pasid) |
+			QI_PGRP_DID(req->rid) |
+			QI_PGRP_PASID_P(req->pasid_present) |
+			QI_PGRP_PDP(req->pasid_present) |
+			QI_PGRP_RESP_CODE(result) |
+			QI_PGRP_RESP_TYPE;
+		resp.qw1 = QI_PGRP_IDX(req->prg_index) |
+			QI_PGRP_LPIG(req->lpig);
+
+		if (req->priv_data_present)
+			memcpy(&resp.qw2, req->priv_data,
+			       sizeof(req->priv_data));
+		resp.qw2 = 0;
+		resp.qw3 = 0;
+		qi_submit_sync(iommu, &resp, 1, 0);
+	}
+}
 
-		ret = handle_mm_fault(vma, address,
-				      req->wr_req ? FAULT_FLAG_WRITE : 0);
-		if (ret & VM_FAULT_ERROR)
-			goto invalid;
+static void intel_svm_process_prq(struct intel_iommu *iommu,
+				  struct page_req_dsc *prq,
+				  int head, int tail)
+{
+	struct page_req_dsc *req;
 
-		result = QI_RESP_SUCCESS;
-	invalid:
-		up_read(&svm->mm->mmap_sem);
-		mmput(svm->mm);
-	bad_req:
-		/* Accounting for major/minor faults? */
-		rcu_read_lock();
-		list_for_each_entry_rcu(sdev, &svm->devs, list) {
-			if (sdev->sid == req->rid)
-				break;
-		}
-		/* Other devices can go away, but the drivers are not permitted
-		 * to unbind while any page faults might be in flight. So it's
-		 * OK to drop the 'lock' here now we have it. */
-		rcu_read_unlock();
-
-		if (WARN_ON(&sdev->list == &svm->devs))
-			sdev = NULL;
-
-		if (sdev && sdev->ops && sdev->ops->fault_cb) {
-			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
-				(req->exe_req << 1) | (req->pm_req);
-			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr,
-					    req->priv_data, rwxp, result);
-		}
-		/* We get here in the error case where the PASID lookup failed,
-		   and these can be NULL. Do not use them below this point! */
-		sdev = NULL;
-		svm = NULL;
-	no_pasid:
-		if (req->lpig || req->priv_data_present) {
-			/*
-			 * Per VT-d spec. v3.0 ch7.7, system software must
-			 * respond with page group response if private data
-			 * is present (PDP) or last page in group (LPIG) bit
-			 * is set. This is an additional VT-d feature beyond
-			 * PCI ATS spec.
-			 */
-			resp.qw0 = QI_PGRP_PASID(req->pasid) |
-				QI_PGRP_DID(req->rid) |
-				QI_PGRP_PASID_P(req->pasid_present) |
-				QI_PGRP_PDP(req->pasid_present) |
-				QI_PGRP_RESP_CODE(result) |
-				QI_PGRP_RESP_TYPE;
-			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
-				QI_PGRP_LPIG(req->lpig);
-
-			if (req->priv_data_present)
-				memcpy(&resp.qw2, req->priv_data,
-				       sizeof(req->priv_data));
-			resp.qw2 = 0;
-			resp.qw3 = 0;
-			qi_submit_sync(iommu, &resp, 1, 0);
-		}
+	while (head != tail) {
+		req = &iommu->prq[head / sizeof(*req)];
+		process_single_prq(iommu, req);
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
+}
+
+static irqreturn_t prq_event_thread(int irq, void *d)
+{
+	struct intel_iommu *iommu = d;
+	int head, tail;
 
+	/*
+	 * Clear PPR bit before reading head/tail registers, to
+	 * ensure that we get a new interrupt if needed.
+	 */
+	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
+
+	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	intel_svm_process_prq(iommu, iommu->prq, head, tail);
 	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
 
-	return IRQ_RETVAL(handled);
+	return IRQ_RETVAL(1);
 }
 
 #define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
