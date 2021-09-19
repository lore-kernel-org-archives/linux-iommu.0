Return-Path: <SRS0=PYNz=OJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DCFC433EF
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CA2610CF
	for <iommu@archiver.kernel.org>; Sun, 19 Sep 2021 06:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08CA2610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3EB640505;
	Sun, 19 Sep 2021 06:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ufT7ErJEwrcw; Sun, 19 Sep 2021 06:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B8DAA404CD;
	Sun, 19 Sep 2021 06:42:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86C3EC0011;
	Sun, 19 Sep 2021 06:42:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 869FCC000D
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 68E66404FC
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KjJN2rdA9nPB for <iommu@lists.linux-foundation.org>;
 Sun, 19 Sep 2021 06:42:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7AA5404FB
 for <iommu@lists.linux-foundation.org>; Sun, 19 Sep 2021 06:42:05 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10111"; a="223030174"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="223030174"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2021 23:42:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; d="scan'208";a="510701940"
Received: from yiliu-dev.bj.intel.com (HELO iov-dual.bj.intel.com)
 ([10.238.156.135])
 by fmsmga008.fm.intel.com with ESMTP; 18 Sep 2021 23:41:56 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: alex.williamson@redhat.com, jgg@nvidia.com, hch@lst.de,
 jasowang@redhat.com, joro@8bytes.org
Subject: [RFC 05/20] vfio/pci: Register device to /dev/vfio/devices
Date: Sun, 19 Sep 2021 14:38:33 +0800
Message-Id: <20210919063848.1476776-6-yi.l.liu@intel.com>
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

This patch exposes the device-centric interface for vfio-pci devices. To
be compatiable with existing users, vfio-pci exposes both legacy group
interface and device-centric interface.

As explained in last patch, this change doesn't apply to devices which
cannot be forced to snoop cache by their upstream iommu. Such devices
are still expected to be opened via the legacy group interface.

When the device is opened via /dev/vfio/devices, vfio-pci should prevent
the user from accessing the assigned device because the device is still
attached to the default domain which may allow user-initiated DMAs to
touch arbitrary place. The user access must be blocked until the device
is later bound to an iommufd (see patch 08). The binding acts as the
contract for putting the device in a security context which ensures user-
initiated DMAs via this device cannot harm the rest of the system.

This patch introduces a vdev->block_access flag for this purpose. It's set
when the device is opened via /dev/vfio/devices and cleared after binding
to iommufd succeeds. mmap and r/w handlers check this flag to decide whether
user access should be blocked or not.

An alternative option is to use a dummy fops when the device is opened and
then switch to the real fops (replace_fops()) after binding. Appreciate
inputs on which option is better.

The legacy group interface doesn't have this problem. Its uAPI requires the
user to first put the device into a security context via container/group
attaching process, before opening the device through the groupfd.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
---
 drivers/vfio/pci/vfio_pci.c         | 25 +++++++++++++++++++++++--
 drivers/vfio/pci/vfio_pci_private.h |  1 +
 drivers/vfio/vfio.c                 |  3 ++-
 include/linux/vfio.h                |  1 +
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 318864d52837..145addde983b 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -572,6 +572,10 @@ static int vfio_pci_open(struct vfio_device *core_vdev)
 
 		vfio_spapr_pci_eeh_open(vdev->pdev);
 		vfio_pci_vf_token_user_add(vdev, 1);
+		if (!vfio_device_in_container(core_vdev))
+			atomic_set(&vdev->block_access, 1);
+		else
+			atomic_set(&vdev->block_access, 0);
 	}
 	vdev->refcnt++;
 error:
@@ -1374,6 +1378,9 @@ static ssize_t vfio_pci_rw(struct vfio_pci_device *vdev, char __user *buf,
 {
 	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
 
+	if (atomic_read(&vdev->block_access))
+		return -ENODEV;
+
 	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
 		return -EINVAL;
 
@@ -1640,6 +1647,9 @@ static int vfio_pci_mmap(struct vfio_device *core_vdev, struct vm_area_struct *v
 	u64 phys_len, req_len, pgoff, req_start;
 	int ret;
 
+	if (atomic_read(&vdev->block_access))
+		return -ENODEV;
+
 	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
 
 	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
@@ -1978,6 +1988,8 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vfio_pci_device *vdev;
 	struct iommu_group *group;
 	int ret;
+	u32 flags;
+	bool snoop = false;
 
 	if (vfio_pci_is_denylisted(pdev))
 		return -EINVAL;
@@ -2046,9 +2058,18 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		vfio_pci_set_power_state(vdev, PCI_D3hot);
 	}
 
-	ret = vfio_register_group_dev(&vdev->vdev);
-	if (ret)
+	flags = VFIO_DEVNODE_GROUP;
+	ret = iommu_device_get_info(&pdev->dev,
+				    IOMMU_DEV_INFO_FORCE_SNOOP, &snoop);
+	if (!ret && snoop)
+		flags |= VFIO_DEVNODE_NONGROUP;
+
+	ret = vfio_register_device(&vdev->vdev, flags);
+	if (ret) {
+		pr_debug("Failed to register device interface\n");
 		goto out_power;
+	}
+
 	dev_set_drvdata(&pdev->dev, vdev);
 	return 0;
 
diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
index 5a36272cecbf..f12012e30b53 100644
--- a/drivers/vfio/pci/vfio_pci_private.h
+++ b/drivers/vfio/pci/vfio_pci_private.h
@@ -143,6 +143,7 @@ struct vfio_pci_device {
 	struct mutex		vma_lock;
 	struct list_head	vma_list;
 	struct rw_semaphore	memory_lock;
+	atomic_t		block_access;
 };
 
 #define is_intx(vdev) (vdev->irq_type == VFIO_PCI_INTX_IRQ_INDEX)
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 1e87b25962f1..22851747e92c 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1789,10 +1789,11 @@ static int vfio_device_fops_open(struct inode *inode, struct file *filep)
 	return ret;
 }
 
-static bool vfio_device_in_container(struct vfio_device *device)
+bool vfio_device_in_container(struct vfio_device *device)
 {
 	return !!(device->group && device->group->container);
 }
+EXPORT_SYMBOL_GPL(vfio_device_in_container);
 
 static int vfio_device_fops_release(struct inode *inode, struct file *filep)
 {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 9448b751b663..fd0629acb948 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -81,6 +81,7 @@ enum vfio_iommu_notify_type {
 
 extern int vfio_register_device(struct vfio_device *device, u32 flags);
 extern void vfio_unregister_device(struct vfio_device *device);
+extern bool vfio_device_in_container(struct vfio_device *device);
 
 /**
  * struct vfio_iommu_driver_ops - VFIO IOMMU driver callbacks
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
