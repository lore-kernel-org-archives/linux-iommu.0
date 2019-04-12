Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0B4C10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 04:27:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46EC62082E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 04:27:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EC62082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B2F1510B2;
	Fri, 12 Apr 2019 04:27:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D0CA6F5E
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 04:19:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 35FE67ED
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 04:19:30 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Apr 2019 21:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,340,1549958400"; d="scan'208";a="142094928"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2019 21:19:27 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kirti Wankhede <kwankhede@nvidia.com>
Subject: [PATCH v9 1/3] vfio/mdev: Add iommu related member in mdev_device
Date: Fri, 12 Apr 2019 12:13:24 +0800
Message-Id: <20190412041326.19914-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190412041326.19914-1-baolu.lu@linux.intel.com>
References: <20190412041326.19914-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, yi.y.sun@intel.com,
	jacob.jun.pan@intel.com, kvm@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190412041324.tWZ3XHQQKn8om73lHN_pctMUAzQj51bNxOK587ktSr8@z>

A parent device might create different types of mediated
devices. For example, a mediated device could be created
by the parent device with full isolation and protection
provided by the IOMMU. One usage case could be found on
Intel platforms where a mediated device is an assignable
subset of a PCI, the DMA requests on behalf of it are all
tagged with a PASID. Since IOMMU supports PASID-granular
translations (scalable mode in VT-d 3.0), this mediated
device could be individually protected and isolated by an
IOMMU.

This patch adds a new member in the struct mdev_device to
indicate that the mediated device represented by mdev could
be isolated and protected by attaching a domain to a device
represented by mdev->iommu_device. It also adds a helper to
add or set the iommu device.

* mdev_device->iommu_device
  - This, if set, indicates that the mediated device could
    be fully isolated and protected by IOMMU via attaching
    an iommu domain to this device. If empty, it indicates
    using vendor defined isolation, hence bypass IOMMU.

* mdev_set/get_iommu_device(dev, iommu_device)
  - Set or get the iommu device which represents this mdev
    in IOMMU's device scope. Drivers don't need to set the
    iommu device if it uses vendor defined isolation.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Liu Yi L <yi.l.liu@intel.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Reviewed-by: Kirti Wankhede <kwankhede@nvidia.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/mdev/mdev_core.c    | 18 ++++++++++++++++++
 drivers/vfio/mdev/mdev_private.h |  1 +
 include/linux/mdev.h             | 14 ++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 9d29c71bcf99..318959a994e4 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -396,6 +396,24 @@ int mdev_device_remove(struct device *dev, bool force_remove)
 	return 0;
 }
 
+int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	mdev->iommu_device = iommu_device;
+
+	return 0;
+}
+EXPORT_SYMBOL(mdev_set_iommu_device);
+
+struct device *mdev_get_iommu_device(struct device *dev)
+{
+	struct mdev_device *mdev = to_mdev_device(dev);
+
+	return mdev->iommu_device;
+}
+EXPORT_SYMBOL(mdev_get_iommu_device);
+
 static int __init mdev_init(void)
 {
 	return mdev_bus_register();
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index 379758c52b1b..f4eba723fea5 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -33,6 +33,7 @@ struct mdev_device {
 	struct kref ref;
 	struct list_head next;
 	struct kobject *type_kobj;
+	struct device *iommu_device;
 	bool active;
 };
 
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 12354ab4164a..f4a88a6dd054 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -15,6 +15,20 @@
 
 struct mdev_device;
 
+/*
+ * Called by the parent device driver to set the device which represents
+ * this mdev in iommu protection scope. By default, the iommu device is
+ * NULL, that indicates using vendor defined isolation.
+ *
+ * @dev: the mediated device that iommu will isolate.
+ * @iommu_device: a pci device which represents the iommu for @dev.
+ *
+ * Return 0 for success, otherwise negative error value.
+ */
+int mdev_set_iommu_device(struct device *dev, struct device *iommu_device);
+
+struct device *mdev_get_iommu_device(struct device *dev);
+
 /**
  * struct mdev_parent_ops - Structure to be registered for each parent device to
  * register the device to mdev module.
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
