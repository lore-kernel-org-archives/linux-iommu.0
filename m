Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE621C433EF
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 01:57:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87D91402D8;
	Tue,  4 Jan 2022 01:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fF6ggIJDg_nx; Tue,  4 Jan 2022 01:57:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5ABC2408AE;
	Tue,  4 Jan 2022 01:57:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 376B3C0030;
	Tue,  4 Jan 2022 01:57:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34B2EC001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1305B4060E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C5NDazilau5e for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 01:57:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2B4274060C
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 01:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1641261476; x=1672797476;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W99W9RR17D04pNuYuEdfrJcOOv2Un4PiDIeALXpTOd8=;
 b=E8BXd1AMJu/6HQIwRb9V1QOlszFZupkUvw2JkeYSJhAOzzvdBT8i44er
 54m53WCed7tKiubh9dGDr1szozy+++ddL3I7qRneaCUd4wKcmq3CBK1av
 8boL0wy14ed6gTtple3JfVHkxV/FsshnP0uoGjh2QJUF46FU+Dw5wjkvk
 LpDsSFnhnLghbfQ+xt2HiuRtib1sgxebLwv1NBNZp3Rz1uHAmOVLm0Dnq
 MnCRH1ka8iYJHJTP4pCuzVGyXMfxvONUqC5ObKUYyX3n+WAxty5gveZub
 h7bH9p4Wzk/m+sVKX9yeb7SIvyIMVn5laV3ubsbuxppQQWFsacLjeYP1d A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="240961099"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="240961099"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2022 17:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; d="scan'208";a="667573222"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 03 Jan 2022 17:57:49 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v5 04/14] driver core: platform: Add driver dma ownership
 management
Date: Tue,  4 Jan 2022 09:56:34 +0800
Message-Id: <20220104015644.2294354-5-baolu.lu@linux.intel.com>
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

Multiple platform devices may be placed in the same IOMMU group because
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
 include/linux/platform_device.h |  1 +
 drivers/base/platform.c         | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 17fde717df68..8f0eaafcef47 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -210,6 +210,7 @@ struct platform_driver {
 	struct device_driver driver;
 	const struct platform_device_id *id_table;
 	bool prevent_deferred_probe;
+	bool no_kernel_api_dma;
 };
 
 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index b4d36b46ab2e..d5171e44d903 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -30,6 +30,7 @@
 #include <linux/property.h>
 #include <linux/kmemleak.h>
 #include <linux/types.h>
+#include <linux/iommu.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -1451,9 +1452,16 @@ static void platform_shutdown(struct device *_dev)
 
 static int platform_dma_configure(struct device *dev)
 {
+	struct platform_driver *drv = to_platform_driver(dev->driver);
 	enum dev_dma_attr attr;
 	int ret = 0;
 
+	if (!drv->no_kernel_api_dma) {
+		ret = iommu_device_use_dma_api(dev);
+		if (ret)
+			return ret;
+	}
+
 	if (dev->of_node) {
 		ret = of_dma_configure(dev, dev->of_node, true);
 	} else if (has_acpi_companion(dev)) {
@@ -1461,9 +1469,20 @@ static int platform_dma_configure(struct device *dev)
 		ret = acpi_dma_configure(dev, attr);
 	}
 
+	if (ret && !drv->no_kernel_api_dma)
+		iommu_device_unuse_dma_api(dev);
+
 	return ret;
 }
 
+static void platform_dma_cleanup(struct device *dev)
+{
+	struct platform_driver *drv = to_platform_driver(dev->driver);
+
+	if (!drv->no_kernel_api_dma)
+		iommu_device_unuse_dma_api(dev);
+}
+
 static const struct dev_pm_ops platform_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend, pm_generic_runtime_resume, NULL)
 	USE_PLATFORM_PM_SLEEP_OPS
@@ -1478,6 +1497,7 @@ struct bus_type platform_bus_type = {
 	.remove		= platform_remove,
 	.shutdown	= platform_shutdown,
 	.dma_configure	= platform_dma_configure,
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
