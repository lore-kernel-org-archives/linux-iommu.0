Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F269C433F2
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8EE2086A
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 01:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8EE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E25A086DF3;
	Fri, 24 Jul 2020 01:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wji-_4tLLTDv; Fri, 24 Jul 2020 01:54:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4B8FA86DE5;
	Fri, 24 Jul 2020 01:54:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39BAFC004E;
	Fri, 24 Jul 2020 01:54:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23003C004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1308387E76
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mH1CO-Y8Z7+o for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 01:54:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5BB7488222
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 01:54:40 +0000 (UTC)
IronPort-SDR: cW+OrerGYpoNId/ezJuqbOo1JnDyYiPTo0Ot7wzaf4cRi/SMa8UDeyCATcRFOTo6wdl/OC2IJl
 bqMmUTZal/vw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="168778786"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="168778786"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2020 18:54:40 -0700
IronPort-SDR: 4urPSF6nT8ElU7xS45lzGp+PyQRso8trVBriHQBgaGMe2VaFKqBe2Ulmi1x1KVOfPN+PcZvO0r
 XCQaowkeUBGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; d="scan'208";a="488576780"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2020 18:54:38 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 09/12] iommu/vt-d: Add a helper to get svm and sdev for pasid
Date: Fri, 24 Jul 2020 09:49:22 +0800
Message-Id: <20200724014925.15523-10-baolu.lu@linux.intel.com>
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

There are several places in the code that need to get the pointers of
svm and sdev according to a pasid and device. Add a helper to achieve
this for code consolidation and readability.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/svm.c | 115 +++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 65d2327dcd0d..c104a50a625c 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -228,13 +228,57 @@ static LIST_HEAD(global_svm_list);
 	list_for_each_entry((sdev), &(svm)->devs, list)	\
 		if ((d) != (sdev)->dev) {} else
 
+static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
+			     struct intel_svm **rsvm,
+			     struct intel_svm_dev **rsdev)
+{
+	struct intel_svm_dev *d, *sdev = NULL;
+	struct intel_svm *svm;
+
+	/* The caller should hold the pasid_mutex lock */
+	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
+		return -EINVAL;
+
+	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
+		return -EINVAL;
+
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (IS_ERR(svm))
+		return PTR_ERR(svm);
+
+	if (!svm)
+		goto out;
+
+	/*
+	 * If we found svm for the PASID, there must be at least one device
+	 * bond.
+	 */
+	if (WARN_ON(list_empty(&svm->devs)))
+		return -EINVAL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(d, &svm->devs, list) {
+		if (d->dev == dev) {
+			sdev = d;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+out:
+	*rsvm = svm;
+	*rsdev = sdev;
+
+	return 0;
+}
+
 int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			  struct iommu_gpasid_bind_data *data)
 {
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct intel_svm_dev *sdev = NULL;
 	struct dmar_domain *dmar_domain;
-	struct intel_svm_dev *sdev;
-	struct intel_svm *svm;
+	struct intel_svm *svm = NULL;
 	int ret = 0;
 
 	if (WARN_ON(!iommu) || !data)
@@ -261,35 +305,23 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(NULL, data->hpasid, NULL);
-	if (IS_ERR(svm)) {
-		ret = PTR_ERR(svm);
+	ret = pasid_to_svm_sdev(dev, data->hpasid, &svm, &sdev);
+	if (ret)
 		goto out;
-	}
-
-	if (svm) {
-		/*
-		 * If we found svm for the PASID, there must be at
-		 * least one device bond, otherwise svm should be freed.
-		 */
-		if (WARN_ON(list_empty(&svm->devs))) {
-			ret = -EINVAL;
-			goto out;
-		}
 
+	if (sdev) {
 		/*
 		 * Do not allow multiple bindings of the same device-PASID since
 		 * there is only one SL page tables per PASID. We may revisit
 		 * once sharing PGD across domains are supported.
 		 */
-		for_each_svm_dev(sdev, svm, dev) {
-			dev_warn_ratelimited(dev,
-					     "Already bound with PASID %u\n",
-					     svm->pasid);
-			ret = -EBUSY;
-			goto out;
-		}
-	} else {
+		dev_warn_ratelimited(dev, "Already bound with PASID %u\n",
+				     svm->pasid);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (!svm) {
 		/* We come here when PASID has never been bond to a device. */
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm) {
@@ -372,25 +404,17 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
-	int ret = -EINVAL;
+	int ret;
 
 	if (WARN_ON(!iommu))
 		return -EINVAL;
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(NULL, pasid, NULL);
-	if (!svm) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (IS_ERR(svm)) {
-		ret = PTR_ERR(svm);
+	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
+	if (ret)
 		goto out;
-	}
 
-	for_each_svm_dev(sdev, svm, dev) {
-		ret = 0;
+	if (sdev) {
 		if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
 			sdev->users--;
 		if (!sdev->users) {
@@ -414,7 +438,6 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				kfree(svm);
 			}
 		}
-		break;
 	}
 out:
 	mutex_unlock(&pasid_mutex);
@@ -592,7 +615,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 	if (sd)
 		*sd = sdev;
 	ret = 0;
- out:
+out:
 	return ret;
 }
 
@@ -608,17 +631,11 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	svm = ioasid_find(NULL, pasid, NULL);
-	if (!svm)
-		goto out;
-
-	if (IS_ERR(svm)) {
-		ret = PTR_ERR(svm);
+	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
+	if (ret)
 		goto out;
-	}
 
-	for_each_svm_dev(sdev, svm, dev) {
-		ret = 0;
+	if (sdev) {
 		sdev->users--;
 		if (!sdev->users) {
 			list_del_rcu(&sdev->list);
@@ -647,10 +664,8 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
 				kfree(svm);
 			}
 		}
-		break;
 	}
- out:
-
+out:
 	return ret;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
