Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBEFC48BCF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1557B61410
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1557B61410
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3AF740595;
	Thu, 10 Jun 2021 02:03:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id htwLduXRrOhy; Thu, 10 Jun 2021 02:03:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E42C4054B;
	Thu, 10 Jun 2021 02:03:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A02BC000E;
	Thu, 10 Jun 2021 02:03:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45904C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3301B831A5
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6SAFVzFDyM4E for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:03:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 204878318C
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:24 +0000 (UTC)
IronPort-SDR: GxRcSzzqm9K83XBgeso85owziaLxytIKTPEsGllt1zfUoG8E8YoGHxqk2V207mj+nCKtk6dwvx
 VF6vW4AIdptA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184220"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184220"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:03:23 -0700
IronPort-SDR: fJPx3DmNswe8q7TYS8mUOJ/hMKrL+EbIi35eip/zNPYlF5PhCOM8LXig0AjTpRHtVdJubevNRC
 hT2kpz/fzimw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500385"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:03:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 09/23] iommu/vt-d: Refactor prq_event_thread()
Date: Thu, 10 Jun 2021 10:01:01 +0800
Message-Id: <20210610020115.1637656-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
References: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Aditya Srivastava <yashsri421@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 YueHaibing <yuehaibing@huawei.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 iommu@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>,
 Will Deacon <will@kernel.org>
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

Refactor prq_event_thread() by moving handling single prq event out of
the main loop.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210520031531.712333-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/svm.c | 239 ++++++++++++++++++++++----------------
 1 file changed, 136 insertions(+), 103 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 57867ff97bc2..d51ddece4259 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -866,141 +866,174 @@ intel_svm_prq_report(struct device *dev, struct page_req_dsc *desc)
 	return iommu_report_device_fault(dev, &event);
 }
 
+static void handle_bad_prq_event(struct intel_iommu *iommu,
+				 struct page_req_dsc *req, int result)
+{
+	struct qi_desc desc;
+
+	pr_err("%s: Invalid page request: %08llx %08llx\n",
+	       iommu->name, ((unsigned long long *)req)[0],
+	       ((unsigned long long *)req)[1]);
+
+	/*
+	 * Per VT-d spec. v3.0 ch7.7, system software must
+	 * respond with page group response if private data
+	 * is present (PDP) or last page in group (LPIG) bit
+	 * is set. This is an additional VT-d feature beyond
+	 * PCI ATS spec.
+	 */
+	if (!req->lpig && !req->priv_data_present)
+		return;
+
+	desc.qw0 = QI_PGRP_PASID(req->pasid) |
+			QI_PGRP_DID(req->rid) |
+			QI_PGRP_PASID_P(req->pasid_present) |
+			QI_PGRP_PDP(req->priv_data_present) |
+			QI_PGRP_RESP_CODE(result) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
+			QI_PGRP_LPIG(req->lpig);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	if (req->priv_data_present)
+		memcpy(&desc.qw2, req->priv_data, sizeof(req->priv_data));
+	qi_submit_sync(iommu, &desc, 1, 0);
+}
+
+static void handle_single_prq_event(struct intel_iommu *iommu,
+				    struct mm_struct *mm,
+				    struct page_req_dsc *req)
+{
+	u64 address = (u64)req->addr << VTD_PAGE_SHIFT;
+	int result = QI_RESP_INVALID;
+	struct vm_area_struct *vma;
+	struct qi_desc desc;
+	unsigned int flags;
+	vm_fault_t ret;
+
+	/* If the mm is already defunct, don't handle faults. */
+	if (!mmget_not_zero(mm))
+		goto response;
+
+	mmap_read_lock(mm);
+	vma = find_extend_vma(mm, address);
+	if (!vma || address < vma->vm_start)
+		goto invalid;
+
+	if (access_error(vma, req))
+		goto invalid;
+
+	flags = FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
+	if (req->wr_req)
+		flags |= FAULT_FLAG_WRITE;
+
+	ret = handle_mm_fault(vma, address, flags, NULL);
+	if (!(ret & VM_FAULT_ERROR))
+		result = QI_RESP_SUCCESS;
+invalid:
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+response:
+	if (!(req->lpig || req->priv_data_present))
+		return;
+
+	desc.qw0 = QI_PGRP_PASID(req->pasid) |
+			QI_PGRP_DID(req->rid) |
+			QI_PGRP_PASID_P(req->pasid_present) |
+			QI_PGRP_PDP(req->priv_data_present) |
+			QI_PGRP_RESP_CODE(result) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
+			QI_PGRP_LPIG(req->lpig);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	if (req->priv_data_present)
+		memcpy(&desc.qw2, req->priv_data, sizeof(req->priv_data));
+
+	qi_submit_sync(iommu, &desc, 1, 0);
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_svm_dev *sdev = NULL;
 	struct intel_iommu *iommu = d;
 	struct intel_svm *svm = NULL;
-	int head, tail, handled = 0;
-	unsigned int flags = 0;
+	struct page_req_dsc *req;
+	int head, tail, handled;
+	u64 address;
 
-	/* Clear PPR bit before reading head/tail registers, to
-	 * ensure that we get a new interrupt if needed. */
+	/*
+	 * Clear PPR bit before reading head/tail registers, to ensure that
+	 * we get a new interrupt if needed.
+	 */
 	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
 
 	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
 	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	handled = (head != tail);
 	while (head != tail) {
-		struct vm_area_struct *vma;
-		struct page_req_dsc *req;
-		struct qi_desc resp;
-		int result;
-		vm_fault_t ret;
-		u64 address;
-
-		handled = 1;
 		req = &iommu->prq[head / sizeof(*req)];
-		result = QI_RESP_INVALID;
 		address = (u64)req->addr << VTD_PAGE_SHIFT;
-		if (!req->pasid_present) {
-			pr_err("%s: Page request without PASID: %08llx %08llx\n",
-			       iommu->name, ((unsigned long long *)req)[0],
-			       ((unsigned long long *)req)[1]);
-			goto no_pasid;
+
+		if (unlikely(!req->pasid_present)) {
+			pr_err("IOMMU: %s: Page request without PASID\n",
+			       iommu->name);
+bad_req:
+			svm = NULL;
+			sdev = NULL;
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+			goto prq_advance;
 		}
-		/* We shall not receive page request for supervisor SVM */
-		if (req->pm_req && (req->rd_req | req->wr_req)) {
-			pr_err("Unexpected page request in Privilege Mode");
-			/* No need to find the matching sdev as for bad_req */
-			goto no_pasid;
+
+		if (unlikely(!is_canonical_address(address))) {
+			pr_err("IOMMU: %s: Address is not canonical\n",
+			       iommu->name);
+			goto bad_req;
+		}
+
+		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
+			pr_err("IOMMU: %s: Page request in Privilege Mode\n",
+			       iommu->name);
+			goto bad_req;
 		}
-		/* DMA read with exec requeset is not supported. */
-		if (req->exe_req && req->rd_req) {
-			pr_err("Execution request not supported\n");
-			goto no_pasid;
+
+		if (unlikely(req->exe_req && req->rd_req)) {
+			pr_err("IOMMU: %s: Execution request not supported\n",
+			       iommu->name);
+			goto bad_req;
 		}
+
 		if (!svm || svm->pasid != req->pasid) {
-			rcu_read_lock();
-			svm = pasid_private_find(req->pasid);
-			/* It *can't* go away, because the driver is not permitted
+			/*
+			 * It can't go away, because the driver is not permitted
 			 * to unbind the mm while any page faults are outstanding.
-			 * So we only need RCU to protect the internal idr code. */
-			rcu_read_unlock();
-			if (IS_ERR_OR_NULL(svm)) {
-				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
-				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
-				       ((unsigned long long *)req)[1]);
-				goto no_pasid;
-			}
+			 */
+			svm = pasid_private_find(req->pasid);
+			if (IS_ERR_OR_NULL(svm) || (svm->flags & SVM_FLAG_SUPERVISOR_MODE))
+				goto bad_req;
 		}
 
-		if (!sdev || sdev->sid != req->rid)
+		if (!sdev || sdev->sid != req->rid) {
 			sdev = svm_lookup_device_by_sid(svm, req->rid);
-
-		/* Since we're using init_mm.pgd directly, we should never take
-		 * any faults on kernel addresses. */
-		if (!svm->mm)
-			goto bad_req;
-
-		/* If address is not canonical, return invalid response */
-		if (!is_canonical_address(address))
-			goto bad_req;
+			if (!sdev)
+				goto bad_req;
+		}
 
 		/*
 		 * If prq is to be handled outside iommu driver via receiver of
 		 * the fault notifiers, we skip the page response here.
 		 */
 		if (svm->flags & SVM_FLAG_GUEST_MODE) {
-			if (sdev && !intel_svm_prq_report(sdev->dev, req))
+			if (!intel_svm_prq_report(sdev->dev, req))
 				goto prq_advance;
 			else
 				goto bad_req;
 		}
 
-		/* If the mm is already defunct, don't handle faults. */
-		if (!mmget_not_zero(svm->mm))
-			goto bad_req;
-
-		mmap_read_lock(svm->mm);
-		vma = find_extend_vma(svm->mm, address);
-		if (!vma || address < vma->vm_start)
-			goto invalid;
-
-		if (access_error(vma, req))
-			goto invalid;
-
-		flags = FAULT_FLAG_USER | FAULT_FLAG_REMOTE;
-		if (req->wr_req)
-			flags |= FAULT_FLAG_WRITE;
-
-		ret = handle_mm_fault(vma, address, flags, NULL);
-		if (ret & VM_FAULT_ERROR)
-			goto invalid;
-
-		result = QI_RESP_SUCCESS;
-invalid:
-		mmap_read_unlock(svm->mm);
-		mmput(svm->mm);
-bad_req:
-		/* We get here in the error case where the PASID lookup failed,
-		   and these can be NULL. Do not use them below this point! */
-		sdev = NULL;
-		svm = NULL;
-no_pasid:
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
-				QI_PGRP_PDP(req->priv_data_present) |
-				QI_PGRP_RESP_CODE(result) |
-				QI_PGRP_RESP_TYPE;
-			resp.qw1 = QI_PGRP_IDX(req->prg_index) |
-				QI_PGRP_LPIG(req->lpig);
-			resp.qw2 = 0;
-			resp.qw3 = 0;
-
-			if (req->priv_data_present)
-				memcpy(&resp.qw2, req->priv_data,
-				       sizeof(req->priv_data));
-			qi_submit_sync(iommu, &resp, 1, 0);
-		}
+		handle_single_prq_event(iommu, svm->mm, req);
 prq_advance:
 		head = (head + sizeof(*req)) & PRQ_RING_MASK;
 	}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
