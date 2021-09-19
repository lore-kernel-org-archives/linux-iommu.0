Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF05C4332F
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:41:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8363661076
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8363661076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 549A3404CD;
	Sun, 19 Sep 2021 06:41:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eoLB7j-phHgb; Sun, 19 Sep 2021 06:41:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D91B7404E7;
	Sun, 19 Sep 2021 06:41:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4254C001B;
	Sun, 19 Sep 2021 06:41:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0792C000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:41:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82B3B606C2
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:41:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t7cYZwfekX2h for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:41:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1AA760648
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:41:43 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="203156043"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="203156043"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510701873"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:41:36 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Date: Sun, 19 Sep 2021 14:38:30 +0800
Message-Id: <20210919063848.1476776-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210919063848.1476776-1-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, kwankhede@nvidia.com, jean-philippe@linaro.org,
 dave.jiang@intel.com, ashok.raj@intel.com, corbet@lwn.net,
 kevin.tian@intel.com, parav@mellanox.com, lkml@metux.net,
 david@gibson.dropbear.id.au, robin.murphy@arm.com, jun.j.tian@intel.com,
 linux-kernel@vger.kernel.org, lushenming@huawei.com,
 iommu@lists.linux-foundation.org, pbonzini@redhat.com, dwmw2@infradead.org
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

This patch introduces a new interface (/dev/vfio/devices/$DEVICE) for
userspace to directly open a vfio device w/o relying on container/group
(/dev/vfio/$GROUP). Anything related to group is now hidden behind
iommufd (more specifically in iommu core by this RFC) in a device-centric
manner.

In case a device is exposed in both legacy and new interfaces (see next
patch for how to decide it), this patch also ensures that when the device
is already opened via one interface then the other one must be blocked.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/vfio.c  | 228 +++++++++++++++++++++++++++++++++++++++----
 include/linux/vfio.h |   2 +
 2 files changed, 213 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 02cc51ce6891..84436d7abedd 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -46,6 +46,12 @@ static struct vfio {
 	struct mutex			group_lock;
 	struct cdev			group_cdev;
 	dev_t				group_devt;
+	/* Fields for /dev/vfio/devices interface */
+	struct class			*device_class;
+	struct cdev			device_cdev;
+	dev_t				device_devt;
+	struct mutex			device_lock;
+	struct idr			device_idr;
 } vfio;
 
 struct vfio_iommu_driver {
@@ -81,9 +87,11 @@ struct vfio_group {
 	struct list_head		container_next;
 	struct list_head		unbound_list;
 	struct mutex			unbound_lock;
-	atomic_t			opened;
-	wait_queue_head_t		container_q;
+	struct mutex			opened_lock;
+	u32				opened;
+	bool				opened_by_nongroup_dev;
 	bool				noiommu;
+	wait_queue_head_t		container_q;
 	unsigned int			dev_counter;
 	struct kvm			*kvm;
 	struct blocking_notifier_head	notifier;
@@ -327,7 +335,7 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group)
 	INIT_LIST_HEAD(&group->unbound_list);
 	mutex_init(&group->unbound_lock);
 	atomic_set(&group->container_users, 0);
-	atomic_set(&group->opened, 0);
+	mutex_init(&group->opened_lock);
 	init_waitqueue_head(&group->container_q);
 	group->iommu_group = iommu_group;
 #ifdef CONFIG_VFIO_NOIOMMU
@@ -1489,10 +1497,53 @@ static long vfio_group_fops_unl_ioctl(struct file *filep,
 	return ret;
 }
 
+/*
+ * group->opened is used to ensure that the group can be opened only via
+ * one of the two interfaces (/dev/vfio/$GROUP and /dev/vfio/devices/
+ * $DEVICE) instead of both.
+ *
+ * We also introduce a new group flag to indicate whether this group is
+ * opened via /dev/vfio/devices/$DEVICE. For multi-devices group,
+ * group->opened also tracks how many devices have been opened in the
+ * group if the new flag is true.
+ *
+ * Also add a new lock since two flags are operated here.
+ */
+static int vfio_group_try_open(struct vfio_group *group, bool nongroup_dev)
+{
+	int ret = 0;
+
+	mutex_lock(&group->opened_lock);
+	if (group->opened) {
+		if (nongroup_dev && group->opened_by_nongroup_dev)
+			group->opened++;
+		else
+			ret = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * Is something still in use from a previous open? Should
+	 * not allow new open if it is such case.
+	 */
+	if (group->container) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	group->opened = 1;
+	group->opened_by_nongroup_dev = nongroup_dev;
+
+out:
+	mutex_unlock(&group->opened_lock);
+
+	return ret;
+}
+
 static int vfio_group_fops_open(struct inode *inode, struct file *filep)
 {
 	struct vfio_group *group;
-	int opened;
+	int ret;
 
 	group = vfio_group_get_from_minor(iminor(inode));
 	if (!group)
@@ -1503,18 +1554,10 @@ static int vfio_group_fops_open(struct inode *inode, struct file *filep)
 		return -EPERM;
 	}
 
-	/* Do we need multiple instances of the group open?  Seems not. */
-	opened = atomic_cmpxchg(&group->opened, 0, 1);
-	if (opened) {
-		vfio_group_put(group);
-		return -EBUSY;
-	}
-
-	/* Is something still in use from a previous open? */
-	if (group->container) {
-		atomic_dec(&group->opened);
+	ret = vfio_group_try_open(group, false);
+	if (ret) {
 		vfio_group_put(group);
-		return -EBUSY;
+		return ret;
 	}
 
 	/* Warn if previous user didn't cleanup and re-init to drop them */
@@ -1534,7 +1577,9 @@ static int vfio_group_fops_release(struct inode *inode, struct file *filep)
 
 	vfio_group_try_dissolve_container(group);
 
-	atomic_dec(&group->opened);
+	mutex_lock(&group->opened_lock);
+	group->opened--;
+	mutex_unlock(&group->opened_lock);
 
 	vfio_group_put(group);
 
@@ -1552,6 +1597,92 @@ static const struct file_operations vfio_group_fops = {
 /**
  * VFIO Device fd
  */
+static struct vfio_device *vfio_device_get_from_minor(int minor)
+{
+	struct vfio_device *device;
+
+	mutex_lock(&vfio.device_lock);
+	device = idr_find(&vfio.device_idr, minor);
+	if (!device || !vfio_device_try_get(device)) {
+		mutex_unlock(&vfio.device_lock);
+		return NULL;
+	}
+	mutex_unlock(&vfio.device_lock);
+
+	return device;
+}
+
+static int vfio_device_fops_open(struct inode *inode, struct file *filep)
+{
+	struct vfio_device *device;
+	struct vfio_group *group;
+	int ret, opened;
+
+	device = vfio_device_get_from_minor(iminor(inode));
+	if (!device)
+		return -ENODEV;
+
+	/*
+	 * Check whether the user has opened this device via the legacy
+	 * container/group interface. If yes, then prevent the user from
+	 * opening it via device node in /dev/vfio/devices. Otherwise,
+	 * mark the group as opened to block the group interface. either
+	 * way, we must ensure only one interface is used to open the
+	 * device when it supports both legacy and new interfaces.
+	 */
+	group = vfio_group_try_get(device->group);
+	if (group) {
+		ret = vfio_group_try_open(group, true);
+		if (ret)
+			goto err_group_try_open;
+	}
+
+	/*
+	 * No support of multiple instances of the device open, similar to
+	 * the policy on the group open.
+	 */
+	opened = atomic_cmpxchg(&device->opened, 0, 1);
+	if (opened) {
+		ret = -EBUSY;
+		goto err_device_try_open;
+	}
+
+	if (!try_module_get(device->dev->driver->owner)) {
+		ret = -ENODEV;
+		goto err_module_get;
+	}
+
+	ret = device->ops->open(device);
+	if (ret)
+		goto err_device_open;
+
+	filep->private_data = device;
+
+	if (group)
+		vfio_group_put(group);
+	return 0;
+err_device_open:
+	module_put(device->dev->driver->owner);
+err_module_get:
+	atomic_dec(&device->opened);
+err_device_try_open:
+	if (group) {
+		mutex_lock(&group->opened_lock);
+		group->opened--;
+		mutex_unlock(&group->opened_lock);
+	}
+err_group_try_open:
+	if (group)
+		vfio_group_put(group);
+	vfio_device_put(device);
+	return ret;
+}
+
+static bool vfio_device_in_container(struct vfio_device *device)
+{
+	return !!(device->group && device->group->container);
+}
+
 static int vfio_device_fops_release(struct inode *inode, struct file *filep)
 {
 	struct vfio_device *device = filep->private_data;
@@ -1560,7 +1691,16 @@ static int vfio_device_fops_release(struct inode *inode, struct file *filep)
 
 	module_put(device->dev->driver->owner);
 
-	vfio_group_try_dissolve_container(device->group);
+	if (vfio_device_in_container(device)) {
+		vfio_group_try_dissolve_container(device->group);
+	} else {
+		atomic_dec(&device->opened);
+		if (device->group) {
+			mutex_lock(&device->group->opened_lock);
+			device->group->opened--;
+			mutex_unlock(&device->group->opened_lock);
+		}
+	}
 
 	vfio_device_put(device);
 
@@ -1613,6 +1753,7 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 
 static const struct file_operations vfio_device_fops = {
 	.owner		= THIS_MODULE,
+	.open		= vfio_device_fops_open,
 	.release	= vfio_device_fops_release,
 	.read		= vfio_device_fops_read,
 	.write		= vfio_device_fops_write,
@@ -2295,6 +2436,52 @@ static struct miscdevice vfio_dev = {
 	.mode = S_IRUGO | S_IWUGO,
 };
 
+static char *vfio_device_devnode(struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
+}
+
+static int vfio_init_device_class(void)
+{
+	int ret;
+
+	mutex_init(&vfio.device_lock);
+	idr_init(&vfio.device_idr);
+
+	/* /dev/vfio/devices/$DEVICE */
+	vfio.device_class = class_create(THIS_MODULE, "vfio-device");
+	if (IS_ERR(vfio.device_class))
+		return PTR_ERR(vfio.device_class);
+
+	vfio.device_class->devnode = vfio_device_devnode;
+
+	ret = alloc_chrdev_region(&vfio.device_devt, 0, MINORMASK + 1, "vfio-device");
+	if (ret)
+		goto err_alloc_chrdev;
+
+	cdev_init(&vfio.device_cdev, &vfio_device_fops);
+	ret = cdev_add(&vfio.device_cdev, vfio.device_devt, MINORMASK + 1);
+	if (ret)
+		goto err_cdev_add;
+	return 0;
+
+err_cdev_add:
+	unregister_chrdev_region(vfio.device_devt, MINORMASK + 1);
+err_alloc_chrdev:
+	class_destroy(vfio.device_class);
+	vfio.device_class = NULL;
+	return ret;
+}
+
+static void vfio_destroy_device_class(void)
+{
+	cdev_del(&vfio.device_cdev);
+	unregister_chrdev_region(vfio.device_devt, MINORMASK + 1);
+	class_destroy(vfio.device_class);
+	vfio.device_class = NULL;
+	idr_destroy(&vfio.device_idr);
+}
+
 static int __init vfio_init(void)
 {
 	int ret;
@@ -2329,6 +2516,10 @@ static int __init vfio_init(void)
 	if (ret)
 		goto err_cdev_add;
 
+	ret = vfio_init_device_class();
+	if (ret)
+		goto err_init_device_class;
+
 	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
 #ifdef CONFIG_VFIO_NOIOMMU
@@ -2336,6 +2527,8 @@ static int __init vfio_init(void)
 #endif
 	return 0;
 
+err_init_device_class:
+	cdev_del(&vfio.group_cdev);
 err_cdev_add:
 	unregister_chrdev_region(vfio.group_devt, MINORMASK + 1);
 err_alloc_chrdev:
@@ -2358,6 +2551,7 @@ static void __exit vfio_cleanup(void)
 	unregister_chrdev_region(vfio.group_devt, MINORMASK + 1);
 	class_destroy(vfio.class);
 	vfio.class = NULL;
+	vfio_destroy_device_class();
 	misc_deregister(&vfio_dev);
 }
 
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index a2c5b30e1763..4a5f3f99eab2 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -24,6 +24,8 @@ struct vfio_device {
 	refcount_t refcount;
 	struct completion comp;
 	struct list_head group_next;
+	int minor;
+	atomic_t opened;
 };
 
 /**
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
