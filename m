Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034C2C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 06:37:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A058D84B39;
	Fri, 17 Dec 2021 06:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1eM2DL_bKVYM; Fri, 17 Dec 2021 06:37:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8162484B32;
	Fri, 17 Dec 2021 06:37:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57AD8C0030;
	Fri, 17 Dec 2021 06:37:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7BA5C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:37:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96DC784B32
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:37:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Siv220cMdnEx for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 06:37:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6DF683F38
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:37:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="238435812"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="238435812"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 22:37:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="519623128"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 22:37:42 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v4 02/13] driver core: Set DMA ownership during driver
 bind/unbind
Date: Fri, 17 Dec 2021 14:36:57 +0800
Message-Id: <20211217063708.1740334-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Stuart Yoder <stuyoder@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>
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
during the driver binding process. By default, the DMA_OWNER_DMA_API is
claimed for the bound driver before calling its .probe() callback. If this
operation fails (e.g. the iommu group of the target device already has the
DMA_OWNER_USER set), the binding process is aborted to avoid breaking the
security contract for devices in the iommu group.

Without this change, the vfio driver has to listen to a bus BOUND_DRIVER
event and then BUG_ON() in case of dma ownership conflict. This leads to
bad user experience since careless driver binding operation may crash the
system if the admin overlooks the group restriction. Aside from bad design,
this leads to a security problem as a root user can force the kernel to
BUG() even with lockdown=integrity.

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
 include/linux/device/driver.h |  2 ++
 drivers/base/dd.c             | 37 ++++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index a498ebcf4993..f5bf7030c416 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -54,6 +54,7 @@ enum probe_type {
  * @owner:	The module owner.
  * @mod_name:	Used for built-in modules.
  * @suppress_bind_attrs: Disables bind/unbind via sysfs.
+ * @suppress_auto_claim_dma_owner: Disable kernel dma auto-claim.
  * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
  * @of_match_table: The open firmware table.
  * @acpi_match_table: The ACPI match table.
@@ -100,6 +101,7 @@ struct device_driver {
 	const char		*mod_name;	/* used for built-in modules */
 
 	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
+	bool suppress_auto_claim_dma_owner;
 	enum probe_type probe_type;
 
 	const struct of_device_id	*of_match_table;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 68ea1f949daa..b04eec5dcefa 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -28,6 +28,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/slab.h>
+#include <linux/iommu.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -538,6 +539,32 @@ static int call_driver_probe(struct device *dev, struct device_driver *drv)
 	return ret;
 }
 
+static int device_dma_configure(struct device *dev, struct device_driver *drv)
+{
+	int ret;
+
+	if (!dev->bus->dma_configure)
+		return 0;
+
+	ret = dev->bus->dma_configure(dev);
+	if (ret)
+		return ret;
+
+	if (!drv->suppress_auto_claim_dma_owner)
+		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_DMA_API, NULL);
+
+	return ret;
+}
+
+static void device_dma_cleanup(struct device *dev, struct device_driver *drv)
+{
+	if (!dev->bus->dma_configure)
+		return;
+
+	if (!drv->suppress_auto_claim_dma_owner)
+		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
+}
+
 static int really_probe(struct device *dev, struct device_driver *drv)
 {
 	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
@@ -574,11 +601,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (ret)
 		goto pinctrl_bind_failed;
 
-	if (dev->bus->dma_configure) {
-		ret = dev->bus->dma_configure(dev);
-		if (ret)
-			goto probe_failed;
-	}
+	if (device_dma_configure(dev, drv))
+		goto pinctrl_bind_failed;
 
 	ret = driver_sysfs_add(dev);
 	if (ret) {
@@ -660,6 +684,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
+
+	device_dma_cleanup(dev, drv);
 pinctrl_bind_failed:
 	device_links_no_driver(dev);
 	devres_release_all(dev);
@@ -1204,6 +1230,7 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		else if (drv->remove)
 			drv->remove(dev);
 
+		device_dma_cleanup(dev, drv);
 		device_links_driver_cleanup(dev);
 
 		devres_release_all(dev);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
