Return-Path: <SRS0=UGJ5=K3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AEEC47093
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E749613AE
	for <iommu@archiver.kernel.org>; Tue,  1 Jun 2021 14:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E749613AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 12431402CB;
	Tue,  1 Jun 2021 14:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7inLX8oSuQ5u; Tue,  1 Jun 2021 14:34:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id BEC72402AE;
	Tue,  1 Jun 2021 14:34:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 919E3C000F;
	Tue,  1 Jun 2021 14:34:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7594C0024
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 99A7860704
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vTg4GtUvHkQ7 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 14:34:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99F6060758
 for <iommu@lists.linux-foundation.org>; Tue,  1 Jun 2021 14:34:14 +0000 (UTC)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FvZF1602Bz6T0qy;
 Tue,  1 Jun 2021 22:25:09 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 16:34:11 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 15:34:09 +0100
From: John Garry <john.garry@huawei.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v3 1/7] iommu: Reactor iommu_group_store_type()
Date: Tue, 1 Jun 2021 22:29:35 +0800
Message-ID: <1622557781-211697-2-git-send-email-john.garry@huawei.com>
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

Function iommu_group_store_type() supports changing the default domain
of an IOMMU group.

Many conditions need to be satisfied and steps taken for this action to be
successful.

Satisfying these conditions and steps will be required for setting other
IOMMU group attributes, so factor into a common part and a part specific
to update the IOMMU group attribute.

No functional change intended.

Some code comments are tidied up also.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/iommu.c | 73 +++++++++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 808ab70d5df5..4d12b607918c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3169,20 +3169,23 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 }
 
 /*
- * Changing the default domain through sysfs requires the users to ubind the
- * drivers from the devices in the iommu group. Return failure if this doesn't
- * meet.
+ * Changing the default domain or any other IOMMU group attribute through sysfs
+ * requires the users to unbind the drivers from the devices in the IOMMU group.
+ * Return failure if this precondition is not met.
  *
  * We need to consider the race between this and the device release path.
  * device_lock(dev) is used here to guarantee that the device release path
  * will not be entered at the same time.
  */
-static ssize_t iommu_group_store_type(struct iommu_group *group,
-				      const char *buf, size_t count)
+static ssize_t iommu_group_store_common(struct iommu_group *group,
+					const char *buf, size_t count,
+					int (*cb)(const char *buf,
+						  struct iommu_group *group,
+						  struct device *dev))
 {
 	struct group_device *grp_dev;
 	struct device *dev;
-	int ret, req_type;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
@@ -3190,25 +3193,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	if (WARN_ON(!group))
 		return -EINVAL;
 
-	if (sysfs_streq(buf, "identity"))
-		req_type = IOMMU_DOMAIN_IDENTITY;
-	else if (sysfs_streq(buf, "DMA"))
-		req_type = IOMMU_DOMAIN_DMA;
-	else if (sysfs_streq(buf, "auto"))
-		req_type = 0;
-	else
-		return -EINVAL;
-
 	/*
 	 * Lock/Unlock the group mutex here before device lock to
-	 * 1. Make sure that the iommu group has only one device (this is a
+	 * 1. Make sure that the IOMMU group has only one device (this is a
 	 *    prerequisite for step 2)
 	 * 2. Get struct *dev which is needed to lock device
 	 */
 	mutex_lock(&group->mutex);
 	if (iommu_group_device_count(group) != 1) {
 		mutex_unlock(&group->mutex);
-		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
+		pr_err_ratelimited("Cannot change IOMMU group default domain attribute: Group has more than one device\n");
 		return -EINVAL;
 	}
 
@@ -3220,16 +3214,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	/*
 	 * Don't hold the group mutex because taking group mutex first and then
 	 * the device lock could potentially cause a deadlock as below. Assume
-	 * two threads T1 and T2. T1 is trying to change default domain of an
-	 * iommu group and T2 is trying to hot unplug a device or release [1] VF
-	 * of a PCIe device which is in the same iommu group. T1 takes group
-	 * mutex and before it could take device lock assume T2 has taken device
-	 * lock and is yet to take group mutex. Now, both the threads will be
-	 * waiting for the other thread to release lock. Below, lock order was
-	 * suggested.
+	 * two threads, T1 and T2. T1 is trying to change default domain
+	 * attribute of an IOMMU group and T2 is trying to hot unplug a device
+	 * or release [1] VF of a PCIe device which is in the same IOMMU group.
+	 * T1 takes the group mutex and before it could take device lock T2 may
+	 * have taken device lock and is yet to take group mutex. Now, both the
+	 * threads will be waiting for the other thread to release lock. Below,
+	 * lock order was suggested.
 	 * device_lock(dev);
 	 *	mutex_lock(&group->mutex);
-	 *		iommu_change_dev_def_domain();
+	 *		cb->iommu_change_dev_def_domain(); [example cb]
 	 *	mutex_unlock(&group->mutex);
 	 * device_unlock(dev);
 	 *
@@ -3243,7 +3237,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	 */
 	mutex_unlock(&group->mutex);
 
-	/* Check if the device in the group still has a driver bound to it */
+	/* Check if the only device in the group still has a driver bound */
 	device_lock(dev);
 	if (device_is_bound(dev)) {
 		pr_err_ratelimited("Device is still bound to driver\n");
@@ -3251,7 +3245,7 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		goto out;
 	}
 
-	ret = iommu_change_dev_def_domain(group, dev, req_type);
+	ret = (cb)(buf, group, dev);
 	ret = ret ?: count;
 
 out:
@@ -3260,3 +3254,28 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 
 	return ret;
 }
+
+static int iommu_group_store_type_cb(const char *buf,
+				     struct iommu_group *group,
+				     struct device *dev)
+{
+	int type;
+
+	if (sysfs_streq(buf, "identity"))
+		type = IOMMU_DOMAIN_IDENTITY;
+	else if (sysfs_streq(buf, "DMA"))
+		type = IOMMU_DOMAIN_DMA;
+	else if (sysfs_streq(buf, "auto"))
+		type = 0;
+	else
+		return -EINVAL;
+
+	return iommu_change_dev_def_domain(group, dev, type);
+}
+
+static ssize_t iommu_group_store_type(struct iommu_group *group,
+				      const char *buf, size_t count)
+{
+	return iommu_group_store_common(group, buf, count,
+					iommu_group_store_type_cb);
+}
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
