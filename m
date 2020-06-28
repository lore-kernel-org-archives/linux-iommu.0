Return-Path: <SRS0=DkpR=AJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23683C433E3
	for <iommu@archiver.kernel.org>; Sun, 28 Jun 2020 00:38:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006562076E
	for <iommu@archiver.kernel.org>; Sun, 28 Jun 2020 00:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006562076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE03C86E97;
	Sun, 28 Jun 2020 00:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B3hmGKrar_sU; Sun, 28 Jun 2020 00:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4958786EB0;
	Sun, 28 Jun 2020 00:38:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36F43C0865;
	Sun, 28 Jun 2020 00:38:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE39FC016F
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 00:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AE8A786EB0
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 00:38:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RuJotL8ELvmN for <iommu@lists.linux-foundation.org>;
 Sun, 28 Jun 2020 00:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 296C0862D4
 for <iommu@lists.linux-foundation.org>; Sun, 28 Jun 2020 00:38:02 +0000 (UTC)
IronPort-SDR: gZj8c9mxHbybtrb/EkLcdqBDg1iIfn2Vp0Osz3Wea5/t8/Rnb+jiobfQ8QbjgYKlc6/xjSEPEK
 YcGvCk/hwHkw==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="144805162"
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; d="scan'208";a="144805162"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2020 17:38:01 -0700
IronPort-SDR: kJApfR/9l3D4QEaW+xQFQrDCcVf4IByKd+gVB7xuvfXoPN+ZvIQyQ/GkFLkiitNLw1MS6I3s49
 +S9o4i1oLEiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; d="scan'208";a="302695028"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2020 17:38:00 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 4/4] iommu/vt-d: Add page response ops support
Date: Sun, 28 Jun 2020 08:33:32 +0800
Message-Id: <20200628003332.5720-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200628003332.5720-1-baolu.lu@linux.intel.com>
References: <20200628003332.5720-1-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 linux-kernel@vger.kernel.org
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

After a page request is handled, software must response the device which
raised the page request with the handling result. This is done through
the iommu ops.page_response if the request was reported to outside of
vendor iommu driver through iommu_report_device_fault(). This adds the
VT-d implementation of page_response ops.

Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  1 +
 drivers/iommu/intel/svm.c   | 73 +++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  3 ++
 3 files changed, 77 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index de17952ed133..7eb29167e8f9 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6057,6 +6057,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.sva_bind		= intel_svm_bind,
 	.sva_unbind		= intel_svm_unbind,
 	.sva_get_pasid		= intel_svm_get_pasid,
+	.page_response		= intel_svm_page_response,
 #endif
 };
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 4800bb6f8794..003ea9579632 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -1092,3 +1092,76 @@ int intel_svm_get_pasid(struct iommu_sva *sva)
 
 	return pasid;
 }
+
+int intel_svm_page_response(struct device *dev,
+			    struct iommu_fault_event *evt,
+			    struct iommu_page_response *msg)
+{
+	struct iommu_fault_page_request *prm;
+	struct intel_svm_dev *sdev;
+	struct intel_iommu *iommu;
+	struct intel_svm *svm;
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
+	if (pasid_present) {
+		/* VT-d supports devices with full 20 bit PASIDs only */
+		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = pasid_to_svm_sdev(dev, prm->pasid, &svm, &sdev);
+		if (ret || !sdev)
+			goto out;
+	}
+
+	/*
+	 * Per VT-d spec. v3.0 ch7.7, system software must respond
+	 * with page group response if private data is present (PDP)
+	 * or last page in group (LPIG) bit is set. This is an
+	 * additional VT-d feature beyond PCI ATS spec.
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
index fc2cfc3db6e1..bf6009a344f5 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -741,6 +741,9 @@ struct iommu_sva *intel_svm_bind(struct device *dev, struct mm_struct *mm,
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
