Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD9CC4332F
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 01:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8288D400EF;
	Mon,  6 Dec 2021 01:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQC0Ir-VYJbG; Mon,  6 Dec 2021 01:59:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 28EFE401D4;
	Mon,  6 Dec 2021 01:59:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F41D5C001E;
	Mon,  6 Dec 2021 01:59:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0604C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 01:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C000D401D4
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 01:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pJmErxLw14ba for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 01:59:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F0D39400EF
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 01:59:51 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="261257508"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="261257508"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2021 17:59:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="514542009"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Dec 2021 17:59:44 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v3 04/18] driver core: platform: Add driver dma ownership
 management
Date: Mon,  6 Dec 2021 09:58:49 +0800
Message-Id: <20211206015903.88687-5-baolu.lu@linux.intel.com>
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

Multiple platform devices may be placed in the same IOMMU group because
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
 include/linux/platform_device.h |  1 +
 drivers/base/platform.c         | 30 +++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 4381c34af7e0..f3926be7582f 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -210,6 +210,7 @@ struct platform_driver {
 	struct device_driver driver;
 	const struct platform_device_id *id_table;
 	bool prevent_deferred_probe;
+	bool suppress_auto_claim_dma_owner;
 };
 
 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 125d708c0eb3..032b9f20b468 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -30,6 +30,7 @@
 #include <linux/property.h>
 #include <linux/kmemleak.h>
 #include <linux/types.h>
+#include <linux/iommu.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -1464,6 +1465,32 @@ int firmware_dma_configure(struct device *dev)
 	return ret;
 }
 
+static int platform_dma_configure(struct device *dev)
+{
+	struct platform_driver *drv = to_platform_driver(dev->driver);
+	int ret;
+
+	if (!drv->suppress_auto_claim_dma_owner) {
+		ret = iommu_device_set_dma_owner(dev, DMA_OWNER_DMA_API, NULL);
+		if (ret)
+			return ret;
+	}
+
+	ret = firmware_dma_configure(dev);
+	if (ret && !drv->suppress_auto_claim_dma_owner)
+		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
+
+	return ret;
+}
+
+static void platform_dma_cleanup(struct device *dev)
+{
+	struct platform_driver *drv = to_platform_driver(dev->driver);
+
+	if (!drv->suppress_auto_claim_dma_owner)
+		iommu_device_release_dma_owner(dev, DMA_OWNER_DMA_API);
+}
+
 static const struct dev_pm_ops platform_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend, pm_generic_runtime_resume, NULL)
 	USE_PLATFORM_PM_SLEEP_OPS
@@ -1477,7 +1504,8 @@ struct bus_type platform_bus_type = {
 	.probe		= platform_probe,
 	.remove		= platform_remove,
 	.shutdown	= platform_shutdown,
-	.dma_configure	= firmware_dma_configure,
+	.dma_configure	= platform_dma_configure,
+	.dma_cleanup	= platform_dma_cleanup,
 	.pm		= &platform_dev_pm_ops,
 };
 EXPORT_SYMBOL_GPL(platform_bus_type);
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
