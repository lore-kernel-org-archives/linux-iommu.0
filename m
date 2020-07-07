Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8105C433EA
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 00:06:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 857A32065D
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 00:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 857A32065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0DD9D87231;
	Tue,  7 Jul 2020 00:06:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mo74Rp3a6KIs; Tue,  7 Jul 2020 00:06:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 48B8087A3B;
	Tue,  7 Jul 2020 00:06:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33B11C0891;
	Tue,  7 Jul 2020 00:06:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83B47C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 00:06:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 72AF1879D7
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 00:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NeJujaH0uiYD for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 00:06:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2555D87231
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 00:06:22 +0000 (UTC)
IronPort-SDR: RBdiz882DfwuHWolXx4usHmfSOAWKgIEaa3iF0UxfoWC1k/6VRNJ6oG3+PXyMGJawfIuBv4bex
 cIwMkFS1ufdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="232379354"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="232379354"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 17:06:19 -0700
IronPort-SDR: zIKUYel984wcBdO+TLjmSOReSJwSakFRRGa9gt4eyUT3zw+W/tvb3jMJlmnjGzGml0C6FqTgnX
 xPgt4TuSi+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; d="scan'208";a="456913831"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 06 Jul 2020 17:06:17 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v4 7/7] iommu/vt-d: Disable multiple GPASID-dev bind
Date: Mon,  6 Jul 2020 17:12:54 -0700
Message-Id: <1594080774-33413-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1594080774-33413-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

For the unlikely use case where multiple aux domains from the same pdev
are attached to a single guest and then bound to a single process
(thus same PASID) within that guest, we cannot easily support this case
by refcounting the number of users. As there is only one SL page table
per PASID while we have multiple aux domains thus multiple SL page tables
for the same PASID.

Extra unbinding guest PASID can happen due to race between normal and
exception cases. Termination of one aux domain may affect others unless
we actively track and switch aux domains to ensure the validity of SL
page tables and TLB states in the shared PASID entry.

Support for sharing second level PGDs across domains can reduce the
complexity but this is not available due to the limitations on VFIO
container architecture. We can revisit this decision once sharing PGDs
are available.

Overall, the complexity and potential glitch do not warrant this unlikely
use case thereby removed by this patch.

Fixes: 56722a4398a30 ("iommu/vt-d: Add bind guest PASID support")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 6c87c807a0ab..d386853121a2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -277,20 +277,16 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			goto out;
 		}
 
+		/*
+		 * Do not allow multiple bindings of the same device-PASID since
+		 * there is only one SL page tables per PASID. We may revisit
+		 * once sharing PGD across domains are supported.
+		 */
 		for_each_svm_dev(sdev, svm, dev) {
-			/*
-			 * For devices with aux domains, we should allow
-			 * multiple bind calls with the same PASID and pdev.
-			 */
-			if (iommu_dev_feature_enabled(dev,
-						      IOMMU_DEV_FEAT_AUX)) {
-				sdev->users++;
-			} else {
-				dev_warn_ratelimited(dev,
-						     "Already bound with PASID %u\n",
-						     svm->pasid);
-				ret = -EBUSY;
-			}
+			dev_warn_ratelimited(dev,
+					     "Already bound with PASID %u\n",
+					     svm->pasid);
+			ret = -EBUSY;
 			goto out;
 		}
 	} else {
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
