Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7DEC47080
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D9B613A9
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D9B613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EC5F4040D;
	Tue,  1 Jun 2021 14:34:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L44qvwpjQ4UP; Tue,  1 Jun 2021 14:34:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 110AF402AE;
	Tue,  1 Jun 2021 14:34:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1A84C000D;
	Tue,  1 Jun 2021 14:34:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D217C0001
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A7BB60758
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HFfd2ddqMO1K for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 14:34:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 18373607DE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:18 +0000 (UTC)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvZJ332JKz6Q3M3;
 Tue,  1 Jun 2021 22:27:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:34:16 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:34:14 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 3/7] iommu: Allow iommu_change_dev_def_domain() realloc
 default domain for same type
Date: Tue, 1 Jun 2021 22:29:37 +0800
Message-ID: <1622557781-211697-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
References: <1622557781-211697-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linuxarm@huawei.com,
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
index 4d12b607918c..8bf2abb3d4c1 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3036,6 +3036,7 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
 
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
@@ -3105,28 +3103,32 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
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
@@ -3270,7 +3272,7 @@ static int iommu_group_store_type_cb(const char *buf,
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
