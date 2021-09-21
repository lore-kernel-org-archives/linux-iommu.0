Return-Path: <SRS0=Rn8G=OM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA87C433FE
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80716105A
	for <iommu@archiver.kernel.org>; Wed, 22 Sep 2021 05:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E80716105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B926B40482;
	Wed, 22 Sep 2021 05:13:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z40LpoWjgRMB; Wed, 22 Sep 2021 05:13:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3755F40428;
	Wed, 22 Sep 2021 05:13:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09EE0C0021;
	Wed, 22 Sep 2021 05:13:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DCE9C000D
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CA9B40245
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tA13PTxHJMTu for <iommu@lists.linux-foundation.org>;
 Wed, 22 Sep 2021 05:13:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B7FA4403E8
 for <iommu@lists.linux-foundation.org>; Wed, 22 Sep 2021 05:13:12 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="287187648"
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="287187648"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2021 22:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,312,1624345200"; d="scan'208";a="550107674"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by FMSMGA003.fm.intel.com with ESMTP; 21 Sep 2021 22:13:11 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
 "Christoph Hellwig" <hch@infradead.org>
Subject: [RFC 2/7] dma-iommu: Add API for DMA request with PASID
Date: Tue, 21 Sep 2021 13:29:36 -0700
Message-Id: <1632256181-36071-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar,
 Sanjay K" <sanjay.k.kumar@intel.com>, mike.campin@intel.com
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

DMA-API is the standard way for device drivers to perform in-kernel
DMA requests. If security is on, isolation is enforced by the IOMMU at
requester ID (RID) granularity. With the introduction of process address
space ID (PASID), DMA security is enforced per RID+PASID
granularity. On some modern platforms, DMA request with PASID is the
only option available. e.g. The shared work queues in Intel Data
Streaming Accelerators (DSA).
To support DMA with PASID while maintaining the ubiquitous usage of DMA
API, this patch introduces a new IOMMU DMA API that supports two
addressing modes:
1. Physical address or bypass mode. This is similar to DMA direct mode,
where trusted devices can DMA passthrough IOMMU.
2. IOVA mode that abides DMA APIs. Once set up, callers can use DMA API
as-is. DMA requests w/ and w/o PASID will be mapped by the same page
tables.  i.e. the default DMA domain will be used by both RID and
RID+PASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 54 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-iommu.h | 12 +++++++++
 include/linux/iommu.h     |  2 ++
 3 files changed, 68 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..490731659def 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -174,6 +174,60 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 }
 EXPORT_SYMBOL(iommu_put_dma_cookie);
 
+/**
+ * iommu_dma_pasid_enable --Enable device DMA request with PASID
+ * @dev:	Device to be enabled
+ * @mode:	DMA addressing mode
+ *
+ * The following mutually exclusive DMA addressing modes are supported:
+ *
+ *  1. Physical address or bypass mode. This is similar to DMA direct where
+ *     trusted devices can DMA pass-through IOMMU.
+ *
+ *  2. IOVA mode. This abides DMA APIs. Once set up, callers can use DMA API
+ *     as-is. DMA request w/ and w/o PASID will be mapped by the same page
+ *     tables. PCI requester ID (RID) and RID+PASID will be pointed to the same
+ *     PGD. i.e. the default DMA domain will be used by both RID and RID+PASID.
+ *
+ * @return the supervisor PASID to be used for DMA. Or INVALID_IOASID upon
+ *     failure.
+ */
+int iommu_dma_pasid_enable(struct device *dev,
+			   enum iommu_dma_pasid_mode mode)
+{
+	int pasid = INVALID_IOASID;
+	struct iommu_domain *dom = NULL;
+
+	/* TODO: only allow a single mode each time, track PASID DMA enabling
+	 * status per device. Perhaps add a flag in struct device.dev_iommu.
+	 */
+
+	/* Call vendor drivers to handle IOVA, bypass mode */
+	dom = iommu_get_domain_for_dev(dev);
+	if (dom->ops->enable_pasid_dma(dev, IOASID_DMA_PASID, mode)) {
+		dev_dbg(dev, "Failed to enable DMA pasid in mode %d", mode);
+		goto exit;
+	}
+	pasid = IOASID_DMA_PASID;
+
+	dev_dbg(dev, "Enable DMA pasid %d in mode %d", pasid, mode);
+	goto exit;
+exit:
+	return pasid;
+}
+EXPORT_SYMBOL(iommu_dma_pasid_enable);
+
+int iommu_dma_pasid_disable(struct device *dev)
+{
+	struct iommu_domain *dom;
+
+	/* Call vendor iommu ops to clean up supervisor PASID context */
+	dom = iommu_get_domain_for_dev(dev);
+
+	return dom->ops->disable_pasid_dma(dev);
+}
+EXPORT_SYMBOL(iommu_dma_pasid_disable);
+
 /**
  * iommu_dma_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 6e75a2d689b4..3c1555e0fd51 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -17,6 +17,18 @@
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
+enum iommu_dma_pasid_mode {
+	/* Pass-through mode, use physical address */
+	IOMMU_DMA_PASID_BYPASS = 1,
+	/* Compatible with DMA APIs, same mapping as DMA w/o PASID */
+	IOMMU_DMA_PASID_IOVA,
+};
+/* For devices that can do DMA request with PASID, setup the system
+ * based on the address mode selected.
+ */
+int iommu_dma_pasid_enable(struct device *dev,
+			   enum iommu_dma_pasid_mode mode);
+int iommu_dma_pasid_disable(struct device *dev);
 
 /* Setup call for arch DMA mapping code */
 void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..610cbfd03e6b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -283,6 +283,8 @@ struct iommu_ops {
 
 	int (*def_domain_type)(struct device *dev);
 
+	int (*enable_pasid_dma)(struct device *dev, u32 pasid, int mode);
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
