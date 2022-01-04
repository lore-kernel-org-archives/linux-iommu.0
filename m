Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7CEC433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 01:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCD0980C50;
	Tue,  4 Jan 2022 01:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O-yYQCmmnJ7T; Tue,  4 Jan 2022 01:58:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D286E80C37;
	Tue,  4 Jan 2022 01:58:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF885C0030;
	Tue,  4 Jan 2022 01:58:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1EEE3C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CC4A408E8
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:58:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HYymZXQLfTMM for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 01:58:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4576A408CE
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641261496; x=1672797496;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UG84GF4gMsRM2TIANUAZ/Eq7BI+0yTChxDMnJO7QbYw=;
 b=cK94U7m1hs9rkjIRyBDuH2EOxfAWQGvpCSPRaoOrleXlLxoY27NRZ4jc
 npHfIDL0zBVgJfVWSYyvPPSY82sUEBVITs6epKzUuO5Yv7hy5zrtHbkIl
 k63YHFvsbfp5r80y5AmY290zj6pd5al9ujqYLL/ZFSiD5IiPbQmg4KDQ3
 xeXE6vKSfrb+9KKRJ7RloBB4av40Hps/pc3QC0N54ybtaNXs4PmhyqSyQ
 wAAMyYS9o14brUt2m+vsWza7vb2zOJk4rWxr6JE11P1g63dILyY3FYew5
 ZOgrQ2ykwXFWjtIcEz8IVZbubM9bAi4fk7nV6CQweB3v1KmCZ5LON8tAN A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222813375"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="222813375"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2022 17:58:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="667573278"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2022 17:58:08 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v5 07/14] PCI: Add driver dma ownership management
Date: Tue,  4 Jan 2022 09:56:37 +0800
Message-Id: <20220104015644.2294354-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
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

Multiple PCI devices may be placed in the same IOMMU group because
they cannot be isolated from each other. These devices must either be
entirely under kernel control or userspace control, never a mixture. This
checks and sets DMA ownership during driver binding, and release the
ownership during driver unbinding.

The device driver may set a new flag (no_kernel_api_dma) to skip calling
iommu_device_use_dma_api() during the binding process. For instance, the
userspace framework drivers (vfio etc.) which need to manually claim
their own dma ownership when assigning the device to userspace.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/pci.h      |  5 +++++
 drivers/pci/pci-driver.c | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8e615c..d29a990e3f02 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -882,6 +882,10 @@ struct module;
  *              created once it is bound to the driver.
  * @driver:	Driver model structure.
  * @dynids:	List of dynamically added device IDs.
+ * @no_kernel_api_dma: Device driver doesn't use kernel DMA API for DMA.
+ *		Drivers which don't require DMA or want to manually claim the
+ *		owner type (e.g. userspace driver frameworks) could set this
+ *		flag.
  */
 struct pci_driver {
 	struct list_head	node;
@@ -900,6 +904,7 @@ struct pci_driver {
 	const struct attribute_group **dev_groups;
 	struct device_driver	driver;
 	struct pci_dynids	dynids;
+	bool no_kernel_api_dma;
 };
 
 static inline struct pci_driver *to_pci_driver(struct device_driver *drv)
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 588588cfda48..4e003ea12718 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -20,6 +20,7 @@
 #include <linux/of_device.h>
 #include <linux/acpi.h>
 #include <linux/dma-map-ops.h>
+#include <linux/iommu.h>
 #include "pci.h"
 #include "pcie/portdrv.h"
 
@@ -1590,9 +1591,16 @@ static int pci_bus_num_vf(struct device *dev)
  */
 static int pci_dma_configure(struct device *dev)
 {
+	struct pci_driver *driver = to_pci_driver(dev->driver);
 	struct device *bridge;
 	int ret = 0;
 
+	if (!driver->no_kernel_api_dma) {
+		ret = iommu_device_use_dma_api(dev);
+		if (ret)
+			return ret;
+	}
+
 	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
 
 	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
@@ -1605,9 +1613,21 @@ static int pci_dma_configure(struct device *dev)
 	}
 
 	pci_put_host_bridge_device(bridge);
+
+	if (ret && !driver->no_kernel_api_dma)
+		iommu_device_unuse_dma_api(dev);
+
 	return ret;
 }
 
+static void pci_dma_cleanup(struct device *dev)
+{
+	struct pci_driver *driver = to_pci_driver(dev->driver);
+
+	if (!driver->no_kernel_api_dma)
+		iommu_device_unuse_dma_api(dev);
+}
+
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
@@ -1621,6 +1641,7 @@ struct bus_type pci_bus_type = {
 	.pm		= PCI_PM_OPS_PTR,
 	.num_vf		= pci_bus_num_vf,
 	.dma_configure	= pci_dma_configure,
+	.dma_cleanup	= pci_dma_cleanup,
 };
 EXPORT_SYMBOL(pci_bus_type);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
