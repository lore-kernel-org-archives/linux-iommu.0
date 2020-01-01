Return-Path: <SRS0=GLpr=2W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E88C32764
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 05:37:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202F52072C
	for <iommu@archiver.kernel.org>; Wed,  1 Jan 2020 05:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202F52072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D811689539;
	Wed,  1 Jan 2020 05:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e2XpG0Y9P764; Wed,  1 Jan 2020 05:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6D316894AC;
	Wed,  1 Jan 2020 05:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5954DC18DC;
	Wed,  1 Jan 2020 05:37:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4901EC077D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 05:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 41CD3887D9
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 05:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1ruV-VoFvR6G for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jan 2020 05:28:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7156D8874C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jan 2020 05:28:27 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Dec 2019 21:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,382,1571727600"; d="scan'208";a="244319519"
Received: from allen-box.sh.intel.com ([10.239.159.136])
 by fmsmga004.fm.intel.com with ESMTP; 31 Dec 2019 21:28:25 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [RFC PATCH 3/4] iommu: Preallocate iommu group when probing devices
Date: Wed,  1 Jan 2020 13:26:47 +0800
Message-Id: <20200101052648.14295-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200101052648.14295-1-baolu.lu@linux.intel.com>
References: <20200101052648.14295-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

This splits iommu group allocation from adding devices. This makes
it possible to determine the default domain type for each group as
all devices belonging to the group have been determined.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 92 +++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index fdd40756dbc1..716326a2ee5b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -49,6 +49,7 @@ struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
+	bool added;
 };
 
 struct iommu_group_attribute {
@@ -176,7 +177,6 @@ int iommu_probe_device(struct device *dev)
 	const struct iommu_ops *ops = dev->bus->iommu_ops;
 	int ret;
 
-	WARN_ON(dev->iommu_group);
 	if (!ops)
 		return -EINVAL;
 
@@ -686,13 +686,28 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 {
 	int ret, i = 0;
-	struct group_device *device;
+	struct group_device *device = NULL;
 
-	device = kzalloc(sizeof(*device), GFP_KERNEL);
-	if (!device)
-		return -ENOMEM;
+	mutex_lock(&group->mutex);
+	list_for_each_entry(device, &group->devices, list) {
+		if (device->dev == dev)
+			break;
+	}
+	mutex_unlock(&group->mutex);
 
-	device->dev = dev;
+	if (!device || device->dev != dev) {
+		device = kzalloc(sizeof(*device), GFP_KERNEL);
+		if (!device)
+			return -ENOMEM;
+
+		device->dev = dev;
+		mutex_lock(&group->mutex);
+		list_add_tail(&device->list, &group->devices);
+		mutex_unlock(&group->mutex);
+	} else if (device->added) {
+		kobject_get(group->devices_kobj);
+		return 0;
+	}
 
 	ret = sysfs_create_link(&dev->kobj, &group->kobj, "iommu_group");
 	if (ret)
@@ -728,13 +743,14 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	iommu_group_create_direct_mappings(group, dev);
 
 	mutex_lock(&group->mutex);
-	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
 		ret = __iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
 	if (ret)
 		goto err_put_group;
 
+	device->added = true;
+
 	/* Notify any listeners about change to group. */
 	blocking_notifier_call_chain(&group->notifier,
 				     IOMMU_GROUP_NOTIFY_ADD_DEVICE, dev);
@@ -746,16 +762,16 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	return 0;
 
 err_put_group:
-	mutex_lock(&group->mutex);
-	list_del(&device->list);
-	mutex_unlock(&group->mutex);
-	dev->iommu_group = NULL;
 	kobject_put(group->devices_kobj);
 err_free_name:
 	kfree(device->name);
 err_remove_link:
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 err_free_device:
+	mutex_lock(&group->mutex);
+	list_del(&device->list);
+	mutex_unlock(&group->mutex);
+	dev->iommu_group = NULL;
 	kfree(device);
 	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
 	return ret;
@@ -1339,6 +1355,34 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
 	return group;
 }
 
+static int alloc_iommu_group(struct device *dev, void *data)
+{
+	const struct iommu_ops *ops = dev->bus->iommu_ops;
+	struct group_device *device;
+	struct iommu_group *group;
+
+	if (!ops || WARN_ON(dev->iommu_group))
+		return -EINVAL;
+
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (!device)
+		return -ENOMEM;
+
+	group = ops->device_group(dev);
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(group))) {
+		kfree(device);
+		return -EINVAL;
+	}
+
+	device->dev = dev;
+	dev->iommu_group = group;
+	mutex_lock(&group->mutex);
+	list_add_tail(&device->list, &group->devices);
+	mutex_unlock(&group->mutex);
+
+	return 0;
+}
+
 /**
  * iommu_group_get_for_dev - Find or create the IOMMU group for a device
  * @dev: target device
@@ -1351,23 +1395,15 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
  */
 struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 {
-	const struct iommu_ops *ops = dev->bus->iommu_ops;
-	struct iommu_group *group;
+	struct iommu_group *group = dev->iommu_group;
 	int ret;
 
-	group = iommu_group_get(dev);
-	if (group)
-		return group;
-
-	if (!ops)
-		return ERR_PTR(-EINVAL);
-
-	group = ops->device_group(dev);
-	if (WARN_ON_ONCE(group == NULL))
-		return ERR_PTR(-EINVAL);
-
-	if (IS_ERR(group))
-		return group;
+	if (!group) {
+		ret = alloc_iommu_group(dev, NULL);
+		if (ret)
+			return ERR_PTR(ret);
+		group = dev->iommu_group;
+	}
 
 	/*
 	 * Try to allocate a default domain - needs support from the
@@ -1501,6 +1537,10 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	if (err)
 		goto out_free;
 
+	err = bus_for_each_dev(bus, NULL, NULL, alloc_iommu_group);
+	if (err)
+		goto out_err;
+
 	err = bus_for_each_dev(bus, NULL, NULL, add_iommu_group);
 	if (err)
 		goto out_err;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
