Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F671C43462
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:16:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED02613B9
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 03:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED02613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D7AE040176;
	Thu, 20 May 2021 03:16:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9xZ4DnU8cxjK; Thu, 20 May 2021 03:16:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC5DE40496;
	Thu, 20 May 2021 03:16:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 714F5C0022;
	Thu, 20 May 2021 03:16:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4EDB9C0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E14440176
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RDPEgIAuoaX5 for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 03:16:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F39940159
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 03:16:51 +0000 (UTC)
IronPort-SDR: 79MwGytjmcBS3DkBg9TSGallSaH9Kx1WDNee6k1MIm2JlmiiuP3kYR9yyvnCSSQUhX3hwZf1rd
 +JE4srpR+FMg==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="286659614"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="286659614"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2021 20:16:51 -0700
IronPort-SDR: /OV9waVq8p7mlGyfB7Xba89tra03SeVTQ4CF9I94BLatG+4JGy7a6+taVbourpabpBv+L5wV32
 qaLjmwyGMIeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="395527201"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by orsmga006.jf.intel.com with ESMTP; 19 May 2021 20:16:49 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 03/11] iommu/vt-d: Use common helper to lookup svm devices
Date: Thu, 20 May 2021 11:15:23 +0800
Message-Id: <20210520031531.712333-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210520031531.712333-1-baolu.lu@linux.intel.com>
References: <20210520031531.712333-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com,
 ashok.raj@intel.com, linux-kernel@vger.kernel.org,
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

It's common to iterate the svm device list and find a matched device. Add
common helpers to do this and consolidate the code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 68 +++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index da4310686ed3..57867ff97bc2 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -48,6 +48,40 @@ static void *pasid_private_find(ioasid_t pasid)
 	return xa_load(&pasid_private_array, pasid);
 }
 
+static struct intel_svm_dev *
+svm_lookup_device_by_sid(struct intel_svm *svm, u16 sid)
+{
+	struct intel_svm_dev *sdev = NULL, *t;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(t, &svm->devs, list) {
+		if (t->sid == sid) {
+			sdev = t;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return sdev;
+}
+
+static struct intel_svm_dev *
+svm_lookup_device_by_dev(struct intel_svm *svm, struct device *dev)
+{
+	struct intel_svm_dev *sdev = NULL, *t;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(t, &svm->devs, list) {
+		if (t->dev == dev) {
+			sdev = t;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return sdev;
+}
+
 int intel_svm_enable_prq(struct intel_iommu *iommu)
 {
 	struct page *pages;
@@ -225,15 +259,11 @@ static const struct mmu_notifier_ops intel_mmuops = {
 
 static DEFINE_MUTEX(pasid_mutex);
 
-#define for_each_svm_dev(sdev, svm, d)			\
-	list_for_each_entry((sdev), &(svm)->devs, list)	\
-		if ((d) != (sdev)->dev) {} else
-
 static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 			     struct intel_svm **rsvm,
 			     struct intel_svm_dev **rsdev)
 {
-	struct intel_svm_dev *d, *sdev = NULL;
+	struct intel_svm_dev *sdev = NULL;
 	struct intel_svm *svm;
 
 	/* The caller should hold the pasid_mutex lock */
@@ -256,15 +286,7 @@ static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
 	 */
 	if (WARN_ON(list_empty(&svm->devs)))
 		return -EINVAL;
-
-	rcu_read_lock();
-	list_for_each_entry_rcu(d, &svm->devs, list) {
-		if (d->dev == dev) {
-			sdev = d;
-			break;
-		}
-	}
-	rcu_read_unlock();
+	sdev = svm_lookup_device_by_dev(svm, dev);
 
 out:
 	*rsvm = svm;
@@ -533,7 +555,8 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	}
 
 	/* Find the matching device in svm list */
-	for_each_svm_dev(sdev, svm, dev) {
+	sdev = svm_lookup_device_by_dev(svm, dev);
+	if (sdev) {
 		sdev->users++;
 		goto success;
 	}
@@ -901,19 +924,8 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 			}
 		}
 
-		if (!sdev || sdev->sid != req->rid) {
-			struct intel_svm_dev *t;
-
-			sdev = NULL;
-			rcu_read_lock();
-			list_for_each_entry_rcu(t, &svm->devs, list) {
-				if (t->sid == req->rid) {
-					sdev = t;
-					break;
-				}
-			}
-			rcu_read_unlock();
-		}
+		if (!sdev || sdev->sid != req->rid)
+			sdev = svm_lookup_device_by_sid(svm, req->rid);
 
 		/* Since we're using init_mm.pgd directly, we should never take
 		 * any faults on kernel addresses. */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
