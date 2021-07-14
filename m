Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A12DC07E9A
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 10:42:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA046128B
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 10:42:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA046128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8170983C23;
	Wed, 14 Jul 2021 10:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XYC8xa-Ovudy; Wed, 14 Jul 2021 10:42:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5367983BF1;
	Wed, 14 Jul 2021 10:42:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 278C4C000E;
	Wed, 14 Jul 2021 10:42:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C6D2C001A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 10:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E28960670
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 10:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3rFXSDX4CRy8 for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 10:42:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 402CF606DB
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 10:42:09 +0000 (UTC)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GPv414CRZz6FCyR;
 Wed, 14 Jul 2021 18:33:37 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 12:42:07 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 14 Jul 2021 11:41:59 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <baolu.lu@linux.intel.com>
Subject: [PATCH v4 3/6] iommu: Allow iommu_change_dev_def_domain() realloc
 default domain for same type
Date: Wed, 14 Jul 2021 18:36:40 +0800
Message-ID: <1626259003-201303-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com, mst@redhat.com,
 airlied@linux.ie, gregkh@linuxfoundation.org, jasowang@redhat.com,
 linuxarm@huawei.com, jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, daniel@ffwll.ch, bingbu.cao@intel.com,
 digetx@gmail.com, mchehab@kernel.org, tian.shu.qiu@intel.com
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

Allow iommu_change_dev_def_domain() to create a new default domain, keeping
the same as current when type is unset.

Also remove comment about function purpose, which will become stale.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 54 ++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8a815ac261f0..d8198a9aff4e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3036,6 +3036,7 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
+
 /*
  * Changes the default domain of an iommu group that has *only* one device
  *
@@ -3043,16 +3044,13 @@ EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
  * @prev_dev: The device in the group (this is used to make sure that the device
  *	 hasn't changed after the caller has called this function)
  * @type: The type of the new default domain that gets associated with the group
+ * @new: Allocate new default domain, keeping same type when no type passed
  *
  * Returns 0 on success and error code on failure
  *
- * Note:
- * 1. Presently, this function is called only when user requests to change the
- *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
- *    Please take a closer look if intended to use for other purposes.
  */
 static int iommu_change_dev_def_domain(struct iommu_group *group,
-				       struct device *prev_dev, int type)
+				       struct device *prev_dev, int type, bool new)
 {
 	struct iommu_domain *prev_dom;
 	struct group_device *grp_dev;
@@ -3102,28 +3100,32 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 		goto out;
 	}
 
-	dev_def_dom = iommu_get_def_domain_type(dev);
-	if (!type) {
+	if (new && !type) {
+		type = prev_dom->type;
+	} else {
+		dev_def_dom = iommu_get_def_domain_type(dev);
+		if (!type) {
+			/*
+			 * If the user hasn't requested any specific type of domain and
+			 * if the device supports both the domains, then default to the
+			 * domain the device was booted with
+			 */
+			type = dev_def_dom ? : iommu_def_domain_type;
+		} else if (dev_def_dom && type != dev_def_dom) {
+			dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
+					    iommu_domain_type_str(type));
+			ret = -EINVAL;
+			goto out;
+		}
+
 		/*
-		 * If the user hasn't requested any specific type of domain and
-		 * if the device supports both the domains, then default to the
-		 * domain the device was booted with
+		 * Switch to a new domain only if the requested domain type is different
+		 * from the existing default domain type
 		 */
-		type = dev_def_dom ? : iommu_def_domain_type;
-	} else if (dev_def_dom && type != dev_def_dom) {
-		dev_err_ratelimited(prev_dev, "Device cannot be in %s domain\n",
-				    iommu_domain_type_str(type));
-		ret = -EINVAL;
-		goto out;
-	}
-
-	/*
-	 * Switch to a new domain only if the requested domain type is different
-	 * from the existing default domain type
-	 */
-	if (prev_dom->type == type) {
-		ret = 0;
-		goto out;
+		if (prev_dom->type == type) {
+			ret = 0;
+			goto out;
+		}
 	}
 
 	/* Sets group->default_domain to the newly allocated domain */
@@ -3267,7 +3269,7 @@ static int iommu_group_store_type_cb(const char *buf,
 	else
 		return -EINVAL;
 
-	return iommu_change_dev_def_domain(group, dev, type);
+	return iommu_change_dev_def_domain(group, dev, type, false);
 }
 
 static ssize_t iommu_group_store_type(struct iommu_group *group,
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
