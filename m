Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4051DC433F5
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 02:10:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD4760FD8
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 02:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0AD4760FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC8B440015;
	Mon, 15 Nov 2021 02:10:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gM5fYUxqear2; Mon, 15 Nov 2021 02:10:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4005940001;
	Mon, 15 Nov 2021 02:10:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BE3CC002E;
	Mon, 15 Nov 2021 02:10:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D4C2C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 02:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8BEAE606EF
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 02:10:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HxnEhwrDVyCm for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 02:10:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B10C1606BB
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 02:10:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="233610355"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; d="scan'208";a="233610355"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2021 18:10:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; d="scan'208";a="505714551"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 14 Nov 2021 18:10:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 02/11] driver core: Set DMA ownership during driver bind/unbind
Date: Mon, 15 Nov 2021 10:05:43 +0800
Message-Id: <20211115020552.2378167-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
References: <20211115020552.2378167-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org, rafael@kernel.org,
 linux-pci@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Will Deacon <will@kernel.org>
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

This extends really_probe() to allow checking for dma ownership conflict
during the driver binding process. By default, the DMA_OWNER_KERNEL is
claimed for the bound driver before calling its .probe() callback. If this
operation fails (e.g. the iommu group of the target device already has the
DMA_OWNER_USER set), the binding process is aborted to avoid breaking the
security contract for devices in the iommu group.

Without this change, the vfio driver has to listen to a bus BOUND_DRIVER
event and then BUG_ON() in case of dma ownership conflict. This leads to
bad user experience since careless driver binding operation may crash the
system if the admin overlooks the group restriction.

Aside from bad design, this leads to a security problem as a root user,
even with lockdown=integrity, can force the kernel to BUG.

Driver may set a new flag (suppress_auto_claim_dma_owner) to disable auto
claim in the binding process. Examples include kernel drivers (pci_stub,
PCI bridge drivers, etc.) which don't trigger DMA at all thus can be safely
exempted in DMA ownership check and userspace framework drivers (vfio/vdpa
etc.) which need to manually claim DMA_OWNER_USER when assigning a device
to userspace.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/20210922123931.GI327412@nvidia.com/
Link: https://lore.kernel.org/linux-iommu/20210928115751.GK964074@nvidia.com/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/device/driver.h |  7 ++++++-
 drivers/base/dd.c             | 12 ++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index a498ebcf4993..25d39c64c4d9 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -54,6 +54,10 @@ enum probe_type {
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
+ * @suppress_auto_claim_dma_owner: Disable auto claiming of kernel DMA owner.
+ *		Drivers which don't require DMA or want to manually claim the
+ *		owner type (e.g. userspace driver frameworks) could set this
+ *		flag.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
@@ -99,7 +103,8 @@ struct device_driver {
 	struct module		*owner;
 	const char		*mod_name;	/* used for built-in modules */
 
-	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool suppress_bind_attrs:1;	/* disables bind/unbind via sysfs */
+	bool suppress_auto_claim_dma_owner:1;
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 68ea1f949daa..ab3333351f19 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
+#include <linux/iommu.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -566,6 +567,12 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		goto done;
 	}
 
+	if (!drv->suppress_auto_claim_dma_owner) {
+		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_KERNEL, NULL);
+		if (ret)
+			return ret;
+	}
+
 re_probe:
 	dev->driver = drv;
 
@@ -673,6 +680,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		dev->pm_domain->dismiss(dev);
 	pm_runtime_reinit(dev);
 	dev_pm_set_driver_flags(dev, 0);
+	if (!drv->suppress_auto_claim_dma_owner)
+		iommu_device_release_dma_owner(dev, DMA_OWNER_KERNEL);
 done:
 	return ret;
 }
@@ -1215,6 +1224,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		pm_runtime_reinit(dev);
 		dev_pm_set_driver_flags(dev, 0);
 
+		if (!drv->suppress_auto_claim_dma_owner)
+			iommu_device_release_dma_owner(dev, DMA_OWNER_KERNEL);
+
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
 		if (dev->bus)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
