Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193BCC433EF
	for <iommu@archiver.kernel.org>; Mon, 18 Apr 2022 00:52:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA57B40B53;
	Mon, 18 Apr 2022 00:52:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uheAh4jsLgQF; Mon, 18 Apr 2022 00:52:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 79B6940B52;
	Mon, 18 Apr 2022 00:52:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56685C002F;
	Mon, 18 Apr 2022 00:52:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 764AFC008C
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 00:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 63A3C41B39
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 00:52:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3T3l0--N9ueq for <iommu@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 00:52:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C78941A6B
 for <iommu@lists.linux-foundation.org>; Mon, 18 Apr 2022 00:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650243156; x=1681779156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fs2/qIGv4fyYDOG7R+kyP0PpTRznXTY23uT57syakyY=;
 b=BCOjcpbsSFQcrnGJimygjVZhfzEI9jXYpqGAmIujGU+hvc4fe4QyppC9
 LJr1XbvGdU8qxSN4y255qzaPTU1w6Sd+GYQ/LP5Pgt+/oA9TmwlIFbsgi
 OEmr5z9RuHrVXYVVoVKq9UscxMkI3RlrEV9HhY6kDtwgKIZ4+7QiK5GuH
 NKtR4Mh7+P0j110j/5AFox7GJN49onGnXwYCkq9Re5AxVeMP9JVyO50Vi
 lCSlHnWV0Xfm8hl3+9qa4fI8IkXdCytvO17rqT7BNZmAHoVtW7b5XZT/Y
 pQixMUeMnL5W4EiERJZNuqC8uKsWwuHLLAUcYoLa17T3xZZC6cpg7UPDY Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262284637"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; d="scan'208";a="262284637"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2022 17:52:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; d="scan'208";a="701651279"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [RESEND PATCH v8 02/11] driver core: Add dma_cleanup callback in
 bus_type
Date: Mon, 18 Apr 2022 08:49:51 +0800
Message-Id: <20220418005000.897664-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org
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

The bus_type structure defines dma_configure() callback for bus drivers
to configure DMA on the devices. This adds the paired dma_cleanup()
callback and calls it during driver unbinding so that bus drivers can do
some cleanup work.

One use case for this paired DMA callbacks is for the bus driver to check
for DMA ownership conflicts during driver binding, where multiple devices
belonging to a same IOMMU group (the minimum granularity of isolation and
protection) may be assigned to kernel drivers or user space respectively.

Without this change, for example, the vfio driver has to listen to a bus
BOUND_DRIVER event and then BUG_ON() in case of dma ownership conflict.
This leads to bad user experience since careless driver binding operation
may crash the system if the admin overlooks the group restriction. Aside
from bad design, this leads to a security problem as a root user, even with
lockdown=integrity, can force the kernel to BUG.

With this change, the bus driver could check and set the DMA ownership in
driver binding process and fail on ownership conflicts. The DMA ownership
should be released during driver unbinding.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/device/bus.h | 3 +++
 drivers/base/dd.c          | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index a039ab809753..d8b29ccd07e5 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -59,6 +59,8 @@ struct fwnode_handle;
  *		bus supports.
  * @dma_configure:	Called to setup DMA configuration on a device on
  *			this bus.
+ * @dma_cleanup:	Called to cleanup DMA configuration on a device on
+ *			this bus.
  * @pm:		Power management operations of this bus, callback the specific
  *		device driver's pm-ops.
  * @iommu_ops:  IOMMU specific operations for this bus, used to attach IOMMU
@@ -103,6 +105,7 @@ struct bus_type {
 	int (*num_vf)(struct device *dev);
 
 	int (*dma_configure)(struct device *dev);
+	void (*dma_cleanup)(struct device *dev);
 
 	const struct dev_pm_ops *pm;
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 3fc3b5940bb3..94b7ac9bf459 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -671,6 +671,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
 					     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
+	if (dev->bus && dev->bus->dma_cleanup)
+		dev->bus->dma_cleanup(dev);
 pinctrl_bind_failed:
 	device_links_no_driver(dev);
 	device_unbind_cleanup(dev);
@@ -1199,6 +1201,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 
 		device_remove(dev);
 
+		if (dev->bus && dev->bus->dma_cleanup)
+			dev->bus->dma_cleanup(dev);
+
 		device_links_driver_cleanup(dev);
 		device_unbind_cleanup(dev);
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
