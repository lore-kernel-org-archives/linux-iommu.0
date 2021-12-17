Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF903C433F5
	for <iommu@archiver.kernel.org>; Fri, 17 Dec 2021 06:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7887E41BD9;
	Fri, 17 Dec 2021 06:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M6ziI4kYMV06; Fri, 17 Dec 2021 06:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6487D417B8;
	Fri, 17 Dec 2021 06:38:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25831C002F;
	Fri, 17 Dec 2021 06:38:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 617A1C0012
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3E2AA40B66
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fTUXpl1CoiMh for <iommu@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 06:38:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 773F540B51
 for <iommu@lists.linux-foundation.org>; Fri, 17 Dec 2021 06:38:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="263864861"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="263864861"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Dec 2021 22:38:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; d="scan'208";a="519623324"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 16 Dec 2021 22:38:32 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v4 08/13] vfio: Set DMA USER ownership for VFIO devices
Date: Fri, 17 Dec 2021 14:37:03 +0800
Message-Id: <20211217063708.1740334-9-baolu.lu@linux.intel.com>
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

Set DMA_OWNER_PRIVATE_DOMAIN_USER when an iommu group is set to a
container, and release DMA_OWNER_USER once the iommu group is unset
from a container.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/vfio/fsl-mc/vfio_fsl_mc.c     |  1 +
 drivers/vfio/pci/vfio_pci.c           |  3 +++
 drivers/vfio/platform/vfio_amba.c     |  1 +
 drivers/vfio/platform/vfio_platform.c |  1 +
 drivers/vfio/vfio.c                   | 13 ++++++++++++-
 5 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc.c b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
index 6e2e62c6f47a..b749d092a185 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc.c
@@ -587,6 +587,7 @@ static struct fsl_mc_driver vfio_fsl_mc_driver = {
 	.driver	= {
 		.name	= "vfio-fsl-mc",
 		.owner	= THIS_MODULE,
+		.suppress_auto_claim_dma_owner = true,
 	},
 };
 
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index a5ce92beb655..ce3e814b5506 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -193,6 +193,9 @@ static struct pci_driver vfio_pci_driver = {
 	.remove			= vfio_pci_remove,
 	.sriov_configure	= vfio_pci_sriov_configure,
 	.err_handler		= &vfio_pci_core_err_handlers,
+	.driver			= {
+		.suppress_auto_claim_dma_owner = true,
+	},
 };
 
 static void __init vfio_pci_fill_ids(void)
diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index badfffea14fb..2146ee52901a 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -94,6 +94,7 @@ static struct amba_driver vfio_amba_driver = {
 	.drv = {
 		.name = "vfio-amba",
 		.owner = THIS_MODULE,
+		.suppress_auto_claim_dma_owner = true,
 	},
 };
 
diff --git a/drivers/vfio/platform/vfio_platform.c b/drivers/vfio/platform/vfio_platform.c
index 68a1c87066d7..5ef06e668192 100644
--- a/drivers/vfio/platform/vfio_platform.c
+++ b/drivers/vfio/platform/vfio_platform.c
@@ -75,6 +75,7 @@ static struct platform_driver vfio_platform_driver = {
 	.remove		= vfio_platform_remove,
 	.driver	= {
 		.name	= "vfio-platform",
+		.suppress_auto_claim_dma_owner = true,
 	},
 };
 
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 735d1d344af9..b75ba7551079 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -1198,6 +1198,9 @@ static void __vfio_group_unset_container(struct vfio_group *group)
 		driver->ops->detach_group(container->iommu_data,
 					  group->iommu_group);
 
+	iommu_group_release_dma_owner(group->iommu_group,
+				      DMA_OWNER_PRIVATE_DOMAIN_USER);
+
 	group->container = NULL;
 	wake_up(&group->container_q);
 	list_del(&group->container_next);
@@ -1282,13 +1285,21 @@ static int vfio_group_set_container(struct vfio_group *group, int container_fd)
 		goto unlock_out;
 	}
 
+	ret = iommu_group_set_dma_owner(group->iommu_group,
+					DMA_OWNER_PRIVATE_DOMAIN_USER, f.file);
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
+			iommu_group_release_dma_owner(group->iommu_group,
+						      DMA_OWNER_PRIVATE_DOMAIN_USER);
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
