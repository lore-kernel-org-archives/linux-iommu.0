Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D51C433FE
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 02:00:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31E6240498;
	Mon,  6 Dec 2021 02:00:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pLCEPJeZgdmf; Mon,  6 Dec 2021 02:00:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 16DB8404BA;
	Mon,  6 Dec 2021 02:00:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCF4FC001E;
	Mon,  6 Dec 2021 02:00:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37346C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:00:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 264C781D88
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:00:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y2cI7IPHJLOp for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 02:00:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FFEC81886
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:00:16 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="237040977"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="237040977"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2021 18:00:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="514542189"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Dec 2021 17:59:59 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v3 06/18] bus: fsl-mc: Add driver dma ownership management
Date: Mon,  6 Dec 2021 09:58:51 +0800
Message-Id: <20211206015903.88687-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211206015903.88687-1-baolu.lu@linux.intel.com>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
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

Multiple fsl-mc devices may be placed in the same IOMMU group because
they cannot be isolated from each other. These devices must either be
entirely under kernel control or userspace control, never a mixture. This
checks and sets DMA ownership during driver binding, and release the
ownership during driver unbinding.

Driver may set a new flag (suppress_auto_claim_dma_owner) to disable auto
claiming DMA_OWNER_DMA_API ownership in the binding process. For instance,
the userspace framework drivers (vfio etc.) which need to manually claim
DMA_OWNER_PRIVATE_DOMAIN_USER when assigning a device to userspace.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/fsl/mc.h          |  5 +++++
 drivers/bus/fsl-mc/fsl-mc-bus.c | 26 ++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index e026f6c48b49..3a26421ee3dc 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -32,6 +32,10 @@ struct fsl_mc_io;
  * @shutdown: Function called at shutdown time to quiesce the device
  * @suspend: Function called when a device is stopped
  * @resume: Function called when a device is resumed
+ * @suppress_auto_claim_dma_owner: Disable auto claiming of kernel DMA owner.
+ *		Drivers which don't require DMA or want to manually claim the
+ *		owner type (e.g. userspace driver frameworks) could set this
+ *		flag.
  *
  * Generic DPAA device driver object for device drivers that are registered
  * with a DPRC bus. This structure is to be embedded in each device-specific
@@ -45,6 +49,7 @@ struct fsl_mc_driver {
 	void (*shutdown)(struct fsl_mc_device *dev);
 	int (*suspend)(struct fsl_mc_device *dev, pm_message_t state);
 	int (*resume)(struct fsl_mc_device *dev);
+	bool suppress_auto_claim_dma_owner;
 };
 
 #define to_fsl_mc_driver(_drv) \
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..048a837a7116 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -140,15 +140,36 @@ static int fsl_mc_dma_configure(struct device *dev)
 {
 	struct device *dma_dev = dev;
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(dev->driver);
 	u32 input_id = mc_dev->icid;
+	int ret;
+
+	if (!mc_drv->suppress_auto_claim_dma_owner) {
+		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_DMA_API, NULL);
+		if (ret)
+			return ret;
+	}
 
 	while (dev_is_fsl_mc(dma_dev))
 		dma_dev = dma_dev->parent;
 
 	if (dev_of_node(dma_dev))
-		return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
+		ret = of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
+	else
+		ret = acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
+
+	if (ret && !mc_drv->suppress_auto_claim_dma_owner)
+		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
+
+	return ret;
+}
+
+static void fsl_mc_dma_cleanup(struct device *dev)
+{
+	struct fsl_mc_driver *mc_drv = to_fsl_mc_driver(dev->driver);
 
-	return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
+	if (!mc_drv->suppress_auto_claim_dma_owner)
+		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
 }
 
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
@@ -312,6 +333,7 @@ struct bus_type fsl_mc_bus_type = {
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
 	.dma_configure  = fsl_mc_dma_configure,
+	.dma_cleanup = fsl_mc_dma_cleanup,
 	.dev_groups = fsl_mc_dev_groups,
 	.bus_groups = fsl_mc_bus_groups,
 };
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
