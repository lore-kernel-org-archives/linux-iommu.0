Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F08C433F8
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501422086A
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501422086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 40B9986DC2;
	Fri, 24 Jul 2020 01:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jcDdeOLnSUBL; Fri, 24 Jul 2020 01:54:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B13986DAC;
	Fri, 24 Jul 2020 01:54:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8981CC004E;
	Fri, 24 Jul 2020 01:54:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6744FC004E
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 63DD887E95
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wk5xQeibDPS4 for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 01:54:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A6FBB87E76
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:43 +0000 (UTC)
IronPort-SDR: gvKH9BHmZ6G8xMpz0Vh93NXIHcJPTaXbcXzlQTwIgWeoZYLq2LOtSXEsOMRcWo9kaISQ9xBW3r
 2HSDjWvtIzuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168778794"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="168778794"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 18:54:43 -0700
IronPort-SDR: 38lUET/gM8ZenBlLK19gvm0S112Squ01VAztqp8lAbCNvyZYjmvHB/g98p7gv0VAL4TWGnVy/n
 EccMtz5Oomkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="488576800"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2020 18:54:42 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 11/12] iommu/vt-d: Add page response ops support
Date: Fri, 24 Jul 2020 09:49:24 +0800
Message-Id: <20200724014925.15523-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724014925.15523-1-baolu.lu@linux.intel.com>
References: <20200724014925.15523-1-baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
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

After page requests are handled, software must respond to the device
which raised the page request with the result. This is done through
the iommu ops.page_response if the request was reported to outside of
vendor iommu driver through iommu_report_device_fault(). This adds the
VT-d implementation of page_response ops.

Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c |  1 +
 drivers/iommu/intel/svm.c   | 99 +++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  3 ++
 3 files changed, 103 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 097a71b3b75d..a939d17d40a1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6073,6 +6073,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.sva_bind		= intel_svm_bind,
 	.sva_unbind		= intel_svm_unbind,
 	.sva_get_pasid		= intel_svm_get_pasid,
+	.page_response		= intel_svm_page_response,
 #endif
 };
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 140114ab1375..85ce8daa3177 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1078,3 +1078,102 @@ int intel_svm_get_pasid(struct iommu_sva *sva)
 
 	return pasid;
 }
+
+int intel_svm_page_response(struct device *dev,
+			    struct iommu_fault_event *evt,
+			    struct iommu_page_response *msg)
+{
+	struct iommu_fault_page_request *prm;
+	struct intel_svm_dev *sdev = NULL;
+	struct intel_svm *svm = NULL;
+	struct intel_iommu *iommu;
+	bool private_present;
+	bool pasid_present;
+	bool last_page;
+	u8 bus, devfn;
+	int ret = 0;
+	u16 sid;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	iommu = device_to_iommu(dev, &bus, &devfn);
+	if (!iommu)
+		return -ENODEV;
+
+	if (!msg || !evt)
+		return -EINVAL;
+
+	mutex_lock(&pasid_mutex);
+
+	prm = &evt->fault.prm;
+	sid = PCI_DEVID(bus, devfn);
+	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	private_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
+	last_page = prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+
+	if (!pasid_present) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (prm->pasid == 0 || prm->pasid >= PASID_MAX) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
+	if (ret || !sdev) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/*
+	 * For responses from userspace, need to make sure that the
+	 * pasid has been bound to its mm.
+	 */
+	if (svm->flags & SVM_FLAG_GUEST_MODE) {
+		struct mm_struct *mm;
+
+		mm = get_task_mm(current);
+		if (!mm) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (mm != svm->mm) {
+			ret = -ENODEV;
+			mmput(mm);
+			goto out;
+		}
+
+		mmput(mm);
+	}
+
+	/*
+	 * Per VT-d spec. v3.0 ch7.7, system software must respond
+	 * with page group response if private data is present (PDP)
+	 * or last page in group (LPIG) bit is set. This is an
+	 * additional VT-d requirement beyond PCI ATS spec.
+	 */
+	if (last_page || private_present) {
+		struct qi_desc desc;
+
+		desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid) |
+				QI_PGRP_PASID_P(pasid_present) |
+				QI_PGRP_PDP(private_present) |
+				QI_PGRP_RESP_CODE(msg->code) |
+				QI_PGRP_RESP_TYPE;
+		desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
+		desc.qw2 = 0;
+		desc.qw3 = 0;
+		if (private_present)
+			memcpy(&desc.qw2, prm->private_data,
+			       sizeof(prm->private_data));
+
+		qi_submit_sync(iommu, &desc, 1, 0);
+	}
+out:
+	mutex_unlock(&pasid_mutex);
+	return ret;
+}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 7e69aec60592..b1ed2f25f7c0 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -742,6 +742,9 @@ struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
 				 void *drvdata);
 void intel_svm_unbind(struct iommu_sva *handle);
 int intel_svm_get_pasid(struct iommu_sva *handle);
+int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
+			    struct iommu_page_response *msg);
+
 struct svm_dev_ops;
 
 struct intel_svm_dev {
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
