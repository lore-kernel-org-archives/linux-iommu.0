Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BA0C4363A
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 02:58:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C488420791
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 02:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C488420791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2809E868E1;
	Fri, 30 Oct 2020 02:58:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qqUER6InTxVS; Fri, 30 Oct 2020 02:58:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7FFE2868DB;
	Fri, 30 Oct 2020 02:58:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79AC7C0859;
	Fri, 30 Oct 2020 02:58:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42867C1AD4
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 02:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3404D87446
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 02:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UjyTD5kCH6Q5 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 02:58:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B95968742C
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 02:58:16 +0000 (UTC)
IronPort-SDR: rhL45WcGpQPa3lrggQb8o/o0kFcSu7II2HlU6UbUTx2HwIsKNRksVUAQx0DdC1uD4KBOd4AjIf
 21WMqgvsQi9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="165054112"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; d="scan'208";a="165054112"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2020 19:58:16 -0700
IronPort-SDR: uL0VWrOYLs8oaetVA266Zi8E2ifbVqy3XTPqUkkhkLyIlQNQgyUd0gPHaw/vpg/xyDvhXrGEXc
 9QGAWFvV3VMA==
X-IronPort-AV: E=Sophos;i="5.77,431,1596524400"; d="scan'208";a="469374401"
Received: from yisun1-ubuntu2.bj.intel.com ([10.238.144.104])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA;
 29 Oct 2020 19:58:14 -0700
From: Yi Sun <yi.y.sun@linux.intel.com>
To: joro@8bytes.org, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 jean-philippe@linaro.org
Subject: [PATCH v2 1/2] iommu/vt-d: Fix sid not set issue in
 intel_svm_bind_gpasid()
Date: Fri, 30 Oct 2020 10:37:23 +0800
Message-Id: <1604025444-6954-2-git-send-email-yi.y.sun@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
References: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Yi Sun <yi.y.sun@linux.intel.com>,
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

From: Liu Yi L <yi.l.liu@intel.com>

Should get correct sid and set it into sdev. Because we execute
'sdev->sid != req->rid' in the loop of prq_event_thread().

Fixes: eb8d93ea3c1d ("iommu/vt-d: Report page request faults for guest SVA")
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f1861fa..7584669 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -279,6 +279,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct intel_svm_dev *sdev = NULL;
 	struct dmar_domain *dmar_domain;
+	struct device_domain_info *info;
 	struct intel_svm *svm = NULL;
 	int ret = 0;
 
@@ -310,6 +311,10 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
 		return -EINVAL;
 
+	info = get_domain_info(dev);
+	if (!info)
+		return -EINVAL;
+
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
@@ -357,6 +362,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 		goto out;
 	}
 	sdev->dev = dev;
+	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 
 	/* Only count users if device has aux domains */
 	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
