Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE618C433F5
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 00:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8773A4094E;
	Mon, 28 Feb 2022 00:53:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lWswENYmIys5; Mon, 28 Feb 2022 00:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5102640177;
	Mon, 28 Feb 2022 00:53:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AF42C0077;
	Mon, 28 Feb 2022 00:53:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 160F6C001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 00:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E94E44055F
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 00:53:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PQ_2N1xciW41 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 00:53:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD9304055D
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 00:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646009612; x=1677545612;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j9KuFOwZAmrrjwuxj/73EZ2xQwmqveJx5e6HJqReqdI=;
 b=IAkzMxQMFgzOIuWFBuncKkzuLITKBSeNd5bBeOHeCcELXe/J7f3xseP/
 R/eGzYoca+0O5/rvRKOEu4kbNEqniVmbetkUxg260C/C4X+GVvUwL8U+Q
 W/IN8MRr/6Akbv7dwSZ6Y5DZjOG6McFordF4eAmyUOm64DFsaiJkEy0ZV
 mKRtEZJcBkBoBb0XFhAA+T4n3XrI2cmlPR2BLzOf5RVBWsNvmfK4XrS1K
 K2Opx6zda41I8VB425ZC4du274/tV5kRrkgM93UlhFx5FIy4D732LoVSR
 lDBPKkUjS4Dy1DxwnnnV6A5GQyxxe5xFhkRkhPoxmpX0WHvEMohZMK/hw Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="252700327"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; d="scan'208";a="252700327"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2022 16:53:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; d="scan'208";a="550020278"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 27 Feb 2022 16:53:24 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v7 07/11] vfio: Set DMA ownership for VFIO devices
Date: Mon, 28 Feb 2022 08:50:52 +0800
Message-Id: <20220228005056.599595-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228005056.599595-1-baolu.lu@linux.intel.com>
References: <20220228005056.599595-1-baolu.lu@linux.intel.com>
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

Claim group dma ownership when an IOMMU group is set to a container,
and release the dma ownership once the iommu group is unset from the
container.

This change disallows some unsafe bridge drivers to bind to non-ACS
bridges while devices under them are assigned to user space. This is an
intentional enhancement and possibly breaks some existing
configurations. The recommendation to such an affected user would be
that the previously allowed host bridge driver was unsafe for this use
case and to continue to enable assignment of devices within that group,
the driver should be unbound from the bridge device or replaced with the
pci-stub driver.

For any bridge driver, we consider it unsafe if it satisfies any of the
following conditions:

  1) The bridge driver uses DMA. Calling pci_set_master() or calling any
     kernel DMA API (dma_map_*() and etc.) is an indicate that the
     driver is doing DMA.

  2) If the bridge driver uses MMIO, it should be tolerant to hostile
     userspace also touching the same MMIO registers via P2P DMA
     attacks.

If the bridge driver turns out to be a safe one, it could be used as
before by setting the driver's .driver_managed_dma field, just like what
we have done in the pcieport driver.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/vfio/fsl-mc/vfio_fsl_mc.c     |  1 +
 drivers/vfio/pci/vfio_pci.c           |  1 +
 drivers/vfio/platform/vfio_amba.c     |  1 +
 drivers/vfio/platform/vfio_platform.c |  1 +
 drivers/vfio/vfio.c                   | 10 +++++++++-
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 6e2e62c6f47a..3feff729f3ce 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -588,6 +588,7 @@ static struct fsl_mc_driver vfio_fsl_mc_driver = {
 		.name	= "vfio-fsl-mc",
 		.owner	= THIS_MODULE,
 	},
+	.driver_managed_dma = true,
 };
 
 static int __init vfio_fsl_mc_driver_init(void)
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index a5ce92beb655..941909d3918b 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -193,6 +193,7 @@ static struct pci_driver vfio_pci_driver = {
 	.remove			= vfio_pci_remove,
 	.sriov_configure	= vfio_pci_sriov_configure,
 	.err_handler		= &vfio_pci_core_err_handlers,
+	.driver_managed_dma	= true,
 };
 
 static void __init vfio_pci_fill_ids(void)
diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index badfffea14fb..1aaa4f721bd2 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -95,6 +95,7 @@ static struct amba_driver vfio_amba_driver = {
 		.name = "vfio-amba",
 		.owner = THIS_MODULE,
 	},
+	.driver_managed_dma = true,
 };
 
 module_amba_driver(vfio_amba_driver);
diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index 68a1c87066d7..04f40c5acfd6 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -76,6 +76,7 @@ static struct platform_driver vfio_platform_driver = {
 	.driver	= {
 		.name	= "vfio-platform",
 	},
+	.driver_managed_dma = true,
 };
 
 module_platform_driver(vfio_platform_driver);
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 735d1d344af9..df9d4b60e5ae 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1198,6 +1198,8 @@ static void __vfio_group_unset_container(struct vfio_group *group)
 		driver->ops->detach_group(container->iommu_data,
 					  group->iommu_group);
 
+	iommu_group_release_dma_owner(group->iommu_group);
+
 	group->container = NULL;
 	wake_up(&group->container_q);
 	list_del(&group->container_next);
@@ -1282,13 +1284,19 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 		goto unlock_out;
 	}
 
+	ret = iommu_group_claim_dma_owner(group->iommu_group, f.file);
+	if (ret)
+		goto unlock_out;
+
 	driver = container->iommu_driver;
 	if (driver) {
 		ret = driver->ops->attach_group(container->iommu_data,
 						group->iommu_group,
 						group->type);
-		if (ret)
+		if (ret) {
+			iommu_group_release_dma_owner(group->iommu_group);
 			goto unlock_out;
+		}
 	}
 
 	group->container = container;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
