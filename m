Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D9BACCA487
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 16:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 040E840B05;
	Wed, 15 Jun 2022 16:13:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kaSlwxWW82bs; Wed, 15 Jun 2022 16:13:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AA0DC40BD3;
	Wed, 15 Jun 2022 16:13:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83423C0081;
	Wed, 15 Jun 2022 16:13:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E12AC002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 16:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 09E61829A9
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 16:12:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7mzqWorjqhfS for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 16:12:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 49A1A829FE
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=ZrjQH0Cup1rM4nd2GRv9TzKM0VooeR2ywa/jH43VO8E=; b=K8b3a3dLtKbLAQ6EXSvANzTKW7
 3dU+pmoDHBQAn7sU5St+kCSqesBVWJ4lYut+OeGrHoX68Ll1zV5tc6HClutZ7TB3pNyFXAwO4hLg+
 hQDPpja0a0r/3AvjLtBw98XXsTreXz5lLyXuffaL9rfY/dEiYcoNOnDfcBNwltLQbbOKxJdNxc0Rz
 1uENncVKvga+5BagrJPsBwuwx9DzG9LxScBVTTgwXNzqKH90kRniGUiJ0rt9+CJ5ixFsT07fLMxpP
 M/Y0MUscOGcW2knHL7l3cDhTqon3LpK4J7xo7UtDulpaN2V3IiRSkGtg6pJR2wUzormLlbKk2xqxv
 jFTOI/Ug==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1o1VdQ-0084iP-Qs; Wed, 15 Jun 2022 10:12:49 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1o1VdI-0004aY-Gc; Wed, 15 Jun 2022 10:12:40 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Wed, 15 Jun 2022 10:12:25 -0600
Message-Id: <20220615161233.17527-14-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220615161233.17527-1-logang@deltatee.com>
References: <20220615161233.17527-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com,
 robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com,
 logang@deltatee.com, bhelgaas@google.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, jgg@nvidia.com, mgurtovoy@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v7 13/21] PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
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

This interface is superseded by support in dma_map_sg() which now supports
heterogeneous scatterlists. There are no longer any users, so remove it.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/pci/p2pdma.c       | 66 --------------------------------------
 include/linux/pci-p2pdma.h | 27 ----------------
 2 files changed, 93 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 2fc0f4750a2e..d4e635012ffe 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -885,72 +885,6 @@ enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 	return type;
 }
 
-static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
-		struct device *dev, struct scatterlist *sg, int nents)
-{
-	struct scatterlist *s;
-	int i;
-
-	for_each_sg(sg, s, nents, i) {
-		s->dma_address = sg_phys(s) + p2p_pgmap->bus_offset;
-		sg_dma_len(s) = s->length;
-	}
-
-	return nents;
-}
-
-/**
- * pci_p2pdma_map_sg_attrs - map a PCI peer-to-peer scatterlist for DMA
- * @dev: device doing the DMA request
- * @sg: scatter list to map
- * @nents: elements in the scatterlist
- * @dir: DMA direction
- * @attrs: DMA attributes passed to dma_map_sg() (if called)
- *
- * Scatterlists mapped with this function should be unmapped using
- * pci_p2pdma_unmap_sg_attrs().
- *
- * Returns the number of SG entries mapped or 0 on error.
- */
-int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct pci_p2pdma_pagemap *p2p_pgmap =
-		to_p2p_pgmap(sg_page(sg)->pgmap);
-
-	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
-	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
-	case PCI_P2PDMA_MAP_BUS_ADDR:
-		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
-	default:
-		/* Mapping is not Supported */
-		return 0;
-	}
-}
-EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
-
-/**
- * pci_p2pdma_unmap_sg_attrs - unmap a PCI peer-to-peer scatterlist that was
- *	mapped with pci_p2pdma_map_sg()
- * @dev: device doing the DMA request
- * @sg: scatter list to map
- * @nents: number of elements returned by pci_p2pdma_map_sg()
- * @dir: DMA direction
- * @attrs: DMA attributes passed to dma_unmap_sg() (if called)
- */
-void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	enum pci_p2pdma_map_type map_type;
-
-	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
-
-	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
-}
-EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
-
 /**
  * pci_p2pdma_map_segment - map an sg segment determining the mapping type
  * @state: State structure that should be declared outside of the for_each_sg()
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 8318a97c9c61..2c07aa6b7665 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -30,10 +30,6 @@ struct scatterlist *pci_p2pmem_alloc_sgl(struct pci_dev *pdev,
 					 unsigned int *nents, u32 length);
 void pci_p2pmem_free_sgl(struct pci_dev *pdev, struct scatterlist *sgl);
 void pci_p2pmem_publish(struct pci_dev *pdev, bool publish);
-int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs);
-void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -83,17 +79,6 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
-static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	return 0;
-}
-static inline void pci_p2pdma_unmap_sg_attrs(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-}
 static inline int pci_p2pdma_enable_store(const char *page,
 		struct pci_dev **p2p_dev, bool *use_p2pdma)
 {
@@ -119,16 +104,4 @@ static inline struct pci_dev *pci_p2pmem_find(struct device *client)
 	return pci_p2pmem_find_many(&client, 1);
 }
 
-static inline int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg,
-				    int nents, enum dma_data_direction dir)
-{
-	return pci_p2pdma_map_sg_attrs(dev, sg, nents, dir, 0);
-}
-
-static inline void pci_p2pdma_unmap_sg(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir)
-{
-	pci_p2pdma_unmap_sg_attrs(dev, sg, nents, dir, 0);
-}
-
 #endif /* _LINUX_PCI_P2P_H */
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
