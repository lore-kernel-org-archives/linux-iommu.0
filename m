Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918B3C433EF
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 02:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 596CF4051E;
	Mon,  6 Dec 2021 02:01:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hqi-Gla1bUhl; Mon,  6 Dec 2021 02:01:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE3D7404CA;
	Mon,  6 Dec 2021 02:01:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97B68C001E;
	Mon,  6 Dec 2021 02:01:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2872FC0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1767D60A4E
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:01:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fhGix0hWoGW8 for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 02:01:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5ED2560788
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 02:01:40 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="224099270"
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="224099270"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Dec 2021 18:01:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,290,1631602800"; d="scan'208";a="514542734"
Received: from allen-box.sh.intel.com ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 05 Dec 2021 18:01:32 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v3 18/18] drm/tegra: Use the iommu dma_owner mechanism
Date: Mon,  6 Dec 2021 09:59:03 +0800
Message-Id: <20211206015903.88687-19-baolu.lu@linux.intel.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

Tegra joins many platform devices onto the same iommu_domain and builds
sort-of a DMA API on top of it.

Given that iommu_attach/detatch_device_shared() has supported this usage
model. Each device that wants to use the special domain will use
suppress_auto_claim_dma_owner and call iommu_attach_device_shared() which
will use dma owner framework to lock out other usages of the group and
refcount the domain attachment.

When the last device calls detatch the domain will be disconnected.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com> # Nexus7 T30
---
 drivers/gpu/drm/tegra/dc.c   |  1 +
 drivers/gpu/drm/tegra/drm.c  | 55 ++++++++++++++++++------------------
 drivers/gpu/drm/tegra/gr2d.c |  1 +
 drivers/gpu/drm/tegra/gr3d.c |  1 +
 drivers/gpu/drm/tegra/vic.c  |  1 +
 5 files changed, 31 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index a29d64f87563..3a2458f56fbc 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -3111,4 +3111,5 @@ struct platform_driver tegra_dc_driver = {
 	},
 	.probe = tegra_dc_probe,
 	.remove = tegra_dc_remove,
+	.suppress_auto_claim_dma_owner = true,
 };
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 8d37d6b00562..1e83e3f5da5b 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -928,12 +928,15 @@ int tegra_drm_unregister_client(struct tegra_drm *tegra,
 	return 0;
 }
 
+/*
+ * Clients which use this function must set suppress_auto_claim_dma_owner in
+ * their platform_driver's device_driver struct.
+ */
 int host1x_client_iommu_attach(struct host1x_client *client)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(client->dev);
 	struct drm_device *drm = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = drm->dev_private;
-	struct iommu_group *group = NULL;
 	int err;
 
 	/*
@@ -941,48 +944,44 @@ int host1x_client_iommu_attach(struct host1x_client *client)
 	 * not the shared IOMMU domain, don't try to attach it to a different
 	 * domain. This allows using the IOMMU-backed DMA API.
 	 */
-	if (domain && domain != tegra->domain)
+	client->group = NULL;
+	if (!client->dev->iommu_group || (domain && domain != tegra->domain))
+		return iommu_device_set_dma_owner(client->dev,
+						  DMA_OWNER_DMA_API, NULL);
+
+	if (!tegra->domain)
 		return 0;
 
-	if (tegra->domain) {
-		group = iommu_group_get(client->dev);
-		if (!group)
-			return -ENODEV;
-
-		if (domain != tegra->domain) {
-			err = iommu_attach_group(tegra->domain, group);
-			if (err < 0) {
-				iommu_group_put(group);
-				return err;
-			}
-		}
+	err = iommu_device_set_dma_owner(client->dev,
+					 DMA_OWNER_PRIVATE_DOMAIN, NULL);
+	if (err)
+		return err;
 
-		tegra->use_explicit_iommu = true;
+	err = iommu_attach_device_shared(tegra->domain, client->dev);
+	if (err) {
+		iommu_device_release_dma_owner(client->dev,
+					       DMA_OWNER_PRIVATE_DOMAIN);
+		return err;
 	}
 
-	client->group = group;
-
+	tegra->use_explicit_iommu = true;
+	client->group = client->dev->iommu_group;
 	return 0;
 }
 
 void host1x_client_iommu_detach(struct host1x_client *client)
 {
+	struct iommu_domain *domain = iommu_get_domain_for_dev(client->dev);
 	struct drm_device *drm = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = drm->dev_private;
-	struct iommu_domain *domain;
 
 	if (client->group) {
-		/*
-		 * Devices that are part of the same group may no longer be
-		 * attached to a domain at this point because their group may
-		 * have been detached by an earlier client.
-		 */
-		domain = iommu_get_domain_for_dev(client->dev);
-		if (domain)
-			iommu_detach_group(tegra->domain, client->group);
-
-		iommu_group_put(client->group);
+		iommu_detach_device_shared(tegra->domain, client->dev);
+		iommu_device_release_dma_owner(client->dev,
+					       DMA_OWNER_PRIVATE_DOMAIN);
 		client->group = NULL;
+	} else {
+		iommu_device_release_dma_owner(client->dev, DMA_OWNER_DMA_API);
 	}
 }
 
diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index de288cba3905..8d92141c3c86 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -271,4 +271,5 @@ struct platform_driver tegra_gr2d_driver = {
 	},
 	.probe = gr2d_probe,
 	.remove = gr2d_remove,
+	.suppress_auto_claim_dma_owner = true,
 };
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 24442ade0da3..33c4954977ab 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -400,4 +400,5 @@ struct platform_driver tegra_gr3d_driver = {
 	},
 	.probe = gr3d_probe,
 	.remove = gr3d_remove,
+	.suppress_auto_claim_dma_owner = true,
 };
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index c02010ff2b7f..114df067ea00 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -527,6 +527,7 @@ struct platform_driver tegra_vic_driver = {
 	},
 	.probe = vic_probe,
 	.remove = vic_remove,
+	.suppress_auto_claim_dma_owner = true,
 };
 
 #if IS_ENABLED(CONFIG_ARCH_TEGRA_124_SOC)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
