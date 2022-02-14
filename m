Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D739C433EF
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 17:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2B08411C6;
	Mon, 14 Feb 2022 17:34:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pQ2RASw1VpRN; Mon, 14 Feb 2022 17:34:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 795D3410CB;
	Mon, 14 Feb 2022 17:34:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 611F0C001A;
	Mon, 14 Feb 2022 17:34:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD8D3C000B;
 Mon, 14 Feb 2022 17:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B4F1410D8;
 Mon, 14 Feb 2022 17:34:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XZsKQnSB36UK; Mon, 14 Feb 2022 17:34:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9291A4098E;
 Mon, 14 Feb 2022 17:34:53 +0000 (UTC)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JyBCr4BLMz6H71g;
 Tue, 15 Feb 2022 01:34:00 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 18:34:51 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Feb 2022 17:34:47 +0000
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
Subject: [PATCH v5 1/5] iommu: Refactor iommu_group_store_type()
Date: Tue, 15 Feb 2022 01:29:02 +0800
Message-ID: <1644859746-20279-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
References: <1644859746-20279-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: mst@redhat.com, jasowang@redhat.com, linuxarm@huawei.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux-foundation.org, hch@lst.de
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
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
 drivers/iommu/iommu.c | 96 ++++++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 107dcf5938d6..5e7ed969b870 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3261,21 +3261,57 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	return ret;
 }
 
+enum iommu_group_op {
+	CHANGE_GROUP_TYPE,
+};
+
+static int __iommu_group_store_type(const char *buf, struct iommu_group *group,
+				    struct device *dev)
+{
+	int type;
+
+	if (sysfs_streq(buf, "identity"))
+		type = IOMMU_DOMAIN_IDENTITY;
+	else if (sysfs_streq(buf, "DMA"))
+		type = IOMMU_DOMAIN_DMA;
+	else if (sysfs_streq(buf, "DMA-FQ"))
+		type = IOMMU_DOMAIN_DMA_FQ;
+	else if (sysfs_streq(buf, "auto"))
+		type = 0;
+	else
+		return -EINVAL;
+
+	/*
+	 * Check if the only device in the group still has a driver bound or
+	 * we're transistioning from DMA -> DMA-FQ
+	 */
+	if (device_is_bound(dev) && !(type == IOMMU_DOMAIN_DMA_FQ &&
+	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
+		pr_err_ratelimited("Device is still bound to driver\n");
+		return -EINVAL;
+	}
+
+	return iommu_change_dev_def_domain(group, dev, type);
+}
+
 /*
  * Changing the default domain through sysfs requires the users to unbind the
  * drivers from the devices in the iommu group, except for a DMA -> DMA-FQ
- * transition. Return failure if this isn't met.
+ * transition. Changing or any other IOMMU group attribute still requires the
+ * user to unbind the drivers from the devices in the iommu group. Return
+ * failure if these conditions are not met.
  *
  * We need to consider the race between this and the device release path.
  * device_lock(dev) is used here to guarantee that the device release path
  * will not be entered at the same time.
  */
-static ssize_t iommu_group_store_type(struct iommu_group *group,
-				      const char *buf, size_t count)
+static ssize_t iommu_group_store_common(struct iommu_group *group,
+					enum iommu_group_op op,
+					const char *buf, size_t count)
 {
 	struct group_device *grp_dev;
 	struct device *dev;
-	int ret, req_type;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
 		return -EACCES;
@@ -3283,27 +3319,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	if (WARN_ON(!group))
 		return -EINVAL;
 
-	if (sysfs_streq(buf, "identity"))
-		req_type = IOMMU_DOMAIN_IDENTITY;
-	else if (sysfs_streq(buf, "DMA"))
-		req_type = IOMMU_DOMAIN_DMA;
-	else if (sysfs_streq(buf, "DMA-FQ"))
-		req_type = IOMMU_DOMAIN_DMA_FQ;
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
 
@@ -3315,16 +3340,16 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
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
@@ -3338,21 +3363,24 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 	 */
 	mutex_unlock(&group->mutex);
 
-	/* Check if the device in the group still has a driver bound to it */
 	device_lock(dev);
-	if (device_is_bound(dev) && !(req_type == IOMMU_DOMAIN_DMA_FQ &&
-	    group->default_domain->type == IOMMU_DOMAIN_DMA)) {
-		pr_err_ratelimited("Device is still bound to driver\n");
-		ret = -EBUSY;
-		goto out;
+	switch (op) {
+	case CHANGE_GROUP_TYPE:
+		ret = __iommu_group_store_type(buf, group, dev);
+		break;
+	default:
+		ret = -EINVAL;
 	}
-
-	ret = iommu_change_dev_def_domain(group, dev, req_type);
 	ret = ret ?: count;
 
-out:
 	device_unlock(dev);
 	put_device(dev);
 
 	return ret;
 }
+
+static ssize_t iommu_group_store_type(struct iommu_group *group,
+				      const char *buf, size_t count)
+{
+	return iommu_group_store_common(group, CHANGE_GROUP_TYPE, buf, count);
+}
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
