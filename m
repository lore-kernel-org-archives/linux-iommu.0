Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC1AC433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 00:30:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A480E20739
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 00:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A480E20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8AAC586C31;
	Mon,  6 Jul 2020 00:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bqe1V3-PmB_z; Mon,  6 Jul 2020 00:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D673D86BFE;
	Mon,  6 Jul 2020 00:30:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1C37C0893;
	Mon,  6 Jul 2020 00:30:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB83FC016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 00:30:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AD9CE88B62
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 00:30:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GgB4l1qpEK3a for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 00:30:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9225F88B15
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 00:30:14 +0000 (UTC)
IronPort-SDR: RKIy2nU80tmO2NKVdundgJgABt7t42a1pwjEVPAdyefyzYvCQJbUHbI79i58b3KyWVdZO3Gx4z
 vyFhQne3do5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="126935681"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="126935681"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2020 17:30:14 -0700
IronPort-SDR: 1E76M8NLXV92IZXxlf/PJ3DW/L+I3BDyc/MqAzSXB6ajGTXM3Y5EB4OpJur6RJEQGse8LF6f4F
 BA58gU3avbaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; d="scan'208";a="266404952"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2020 17:30:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/4] iommu/vt-d: Add a helper to get svm and sdev for pasid
Date: Mon,  6 Jul 2020 08:25:33 +0800
Message-Id: <20200706002535.9381-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706002535.9381-1-baolu.lu@linux.intel.com>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
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

There are several places in the code that need to get the pointers of
svm and sdev according to a pasid and device. Add a helper to achieve
this for code consolidation and readability.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 121 +++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 25dd74f27252..c23167877b2b 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -228,6 +228,50 @@ static LIST_HEAD(global_svm_list);
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
@@ -261,39 +305,27 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(NULL, data->hpasid, NULL);
-	if (IS_ERR(svm)) {
-		ret = PTR_ERR(svm);
+	ret = pasid_to_svm_sdev(dev, data->hpasid, &svm, &sdev);
+	if (ret)
 		goto out;
-	}
 
-	if (svm) {
+	if (sdev) {
 		/*
-		 * If we found svm for the PASID, there must be at
-		 * least one device bond, otherwise svm should be freed.
+		 * For devices with aux domains, we should allow
+		 * multiple bind calls with the same PASID and pdev.
 		 */
-		if (WARN_ON(list_empty(&svm->devs))) {
-			ret = -EINVAL;
-			goto out;
+		if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)) {
+			sdev->users++;
+		} else {
+			dev_warn_ratelimited(dev,
+					     "Already bound with PASID %u\n",
+					     svm->pasid);
+			ret = -EBUSY;
 		}
+		goto out;
+	}
 
-		for_each_svm_dev(sdev, svm, dev) {
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
-			goto out;
-		}
-	} else {
+	if (!svm) {
 		/* We come here when PASID has never been bond to a device. */
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm) {
@@ -376,25 +408,17 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
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
@@ -418,7 +442,6 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				kfree(svm);
 			}
 		}
-		break;
 	}
 out:
 	mutex_unlock(&pasid_mutex);
@@ -596,7 +619,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 	if (sd)
 		*sd = sdev;
 	ret = 0;
- out:
+out:
 	return ret;
 }
 
@@ -612,17 +635,11 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
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
@@ -651,10 +668,8 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
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
