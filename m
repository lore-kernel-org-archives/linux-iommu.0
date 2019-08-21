Return-Path: <SRS0=Juc9=WR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07238C3A589
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 02:46:11 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D788722D6D
	for <iommu@archiver.kernel.org>; Wed, 21 Aug 2019 02:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D788722D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C1BAAA49;
	Wed, 21 Aug 2019 02:46:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9665141C
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 02:46:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B612989B
	for <iommu@lists.linux-foundation.org>;
	Wed, 21 Aug 2019 02:46:08 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 Aug 2019 19:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,410,1559545200"; d="scan'208";a="329890120"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
	by orsmga004.jf.intel.com with ESMTP; 20 Aug 2019 19:46:07 -0700
From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/4] iommu: Add support to change default domain of an
	iommu_group
Date: Tue, 20 Aug 2019 19:42:25 -0700
Message-Id: <03cbec8c95b13d417dd1c44f545241d01e7b9654.1566353521.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1566353521.git.sai.praneeth.prakhya@intel.com>
References: <cover.1566353521.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Cc: Ashok Raj <ashok.raj@intel.com>, Will Deacon <will.deacon@arm.com>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Presently, the default domain of an iommu_group is allocated during boot
time (i.e. when a device is being added to a group) and it cannot be
changed later. So, the device would typically be either in identity (also
known as pass_through) mode (controlled by "iommu=pt" kernel command line
argument) or the device would be in DMA mode as long as the machine is up
and running. There is no way to change the default domain type dynamically
i.e. after booting, a device cannot switch between identity mode and DMA
mode.

But, assume a use case where in the user trusts the device and also
believes that his OS is secure enough and hence wants *only* this device to
bypass IOMMU (so that it could be high performing) whereas all the other
devices to go through IOMMU (so that the system is protected). Presently,
this is not supported and hence it will be helpful if there is some way to
change the default domain of a B:D.F dynamically. Since, linux iommu
subsystem prefers to deal at iommu_group level instead of B:D.F level, it
might be helpful if there is some way to change the default domain of a
*iommu_group* dynamically. Hence, add such support.

A privileged user could request the kernel to change the default domain
type of a group by writing to "/sys/kernel/iommu_groups/<grp_id>/type"
file. Presently, only three values are supported
1. identity: all the DMA transactions from the devices in this group are
	     *not* translated by the iommu
2. dma: all the DMA transactions from the devices in this group are
	translated by the iommu
3. auto: kernel decides one among dma/identity

Also please note that a group type could be modified only when *all*
the devices in the group are not binded to any device driver. Please see
"Documentation/ABI/testing/sysfs-kernel-iommu_groups" for more information.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 drivers/iommu/iommu.c | 232 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 231 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 70bfbcc09248..f4a5981e570b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -155,6 +155,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group);
 static void __iommu_detach_group(struct iommu_domain *domain,
 				 struct iommu_group *group);
+static ssize_t iommu_group_store_type(struct iommu_group *group,
+				      const char *buf, size_t count);
 
 static int __init iommu_set_def_domain_type(char *str)
 {
@@ -376,7 +378,8 @@ static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 static IOMMU_GROUP_ATTR(reserved_regions, 0444,
 			iommu_group_show_resv_regions, NULL);
 
-static IOMMU_GROUP_ATTR(type, 0444, iommu_group_show_type, NULL);
+static IOMMU_GROUP_ATTR(type, 0644, iommu_group_show_type,
+			iommu_group_store_type);
 
 static void iommu_group_release(struct kobject *kobj)
 {
@@ -2470,3 +2473,230 @@ int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return ops->sva_get_pasid(handle);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
+
+/*
+ * Changes the default domain of a group. This function is heavily inspired from
+ * request_default_domain_for_dev() and couldn't re-use the same because:
+ * 1. The domain should be changed even if there are devices under this group
+ *    because the driver is already unbinded and it's safe to do so. Also, note
+ *    that *only* default_domain is being changed and hence the devices list in
+ *    the group need not be changed.
+ * 2. Unlike request_default_domain_for_dev(), a domain is allocated only once
+ *    for the whole group, where as the former allocates a domain per device.
+ *
+ * @group: The group for which the default domain should be changed
+ * @prev_domain: The previous domain that is being switched from
+ * @type: The type of the new default domain that gets associated with the group
+ *
+ * Returns 0 on success and error code on failure
+ *
+ * Note:
+ * 1. Presently, this function is called only when user requests to change the
+ *    group's default domain type through /sys/kernel/iommu_groups/<grp_id>/type
+ *    Be aware to take a closer look if intended to use for other cases.
+ * 2. Assumes group->mutex is already taken
+ */
+static int iommu_group_change_def_domain(struct iommu_group *group,
+					 struct iommu_domain *prev_domain,
+					 int type)
+{
+	struct group_device *grp_dev;
+	struct iommu_domain *new_domain;
+	int ret = 0;
+
+	/*
+	 * iommu_domain_alloc() takes "struct bus_type" as an argument which is
+	 * a member in "struct device". Changing a group's default domain type
+	 * deals at iommu_group level rather than device level and hence there
+	 * is no straight forward way to get "bus_type" of an iommu_group that
+	 * could be passed to iommu_domain_alloc(). So, instead of directly
+	 * calling iommu_domain_alloc(), use iommu_ops from previous default
+	 * domain.
+	 */
+	if (!prev_domain || !prev_domain->ops ||
+	    !prev_domain->ops->domain_alloc || !type)
+		return -EINVAL;
+
+	/* Allocate a new domain of requested type */
+	new_domain = prev_domain->ops->domain_alloc(type);
+	if (!new_domain) {
+		pr_err("Unable to allocate memory for the new domain\n");
+		return -ENOMEM;
+	}
+
+	new_domain->type = type;
+	new_domain->ops = prev_domain->ops;
+	new_domain->pgsize_bitmap = prev_domain->pgsize_bitmap;
+
+	/* Attach all the devices in the group to the newly created domain */
+	ret = __iommu_attach_group(new_domain, group);
+	if (ret) {
+		pr_err("Unable to attach all the devices in the group to the new domain\n");
+		goto free_new_domain;
+	}
+
+	/*
+	 * Map reserved regions if the group's default domain is being changed
+	 * from identity domain to dma domain
+	 */
+	if (type == IOMMU_DOMAIN_IDENTITY)
+		goto free_prev_domain;
+
+	list_for_each_entry(grp_dev, &group->devices, list) {
+		ret = iommu_group_create_direct_mappings(group, grp_dev->dev);
+		if (ret) {
+			dev_err(grp_dev->dev, "Failed to create direct mappings for reserved regions\n");
+			goto free_new_domain;
+		}
+	}
+
+free_prev_domain:
+	/*
+	 * Free the existing default domain and replace it with the newly
+	 * created default domain. No need to set group->domain because
+	 * __iommu_attach_group() already does it on success.
+	 */
+	iommu_domain_free(prev_domain);
+	group->default_domain = new_domain;
+	return 0;
+
+free_new_domain:
+	iommu_domain_free(new_domain);
+	return ret;
+}
+
+static int is_driver_binded(struct device *dev, void *not_used)
+{
+	int ret = 0;
+
+	device_lock(dev);
+	if (device_is_bound(dev))
+		ret = 1;
+	device_unlock(dev);
+	return ret;
+}
+
+static ssize_t iommu_group_store_type(struct iommu_group *group,
+				      const char *buf, size_t count)
+{
+	int ret, req_type = 0, req_auto = 0;
+	struct iommu_domain *prev_domain;
+	struct group_device *grp_dev;
+	const struct iommu_ops *ops;
+	struct device *dev;
+
+	if (!capable(CAP_SYS_ADMIN) || !capable(CAP_SYS_RAWIO))
+		return -EACCES;
+
+	if (WARN_ON(!group))
+		return -EINVAL;
+
+	if (sysfs_streq(buf, "identity"))
+		req_type = IOMMU_DOMAIN_IDENTITY;
+	else if (sysfs_streq(buf, "dma"))
+		req_type = IOMMU_DOMAIN_DMA;
+	else if (sysfs_streq(buf, "auto"))
+		req_auto = 1;
+	else
+		return -EINVAL;
+
+	/* Check if any device in the group still has a driver binded to it */
+	if (iommu_group_for_each_dev(group, NULL, is_driver_binded)) {
+		pr_err("Active drivers exist for devices in the group\n");
+		return -EBUSY;
+	}
+
+	mutex_lock(&group->mutex);
+	prev_domain = group->default_domain;
+	if (!prev_domain || !prev_domain->ops ||
+	    !prev_domain->ops->device_def_domain_type) {
+		pr_err("'device_def_domain_type' call back isn't registered\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * If user has requested "auto", kernel has to decide the default domain
+	 * type of a group. Hence, find out individual preferences of a device.
+	 */
+	ops = prev_domain->ops;
+	if (req_auto) {
+		int dma_devs = 0, idt_devs = 0, dev_def_dom;
+
+		list_for_each_entry(grp_dev, &group->devices, list) {
+			dev = grp_dev->dev;
+			dev_def_dom = ops->device_def_domain_type(dev);
+			if (dev_def_dom == IOMMU_DOMAIN_IDENTITY)
+				idt_devs++;
+			if (dev_def_dom == IOMMU_DOMAIN_DMA)
+				dma_devs++;
+		}
+
+		/*
+		 * Default domain type of a group is undefined if some devices
+		 * in the group should be in dma domain while other devices
+		 * should be in identity domain
+		 */
+		if (idt_devs && dma_devs) {
+			pr_err("Some devices need identity domain while other need dma domain\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/*
+		 * Default domain type of a group is identity if
+		 * 1. All the devices in the group need to be in identity domain
+		 * 2. Some devices should be in identity domain while other
+		 *    devices could be in either of dma or identity domain
+		 */
+		if (idt_devs && !dma_devs)
+			req_type = IOMMU_DOMAIN_IDENTITY;
+
+		/*
+		 * Default domain type of a group is dma if
+		 * 1. All the devices in the group need to be in dma domain
+		 * 2. Some devices should be in dma domain while other devices
+		 *    could be in either of dma or identity domain
+		 * 3. All the devices could be in either of the domains (namely
+		 *    dma and identity)
+		 */
+		if (!idt_devs)
+			req_type = IOMMU_DOMAIN_DMA;
+	}
+
+	/*
+	 * Switch to a new domain only if the requested domain type is different
+	 * from the existing default domain type
+	 */
+	if (prev_domain->type == req_type) {
+		ret = count;
+		goto out;
+	}
+
+	/*
+	 * Every device may not support both the domain types (namely DMA and
+	 * identity), so check if it's ok to change domain type of every device
+	 * in the group to the requested domain. This check is not required if
+	 * user has requested "auto" because it's already done above implicitly.
+	 */
+	if (!req_auto) {
+		list_for_each_entry(grp_dev, &group->devices, list) {
+			int allowed_types;
+
+			dev = grp_dev->dev;
+			allowed_types = ops->device_def_domain_type(dev);
+			if (allowed_types && allowed_types != req_type) {
+				dev_err(dev, "Cannot be in %s domain\n", buf);
+				ret = -EINVAL;
+				goto out;
+			}
+		}
+	}
+
+	ret = iommu_group_change_def_domain(group, prev_domain, req_type);
+	if (!ret)
+		ret = count;
+out:
+	mutex_unlock(&group->mutex);
+	return ret;
+}
-- 
2.19.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
