Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1269C433DF
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1EF20772
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1EF20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 92F6F8848A;
	Tue, 30 Jun 2020 21:01:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQ6j8K5+BMmV; Tue, 30 Jun 2020 21:01:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C11D7883DC;
	Tue, 30 Jun 2020 21:01:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBE2AC08A7;
	Tue, 30 Jun 2020 21:01:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF8FC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1F8F820407
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:01:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FPtxMmIcXKTC for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 21:01:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 45F5722B6D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 21:01:07 +0000 (UTC)
IronPort-SDR: XY4k6gQ4nqqRNrjS/tHkz1UpHl+u+pd0XUsmiwn/0LdkY8eUtwmloM9fhRPrcH+qUcj+Ve1HM5
 lw1kcYB21f/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="146382049"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="146382049"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2020 14:01:05 -0700
IronPort-SDR: /wmag5B4Ql9P15sI9srtqyRDa0eh7ubLTsJmfUYXd82SUf6Tho+/plx1WvmKmMlYKGjq3oA2u7
 sxgXik/19Wag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; d="scan'208";a="425337243"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 30 Jun 2020 14:01:05 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH v2 7/7] iommu/vt-d: Disable multiple GPASID-dev bind
Date: Tue, 30 Jun 2020 14:07:38 -0700
Message-Id: <1593551258-39854-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1593551258-39854-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
