Return-Path: <SRS0=ASoY=BD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F1BC433E4
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 19:54:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1DC206F0
	for <iommu@archiver.kernel.org>; Fri, 24 Jul 2020 19:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1DC206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5F98087216;
	Fri, 24 Jul 2020 19:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B5RJHIqSGIpa; Fri, 24 Jul 2020 19:54:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D4FA387212;
	Fri, 24 Jul 2020 19:54:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C19FCC004D;
	Fri, 24 Jul 2020 19:54:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB555C004C
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 19:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D619488B38
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 19:54:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zM-OUurEzAXP for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jul 2020 19:54:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9BB0D88B21
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jul 2020 19:54:18 +0000 (UTC)
IronPort-SDR: gA4GNzN7RpBa0PBXZiTPWv4R49tegXGi94yoz5YzZp9TxW6hNVWFchRmRNBsj2M7y6nlU78nkj
 w2O417133aqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="235646606"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; d="scan'208";a="235646606"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2020 12:54:18 -0700
IronPort-SDR: QXkEYQK+XSE+eS8ijzYw1EAeQe9zogS1CW+KZIvNY0xFCLmux4jeA6ITctuk8xnKtlJcqaw5rf
 3k210CZXskzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; d="scan'208";a="433183901"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
 by orsmga004.jf.intel.com with ESMTP; 24 Jul 2020 12:54:17 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org,
	joro@8bytes.org
Subject: [PATCH V5 1/3] iommu: Add support to change default domain of an
 iommu group
Date: Fri, 24 Jul 2020 12:51:58 -0700
Message-Id: <458786ba5883eaab3aea51ae2fdc7f5dbe71284a.1595619936.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
References: <cover.1595619936.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Presently, the default domain of an iommu group is allocated during boot
time and it cannot be changed later. So, the device would typically be
either in identity (also known as pass_through) mode or the device would be
in DMA mode as long as the machine is up and running. There is no way to
change the default domain type dynamically i.e. after booting, a device
cannot switch between identity mode and DMA mode.

But, assume a use case wherein the user trusts the device and believes that
the OS is secure enough and hence wants *only* this device to bypass IOMMU
(so that it could be high performing) whereas all the other devices to go
through IOMMU (so that the system is protected). Presently, this use case
is not supported. It will be helpful if there is some way to change the
default domain of an iommu group dynamically. Hence, add such support.

A privileged user could request the kernel to change the default domain
type of a iommu group by writing to
"/sys/kernel/iommu_groups/<grp_id>/type" file. Presently, only three values
are supported
1. identity: all the DMA transactions from the device in this group are
             *not* translated by the iommu
2. DMA: all the DMA transactions from the device in this group are
        translated by the iommu
3. auto: change to the type the device was booted with

Note:
1. Default domain of an iommu group with two or more devices cannot be
   changed.
2. The device in the iommu group shouldn't be bound to any driver.
3. The device shouldn't be assigned to user for direct access.
4. The vendor iommu driver is required to add def_domain_type() callback.
   The change request will fail if the request type conflicts with that
   returned from the callback.

Please see "Documentation/ABI/testing/sysfs-kernel-iommu_groups" for more
information.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/iommu.c | 225 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 224 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 31fd91717ec5..939b37727722 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -93,6 +93,8 @@ static void __iommu_detach_group(struct iommu_domain *domain,
 static int iommu_create_device_direct_mappings(struct iommu_group *group,
 					       struct device *dev);
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
+static ssize_t iommu_group_store_type(struct iommu_group *group,
+				      const char *buf, size_t count);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -525,7 +527,8 @@ static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 static IOMMU_GROUP_ATTR(reserved_regions, 0444,
 			iommu_group_show_resv_regions, NULL);
 
-static IOMMU_GROUP_ATTR(type, 0444, iommu_group_show_type, NULL);
+static IOMMU_GROUP_ATTR(type, 0644, iommu_group_show_type,
+			iommu_group_store_type);
 
 static void iommu_group_release(struct kobject *kobj)
 {
@@ -2849,3 +2852,223 @@ int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return ops->sva_get_pasid(handle);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
+
+/*
+ * Changes the default domain of an iommu group that has *only* one device
+ *
+ * @group: The group for which the default domain should be changed
+ * @prev_dev: The device in the group (this is used to make sure that the device
+ *	 hasn't changed after the caller has called this function)
+ * @type: The type of the new default domain that gets associated with the group
+ *
+ * Returns 0 on success and error code on failure
+ *
+ * Note:
+ * 1. Presently, this function is called only when user requests to change the
+ *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
+ *    Please take a closer look if intended to use for other purposes.
+ */
+static int iommu_change_dev_def_domain(struct iommu_group *group,
+				       struct device *prev_dev, int type)
+{
+	struct iommu_domain *prev_dom;
+	struct group_device *grp_dev;
+	const struct iommu_ops *ops;
+	int ret, dev_def_dom;
+	struct device *dev;
+
+	if (!group)
+		return -EINVAL;
+
+	mutex_lock(&group->mutex);
+
+	if (group->default_domain != group->domain) {
+		pr_err_ratelimited("Group not assigned to default domain\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * iommu group wasn't locked while acquiring device lock in
+	 * iommu_group_store_type(). So, make sure that the device count hasn't
+	 * changed while acquiring device lock.
+	 *
+	 * Changing default domain of an iommu group with two or more devices
+	 * isn't supported because there could be a potential deadlock. Consider
+	 * the following scenario. T1 is trying to acquire device locks of all
+	 * the devices in the group and before it could acquire all of them,
+	 * there could be another thread T2 (from different sub-system and use
+	 * case) that has already acquired some of the device locks and might be
+	 * waiting for T1 to release other device locks.
+	 */
+	if (iommu_group_device_count(group) != 1) {
+		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Since group has only one device */
+	grp_dev = list_first_entry(&group->devices, struct group_device, list);
+	dev = grp_dev->dev;
+
+	if (prev_dev != dev) {
+		pr_err_ratelimited("Cannot change default domain: Device has been changed\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	prev_dom = group->default_domain;
+	if (!prev_dom || !prev_dom->ops || !prev_dom->ops->def_domain_type) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ops = prev_dom->ops;
+	dev_def_dom = ops->def_domain_type(dev);
+
+	/* Check if user requested domain is supported by the device or not */
+	if (!type) {
+		/*
+		 * If the user hasn't requested any specific type of domain and
+		 * if the device supports both the domains, then default to the
+		 * domain the device was booted with
+		 */
+		type = dev_def_dom ?: iommu_def_domain_type;
+	} else if (dev_def_dom && type != dev_def_dom) {
+		pr_err_ratelimited("Device cannot be in %s domain\n",
+				   iommu_domain_type_str(type));
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Switch to a new domain only if the requested domain type is different
+	 * from the existing default domain type
+	 */
+	if (prev_dom->type == type) {
+		ret = 0;
+		goto out;
+	}
+
+	/* Sets group->default_domain to the newly allocated domain */
+	ret = iommu_group_alloc_default_domain(dev->bus, group, type);
+	if (ret)
+		goto out;
+
+	ret = iommu_create_device_direct_mappings(group, dev);
+	if (ret)
+		goto free_new_domain;
+
+	ret = __iommu_attach_device(group->default_domain, dev);
+	if (ret)
+		goto free_new_domain;
+
+	group->domain = group->default_domain;
+
+	/*
+	 * Release the mutex here because ops->probe_finalize() call-back of
+	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
+	 * in-turn might call back into IOMMU core code, where it tries to take
+	 * group->mutex, resulting in a deadlock.
+	 */
+	mutex_unlock(&group->mutex);
+
+	/* Make sure dma_ops is appropriatley set */
+	iommu_group_do_probe_finalize(dev, group->default_domain);
+	iommu_domain_free(prev_dom);
+	return 0;
+
+free_new_domain:
+	iommu_domain_free(group->default_domain);
+	group->default_domain = prev_dom;
+	group->domain = prev_dom;
+
+out:
+	mutex_unlock(&group->mutex);
+
+	return ret;
+}
+
+static ssize_t iommu_group_store_type(struct iommu_group *group,
+				      const char *buf, size_t count)
+{
+	struct group_device *grp_dev;
+	struct device *dev;
+	int ret, req_type;
+
+	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+		return -EACCES;
+
+	if (WARN_ON(!group))
+		return -EINVAL;
+
+	if (sysfs_streq(buf, "identity"))
+		req_type = IOMMU_DOMAIN_IDENTITY;
+	else if (sysfs_streq(buf, "DMA"))
+		req_type = IOMMU_DOMAIN_DMA;
+	else if (sysfs_streq(buf, "auto"))
+		req_type = 0;
+	else
+		return -EINVAL;
+
+	/*
+	 * Lock/Unlock the group mutex here before device lock to
+	 * 1. Make sure that the iommu group has only one device (this is a
+	 *    prerequisite for step 2)
+	 * 2. Get struct *dev which is needed to lock device
+	 */
+	mutex_lock(&group->mutex);
+	if (iommu_group_device_count(group) != 1) {
+		mutex_unlock(&group->mutex);
+		pr_err_ratelimited("Cannot change default domain: Group has more than one device\n");
+		return -EINVAL;
+	}
+
+	/* Since group has only one device */
+	grp_dev = list_first_entry(&group->devices, struct group_device, list);
+	dev = grp_dev->dev;
+	get_device(dev);
+
+	/*
+	 * Don't hold the group mutex because taking group mutex first and then
+	 * the device lock could potentially cause a deadlock as below. Assume
+	 * two threads T1 and T2. T1 is trying to change default domain of an
+	 * iommu group and T2 is trying to hot unplug a device or release [1] VF
+	 * of a PCIe device which is in the same iommu group. T1 takes group
+	 * mutex and before it could take device lock assume T2 has taken device
+	 * lock and is yet to take group mutex. Now, both the threads will be
+	 * waiting for the other thread to release lock. Below, lock order was
+	 * suggested.
+	 * device_lock(dev);
+	 *	mutex_lock(&group->mutex);
+	 *		iommu_change_dev_def_domain();
+	 *	mutex_unlock(&group->mutex);
+	 * device_unlock(dev);
+	 *
+	 * [1] Typical device release path
+	 * device_lock() from device/driver core code
+	 *  -> bus_notifier()
+	 *   -> iommu_bus_notifier()
+	 *    -> iommu_release_device()
+	 *     -> ops->release_device() vendor driver calls back iommu core code
+	 *      -> mutex_lock() from iommu core code
+	 */
+	mutex_unlock(&group->mutex);
+
+	/* Check if the device in the group still has a driver bound to it */
+	device_lock(dev);
+	if (device_is_bound(dev)) {
+		pr_err_ratelimited("Device is still bound to driver\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = iommu_change_dev_def_domain(group, dev, req_type);
+	ret = ret ?: count;
+
+out:
+	device_unlock(dev);
+	put_device(dev);
+
+	return ret;
+}
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
