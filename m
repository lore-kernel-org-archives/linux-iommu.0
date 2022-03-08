Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617B7C433FE
	for <iommu@archiver.kernel.org>; Tue,  8 Mar 2022 05:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06BD860F19;
	Tue,  8 Mar 2022 05:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tm6pr7WWZVJG; Tue,  8 Mar 2022 05:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D20E960D78;
	Tue,  8 Mar 2022 05:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD6F2C001D;
	Tue,  8 Mar 2022 05:46:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72665C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 05:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 627CC82A6C
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 05:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zLAayrhEMapR for <iommu@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 05:46:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B76F682A3B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Mar 2022 05:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646718388; x=1678254388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=s2HXqS6jI07PkyQ1hBdhEcxNDCppyg0kFB1er61FyPs=;
 b=TQOWsjEoH4AWMJR6vOLmia1YXiTHdSJRwqw/oKzGQZPppYR69TmEnlPg
 X5TCRGADKSc1ZQgKbd/LbbjC5rUcSrpPNYqpoenaSEj3r14Qae+X2sdnN
 Olkk1QCWytuZfnvLfuEWVDXyRn/m0C40eGTVFIi+CeR6caD/KVuSWXTfD
 TINNnffAIuTTAlUtUNWi4387mmecjb00yQeL+/N/ZlHaGAsaYj8kl/36S
 lW7pb5eGYPcJhJPFDY9SgB0ZuOUBytRsNcOGpIDgEKJp6mGzgzRvAmlXy
 i8kVsrvcuhCTcinP5ib2fksXXATcbUg1RKApOn0XSTkqkw7BEqgczBgm/ g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254327366"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; d="scan'208";a="254327366"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2022 21:46:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; d="scan'208";a="537430108"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga007.jf.intel.com with ESMTP; 07 Mar 2022 21:46:21 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v8 03/11] amba: Stop sharing platform_dma_configure()
Date: Tue,  8 Mar 2022 13:44:13 +0800
Message-Id: <20220308054421.847385-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308054421.847385-1-baolu.lu@linux.intel.com>
References: <20220308054421.847385-1-baolu.lu@linux.intel.com>
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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
