Return-Path: <SRS0=YXze=KI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F636C2BCC4
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E04F6157F
	for <iommu@archiver.kernel.org>; Thu, 13 May 2021 22:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E04F6157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 19B0D60E0E;
	Thu, 13 May 2021 22:32:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TTGSy3JzAe0y; Thu, 13 May 2021 22:32:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07BA560AA2;
	Thu, 13 May 2021 22:32:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2920C0022;
	Thu, 13 May 2021 22:32:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C149AC0019
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CB8441847
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eV-fseyYlf_f for <iommu@lists.linux-foundation.org>;
 Thu, 13 May 2021 22:32:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3B1EA4182D
 for <iommu@lists.linux-foundation.org>; Thu, 13 May 2021 22:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=EsB08albNdgd1m+Vu0wFCNN3RogAXBpqgU7kG1WJKUc=; b=MMW2sBdz8FXiBcsaD7ZZwAQohL
 V/EJGpz6FW2Q2x2IIk1Wy3bjt5Tg47SpPx18PTdixkoI2/qpo3q5qiyQUTsepKMQfnCW1vBhCLhdo
 LM0hj3nOamif60N9rVSxMWICzELWZSW6nwDXZck7yyjWSaRuHHw3lVH6msb6I+yDQEpWEnN6dgNi1
 iqEuA6Be5GyB2MTUZa3Xtg1vMw/WK0OBDUON3QASGtbRr83hjFTA4bWHfL74nYaAHltlV/p8dGTCz
 0Ni4eJSosiU03NwmFq2cR4IaCzCy3lkVTbY//ssAVzm81P6gRQOZiMtWQmD62YNqrR1H3uYvJ7WRi
 2kE4uQVA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsY-0000nC-27; Thu, 13 May 2021 16:32:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsG-0001Sn-Ih; Thu, 13 May 2021 16:32:08 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 13 May 2021 16:31:48 -0600
Message-Id: <20210513223203.5542-8-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
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
Subject: [PATCH v2 07/22] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagemap and device
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

All callers of pci_p2pdma_map_type() have a struct dev_pgmap and a
struct device (of the client doing the DMA transfer). Thus move the
conversion to struct pci_devs for the provider and client into this
function.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 4034ffa0eb06..6c2057cd3f37 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -844,14 +844,21 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
-						    struct pci_dev *client)
+static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+						    struct device *dev)
 {
+	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
 	enum pci_p2pdma_map_type ret;
+	struct pci_dev *client;
 
 	if (!provider->p2pdma)
 		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 
+	if (!dev_is_pci(dev))
+		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+
+	client = to_pci_dev(dev);
+
 	ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
 				  map_types_idx(client)));
 	if (ret == PCI_P2PDMA_MAP_UNKNOWN)
@@ -892,14 +899,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 {
 	struct pci_p2pdma_pagemap *p2p_pgmap =
 		to_p2p_pgmap(sg_page(sg)->pgmap);
-	struct pci_dev *client;
-
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
-		return 0;
 
-	client = to_pci_dev(dev);
-
-	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
+	switch (pci_p2pdma_map_type(sg_page(sg)->pgmap, dev)) {
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
 		return dma_map_sg_attrs(dev, sg, nents, dir, attrs);
 	case PCI_P2PDMA_MAP_BUS_ADDR:
@@ -922,17 +923,9 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
-	struct pci_p2pdma_pagemap *p2p_pgmap =
-		to_p2p_pgmap(sg_page(sg)->pgmap);
 	enum pci_p2pdma_map_type map_type;
-	struct pci_dev *client;
-
-	if (WARN_ON_ONCE(!dev_is_pci(dev)))
-		return;
-
-	client = to_pci_dev(dev);
 
-	map_type = pci_p2pdma_map_type(p2p_pgmap->provider, client);
+	map_type = pci_p2pdma_map_type(sg_page(sg)->pgmap, dev);
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
 		dma_unmap_sg_attrs(dev, sg, nents, dir, attrs);
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
