Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CAEC43618
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3200C60FDB
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3200C60FDB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B46A84D75;
	Thu,  8 Apr 2021 17:01:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dOIyfD__YzZY; Thu,  8 Apr 2021 17:01:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B69F84D1F;
	Thu,  8 Apr 2021 17:01:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8991C0014;
	Thu,  8 Apr 2021 17:01:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 936B3C000C
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6ECA34195C
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DnLmD1w2I1Bk for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:01:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49502405A5
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=iSq2Wla16I0EwxIW4Pg1yf1bMgKpM0FYpfWiFtNqs7w=; b=rR8DAPvX19UEk5/HXMkfdOt7Uq
 JZZUtTjQdQLiA6ZsARzAVhUd/qyWJ+1ueNIw8BEjht46pmkpRGlprqdehWnTom6lrM06RYrYFDERj
 04fvSttGiBCnQMyfHxxIy6UWaowAWO4qEgQa7mOAV+S9Z7Bn0iU8MZKsqr56pxtAqxEB9xt6nIeIY
 kuKrq+iiQHSxhwO4dZ4pG32QX9+aMgfsiG+b3m0FyIfrp6ms2+txCbAYtqIoSuMAiaXDIsyTgiabv
 T707gBge1je59IJJJIAgVxKW987sBi++rH3N8rq8Kw94HBel2wQpUVzHLAMt1IRBowOqnYKnTxhJd
 KEWsWn+A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lUY26-0002Ln-Kj; Thu, 08 Apr 2021 11:01:31 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lUY25-0002Iu-Ee; Thu, 08 Apr 2021 11:01:29 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  8 Apr 2021 11:01:11 -0600
Message-Id: <20210408170123.8788-5-logang@deltatee.com>
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
Subject: [PATCH 04/16] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagmap and device
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
index 2574a062a255..bcb1a6d6119d 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -822,14 +822,21 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
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
 	if (ret != PCI_P2PDMA_MAP_UNKNOWN)
@@ -871,14 +878,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
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
@@ -901,17 +902,9 @@ EXPORT_SYMBOL_GPL(pci_p2pdma_map_sg_attrs);
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
