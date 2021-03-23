Return-Path: <SRS0=ZOt4=IV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8762BC433DB
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:15:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FCD161974
	for <iommu@archiver.kernel.org>; Tue, 23 Mar 2021 01:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FCD161974
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B1BE40339;
	Tue, 23 Mar 2021 01:15:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wi0RPhVF-N2i; Tue, 23 Mar 2021 01:15:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4104403D0;
	Tue, 23 Mar 2021 01:15:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9208EC000B;
	Tue, 23 Mar 2021 01:15:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E0A6C0001
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ECD6860808
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y4mr-LCvz1wC for <iommu@lists.linux-foundation.org>;
 Tue, 23 Mar 2021 01:15:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3AF0A60689
 for <iommu@lists.linux-foundation.org>; Tue, 23 Mar 2021 01:15:41 +0000 (UTC)
IronPort-SDR: cHojOnFruw3LlMLQPfe1LCSc1Kw5SH+r0PIbPiw3wt1nZZc/Hj5F9e9un1gJ5fGN+cr+MtRhew
 X1ADEmArYw/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="275480162"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="275480162"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2021 18:15:41 -0700
IronPort-SDR: WQ+hfp8A/lt8gmAUT5NchneiysNRV8iaaXj3QDExXlWrNJDxW8Ld8PcL83mnTwzf9gV9ZS39bb
 MyTyg7m4m/Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; d="scan'208";a="435362452"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 22 Mar 2021 18:15:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/5] iommu/vt-d: Remove svm_dev_ops
Date: Tue, 23 Mar 2021 09:05:57 +0800
Message-Id: <20210323010600.678627-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210323010600.678627-1-baolu.lu@linux.intel.com>
References: <20210323010600.678627-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com
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

The svm_dev_ops has never been referenced in the tree, and there's no
plan to have anything to use it. Remove it to make the code neat.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c   | 15 +--------------
 include/linux/intel-iommu.h |  3 ---
 include/linux/intel-svm.h   |  7 -------
 3 files changed, 1 insertion(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 5d590d63ab52..875ee74d8c41 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -462,7 +462,6 @@ static void load_pasid(struct mm_struct *mm, u32 pasid)
 /* Caller must hold pasid_mutex, mm reference */
 static int
 intel_svm_bind_mm(struct device *dev, unsigned int flags,
-		  struct svm_dev_ops *ops,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
@@ -512,10 +511,6 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 
 			/* Find the matching device in svm list */
 			for_each_svm_dev(sdev, svm, dev) {
-				if (sdev->ops != ops) {
-					ret = -EBUSY;
-					goto out;
-				}
 				sdev->users++;
 				goto success;
 			}
@@ -550,7 +545,6 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
 
 	/* Finish the setup now we know we're keeping it */
 	sdev->users = 1;
-	sdev->ops = ops;
 	init_rcu_head(&sdev->rcu);
 
 	if (!svm) {
@@ -1006,13 +1000,6 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		mmap_read_unlock(svm->mm);
 		mmput(svm->mm);
 bad_req:
-		WARN_ON(!sdev);
-		if (sdev && sdev->ops && sdev->ops->fault_cb) {
-			int rwxp = (req->rd_req << 3) | (req->wr_req << 2) |
-				(req->exe_req << 1) | (req->pm_req);
-			sdev->ops->fault_cb(sdev->dev, req->pasid, req->addr,
-					    req->priv_data, rwxp, result);
-		}
 		/* We get here in the error case where the PASID lookup failed,
 		   and these can be NULL. Do not use them below this point! */
 		sdev = NULL;
@@ -1087,7 +1074,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 	if (drvdata)
 		flags = *(unsigned int *)drvdata;
 	mutex_lock(&pasid_mutex);
-	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
+	ret = intel_svm_bind_mm(dev, flags, mm, &sdev);
 	if (ret)
 		sva = ERR_PTR(ret);
 	else if (sdev)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 76f974da8ca4..03faf20a6817 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -770,14 +770,11 @@ u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
 
-struct svm_dev_ops;
-
 struct intel_svm_dev {
 	struct list_head list;
 	struct rcu_head rcu;
 	struct device *dev;
 	struct intel_iommu *iommu;
-	struct svm_dev_ops *ops;
 	struct iommu_sva sva;
 	u32 pasid;
 	int users;
diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
index 39d368a810b8..6c9d10c0fb1e 100644
--- a/include/linux/intel-svm.h
+++ b/include/linux/intel-svm.h
@@ -8,13 +8,6 @@
 #ifndef __INTEL_SVM_H__
 #define __INTEL_SVM_H__
 
-struct device;
-
-struct svm_dev_ops {
-	void (*fault_cb)(struct device *dev, u32 pasid, u64 address,
-			 void *private, int rwxp, int response);
-};
-
 /* Values for rxwp in fault_cb callback */
 #define SVM_REQ_READ	(1<<3)
 #define SVM_REQ_WRITE	(1<<2)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
