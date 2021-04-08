Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB37C43617
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0196661177
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0196661177
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D047F84D63;
	Thu,  8 Apr 2021 17:01:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ft3En2gS1iiz; Thu,  8 Apr 2021 17:01:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0EAB84D7E;
	Thu,  8 Apr 2021 17:01:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 762C6C000C;
	Thu,  8 Apr 2021 17:01:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F76CC000C
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0A0B860C27
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wos-xgEKyqut for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:01:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BBB8960DE9
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=flK7AVROsAWPTBpHhkc1ioOIaxg1QDUQbObkXE3xVRk=; b=iHt+tHjpDCqThUdOdXRF9HfSfw
 KNXlTyqVkvY8G7kKWMV9DPMmPD/5B3Sw6SR3woTsOwnCmhXrGeo9I6Po3h2QXY7qCYMB4wnnYBxzu
 m2BDsINQbkc1hRwfeeYKXrD7GUMW7IcGe6tBW0QEVLkA+FNLz2wdG8585h+SPTrMvjL/5fy3tDnXz
 0G8kBwrsSkDDxVGJ0mDBkCzQRWDSKp2jRqXPUd9o0wXmbrKaWnqFA2ZixJXebw//4RWMfqZJ6v4EO
 +Lu2+psTmv0g/Irh2zayIgHNMU5ljvAP97EqEX3L+3DwX3aDzdv+6WeM1oenKyKx24Ev5seQhunPn
 sIQICdGg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lUY2G-0002Ll-Lh; Thu, 08 Apr 2021 11:01:41 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lUY26-0002J6-0C; Thu, 08 Apr 2021 11:01:30 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  8 Apr 2021 11:01:15 -0600
Message-Id: <20210408170123.8788-9-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 08/16] PCI/P2PDMA: Introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 John Hubbard <jhubbard@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
implementations. It takes an scatterlist segment that must point to a
pci_p2pdma struct page and will map it if the mapping requires a bus
address.

The return value indicates whether the mapping required a bus address
or whether the caller still needs to map the segment normally. If the
segment should not be mapped, -EREMOTEIO is returned.

This helper uses a state structure to track the changes to the
pgmap across calls and avoid needing to lookup into the xarray for
every page.

Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
dma_map_sg() implementations where the sg segment containing the page
differs from the sg segment containing the DMA address.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 65 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-p2pdma.h | 21 ++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 38c93f57a941..44ad7664e875 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -923,6 +923,71 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
+/**
+ * pci_p2pdma_map_segment - map an sg segment determining the mapping type
+ * @state: State structure that should be declared on the stack outside of
+ *	the for_each_sg() loop and initialized to zero.
+ * @dev: DMA device that's doing the mapping operation
+ * @sg: scatterlist segment to map
+ * @attrs: dma mapping attributes
+ *
+ * This is a helper to be used by non-iommu dma_map_sg() implementations where
+ * the sg segment is the same for the page_link and the dma_address.
+ *
+ * Attempt to map a single segment in an SGL with the PCI bus address.
+ * The segment must point to a PCI P2PDMA page and thus must be
+ * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
+ *
+ * Returns 1 if the segment was mapped, 0 if the segment should be mapped
+ * directly (or through the IOMMU) and -EREMOTEIO if the segment should not
+ * be mapped at all.
+ */
+int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
+			   struct device *dev, struct scatterlist *sg,
+			   unsigned long dma_attrs)
+{
+	if (state->pgmap != sg_page(sg)->pgmap) {
+		state->pgmap = sg_page(sg)->pgmap;
+		state->map = pci_p2pdma_map_type(state->pgmap, dev, dma_attrs);
+		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
+	}
+
+	switch (state->map) {
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		sg->dma_address = sg_phys(sg) + state->bus_off;
+		sg_dma_len(sg) = sg->length;
+		sg_mark_pci_p2pdma(sg);
+		return 1;
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		return 0;
+	default:
+		return -EREMOTEIO;
+	}
+}
+
+/**
+ * pci_p2pdma_map_bus_segment - map an sg segment pre determined to
+ *	be mapped with PCI_P2PDMA_MAP_BUS_ADDR
+ * @pg_sg: scatterlist segment with the page to map
+ * @dma_sg: scatterlist segment to assign a dma address to
+ *
+ * This is a helper for iommu dma_map_sg() implementations when the
+ * segment for the dma address differs from the segment containing the
+ * source page.
+ *
+ * pci_p2pdma_map_type() must have already been called on the pg_sg and
+ * returned PCI_P2PDMA_MAP_BUS_ADDR.
+ */
+void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+				struct scatterlist *dma_sg)
+{
+	struct pci_p2pdma_pagemap *pgmap = to_p2p_pgmap(sg_page(pg_sg)->pgmap);
+
+	dma_sg->dma_address = sg_phys(pg_sg) + pgmap->bus_offset;
+	sg_dma_len(dma_sg) = pg_sg->length;
+	sg_mark_pci_p2pdma(dma_sg);
+}
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index a06072ac3a52..49e7679403cf 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -13,6 +13,12 @@
 
 #include <linux/pci.h>
 
+struct pci_p2pdma_map_state {
+	struct dev_pagemap *pgmap;
+	int map;
+	u64 bus_off;
+};
+
 struct block_device;
 struct scatterlist;
 
@@ -43,6 +49,11 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
+int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
+		struct device *dev, struct scatterlist *sg,
+		unsigned long dma_attrs);
+void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+				struct scatterlist *dma_sg);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -109,6 +120,16 @@ static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
 		unsigned long attrs)
 {
 }
+static inline int pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state,
+		struct device *dev, struct scatterlist *sg,
+		unsigned long dma_attrs)
+{
+	return 0;
+}
+static inline void pci_p2pdma_map_bus_segment(struct scatterlist *pg_sg,
+					      struct scatterlist *dma_sg)
+{
+}
 static inline int pci_p2pdma_enable_store(const char *page,
 		struct pci_dev **p2p_dev, bool *use_p2pdma)
 {
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
