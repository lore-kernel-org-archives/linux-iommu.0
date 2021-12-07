Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ECEC433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 22:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 59B6D60EE0;
	Tue,  7 Dec 2021 22:35:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z_DcAxVrNCTF; Tue,  7 Dec 2021 22:35:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1BD7F60EE5;
	Tue,  7 Dec 2021 22:35:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF04AC002F;
	Tue,  7 Dec 2021 22:35:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E8D1C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 22:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 759AB82C18
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 22:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d7wfmGQUBcmd for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 22:35:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B051682C38
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 22:35:10 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="224958940"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; d="scan'208";a="224958940"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2021 14:35:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; d="scan'208";a="515845493"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2021 14:35:03 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [PATCH 2/4] iommu: Add PASID support for DMA mapping API users
Date: Tue,  7 Dec 2021 05:47:12 -0800
Message-Id: <1638884834-83028-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Barry Song <21cnbao@gmail.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
 Jacob Pan <jacob.jun.pan@intel.com>, "Zanussi, Tom" <tom.zanussi@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

DMA mapping API is the de facto standard for in-kernel DMA. It operates
on a per device/RID basis which is not PASID-aware.

Some modern devices such as Intel Data Streaming Accelerator, PASID is
required for certain work submissions. To allow such devices use DMA
mapping API, we need the following functionalities:
1. Provide device a way to retrieve a kernel PASID for work submission
2. Enable the kernel PASID on the IOMMU
3. Establish address space for the kernel PASID that matches the default
   domain. Let it be IOVA or physical address in case of pass-through.

This patch introduces a driver facing API that enables DMA API
PASID usage. Once enabled, device drivers can continue to use DMA APIs as
is. There is no difference in dma_handle between without PASID and with
PASID.

To manage device IOTLB flush at PASID level, this patch also introduces
a .pasid field to struct device. This also serves as a flag indicating
whether PASID is being used for the device to perform in-kernel DMA.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 71 +++++++++++++++++++++++++++++++++++++++
 include/linux/device.h    |  1 +
 include/linux/dma-iommu.h |  7 ++++
 include/linux/iommu.h     |  4 +++
 4 files changed, 83 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index b42e38a0dbe2..8855d5e99d8e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -167,6 +167,77 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	domain->iova_cookie = NULL;
 }
 
+/**
+ * iommu_enable_pasid_dma --Enable in-kernel DMA request with PASID
+ * @dev:	Device to be enabled
+ *
+ * DMA request with PASID will be mapped the same way as the legacy DMA.
+ * If the device is in pass-through, PASID will also pass-through. If the
+ * device is in IOVA map, the supervisor PASID will point to the same IOVA
+ * page table.
+ *
+ * @return the kernel PASID to be used for DMA or INVALID_IOASID on failure
+ */
+ioasid_t iommu_enable_pasid_dma(struct device *dev)
+{
+	struct iommu_domain *dom;
+
+	if (dev->pasid) {
+		dev_err(dev, "PASID DMA already enabled\n");
+		return IOASID_DMA_PASID;
+	}
+	dom = iommu_get_domain_for_dev(dev);
+
+	if (!dom) {
+		dev_err(dev, "No IOMMU domain\n");
+		return INVALID_IOASID;
+	}
+
+	/*
+	 * Use the reserved kernel PASID for all devices. For now,
+	 * there is no need to have different PASIDs for in-kernel use.
+	 */
+	if (!dom->ops->enable_pasid_dma || dom->ops->enable_pasid_dma(dev, IOASID_DMA_PASID))
+		return INVALID_IOASID;
+	/* Used for device IOTLB flush */
+	dev->pasid = IOASID_DMA_PASID;
+
+	return IOASID_DMA_PASID;
+}
+EXPORT_SYMBOL(iommu_enable_pasid_dma);
+
+/**
+ * iommu_disable_pasid_dma --Disable in-kernel DMA request with PASID
+ * @dev:	Device's PASID DMA to be disabled
+ *
+ * It is the device driver's responsibility to ensure no more incoming DMA
+ * requests with the kernel PASID before calling this function. IOMMU driver
+ * ensures PASID cache, IOTLBs related to the kernel PASID are cleared and
+ * drained.
+ *
+ * @return 0 on success or error code on failure
+ */
+int iommu_disable_pasid_dma(struct device *dev)
+{
+	struct iommu_domain *dom;
+	int ret = 0;
+
+	if (!dev->pasid) {
+		dev_err(dev, "PASID DMA not enabled\n");
+		return -ENODEV;
+	}
+	dom = iommu_get_domain_for_dev(dev);
+	if (!dom->ops->disable_pasid_dma)
+		return -ENOTSUPP;
+
+	ret = dom->ops->disable_pasid_dma(dev);
+	if (!ret)
+		dev->pasid = 0;
+
+	return ret;
+}
+EXPORT_SYMBOL(iommu_disable_pasid_dma);
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/device.h b/include/linux/device.h
index e270cb740b9e..8afa033b8b0b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -559,6 +559,7 @@ struct device {
 	void	(*release)(struct device *dev);
 	struct iommu_group	*iommu_group;
 	struct dev_iommu	*iommu;
+	u32			pasid;	/* For in-kernel DMA w/ PASID */
 
 	enum device_removable	removable;
 
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 24607dc3c2ac..298b31e3a007 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -18,6 +18,13 @@ int iommu_get_dma_cookie(struct iommu_domain *domain);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
 
+/*
+ * For devices that can do DMA request with PASID, setup a system PASID.
+ * Address modes (IOVA, PA) are selected by the platform code.
+ */
+ioasid_t iommu_enable_pasid_dma(struct device *dev);
+int iommu_disable_pasid_dma(struct device *dev);
+
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
 int iommu_dma_init_fq(struct iommu_domain *domain);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d2f3435e7d17..45d281849c93 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -236,6 +236,8 @@ struct iommu_iotlb_gather {
  *		- IOMMU_DOMAIN_IDENTITY: must use an identity domain
  *		- IOMMU_DOMAIN_DMA: must use a dma domain
  *		- 0: use the default setting
+ * @enable_pasid_dma: Set up PASID for in-kernel DMA
+ * @disable_pasid_dma: Disable in-kernel DMA with PASID on the device
  * @pgsize_bitmap: bitmap of all possible supported page sizes
  * @owner: Driver module providing these ops
  */
@@ -310,6 +312,8 @@ struct iommu_ops {
 
 	int (*def_domain_type)(struct device *dev);
 
+	int (*enable_pasid_dma)(struct device *dev, u32 pasid);
+	int (*disable_pasid_dma)(struct device *dev);
 	unsigned long pgsize_bitmap;
 	struct module *owner;
 };
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
