Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D7EC43219
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 00:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D514C60A7E;
	Fri, 18 Feb 2022 00:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C7-U-rBt23KN; Fri, 18 Feb 2022 00:58:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9ABEB6F790;
	Fri, 18 Feb 2022 00:58:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C854C0070;
	Fri, 18 Feb 2022 00:58:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C183EC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:58:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B120460A7E
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XrBG0svV2XPo for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 00:58:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E6A6600B4
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645145907; x=1676681907;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XVtrp5CXpsHCwBQycR6v9oNHcVdGH3D8kDHPzvy+WZQ=;
 b=KvbAksedtig64Nm8niY7N59HRx84Y4VCeiBwYaLnRNRqdVD1yknhrZIk
 lxIhMYl+rhTAEl4AgGVyxhURoDUaW3kJ8Rty0pJkyil5WlsXFNLJr0dS3
 idbdz4jvu2MLy1/3/U9VR6LsrWwg2ySF6xj8eft/7R+PsZoQ3e4rtVDh+
 fnt1v4oSHaBIE0GLnM1GP9mdyL5wlz1oGsUmJ+PqWyj1QhGlmOcwE6Uwi
 zPzLKmH8sTP8+r5ObBWj9swMTVMssHAZN6PSlVc7OGiOBD7xIwd3bpA5z
 oZzf0hkHo3RzEk77akFGm1EhaM5m4tg8gz4glYLgqJERZRQ9z8kB3TQVA g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231001120"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="231001120"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2022 16:57:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; d="scan'208";a="637490811"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga004.jf.intel.com with ESMTP; 17 Feb 2022 16:57:09 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v6 03/11] amba: Stop sharing platform_dma_configure()
Date: Fri, 18 Feb 2022 08:55:13 +0800
Message-Id: <20220218005521.172832-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218005521.172832-1-baolu.lu@linux.intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
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

Stop sharing platform_dma_configure() helper as they are about to have
their own bus dma_configure callbacks.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/platform_device.h |  2 --
 drivers/amba/bus.c              | 19 ++++++++++++++++++-
 drivers/base/platform.c         |  3 +--
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7c96f169d274..17fde717df68 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -328,8 +328,6 @@ extern int platform_pm_restore(struct device *dev);
 #define platform_pm_restore		NULL
 #endif
 
-extern int platform_dma_configure(struct device *dev);
-
 #ifdef CONFIG_PM_SLEEP
 #define USE_PLATFORM_PM_SLEEP_OPS \
 	.suspend = platform_pm_suspend, \
diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index e1a5eca3ae3c..8392f4aa251b 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -20,6 +20,8 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/of_irq.h>
+#include <linux/of_device.h>
+#include <linux/acpi.h>
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
@@ -273,6 +275,21 @@ static void amba_shutdown(struct device *dev)
 		drv->shutdown(to_amba_device(dev));
 }
 
+static int amba_dma_configure(struct device *dev)
+{
+	enum dev_dma_attr attr;
+	int ret = 0;
+
+	if (dev->of_node) {
+		ret = of_dma_configure(dev, dev->of_node, true);
+	} else if (has_acpi_companion(dev)) {
+		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
+		ret = acpi_dma_configure(dev, attr);
+	}
+
+	return ret;
+}
+
 #ifdef CONFIG_PM
 /*
  * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
@@ -341,7 +358,7 @@ struct bus_type amba_bustype = {
 	.probe		= amba_probe,
 	.remove		= amba_remove,
 	.shutdown	= amba_shutdown,
-	.dma_configure	= platform_dma_configure,
+	.dma_configure	= amba_dma_configure,
 	.pm		= &amba_pm,
 };
 EXPORT_SYMBOL_GPL(amba_bustype);
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 6cb04ac48bf0..acbc6eae37b8 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1454,8 +1454,7 @@ static void platform_shutdown(struct device *_dev)
 		drv->shutdown(dev);
 }
 
-
-int platform_dma_configure(struct device *dev)
+static int platform_dma_configure(struct device *dev)
 {
 	enum dev_dma_attr attr;
 	int ret = 0;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
