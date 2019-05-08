Return-Path: <SRS0=jTem=TI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EBCC04A6B
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 19:20:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112B921530
	for <iommu@archiver.kernel.org>; Wed,  8 May 2019 19:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112B921530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CEDA4E4C;
	Wed,  8 May 2019 19:19:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E6BCEDCB
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 19:19:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9DF8387C
	for <iommu@lists.linux-foundation.org>;
	Wed,  8 May 2019 19:19:58 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 May 2019 12:19:58 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 08 May 2019 12:19:57 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] iommu/vt-d: Fix bind svm with multiple devices
Date: Wed,  8 May 2019 12:22:46 -0700
Message-Id: <1557343366-18686-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Raj Ashok <ashok.raj@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

If multiple devices try to bind to the same mm/PASID, we need to
set up first level PASID entries for all the devices. The current
code does not consider this case which results in failed DMA for
devices after the first bind.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reported-by: Mike Campin <mike.campin@intel.com>
---
 drivers/iommu/intel-svm.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 3a4b09a..f3d59d1 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -357,6 +357,21 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 		}
 
 		list_add_tail(&svm->list, &global_svm_list);
+	} else {
+		/*
+		 * Binding a new device with existing PASID, need to setup
+		 * the PASID entry.
+		 */
+		spin_lock(&iommu->lock);
+		ret = intel_pasid_setup_first_level(iommu, dev,
+						mm ? mm->pgd : init_mm.pgd,
+						svm->pasid, FLPT_DEFAULT_DID,
+						mm ? 0 : PASID_FLAG_SUPERVISOR_MODE);
+		spin_unlock(&iommu->lock);
+		if (ret) {
+			kfree(sdev);
+			goto out;
+		}
 	}
 	list_add_rcu(&sdev->list, &svm->devs);
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
