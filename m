Return-Path: <SRS0=4FG6=EM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A403C388F2
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:33:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8832151B
	for <iommu@archiver.kernel.org>; Fri,  6 Nov 2020 17:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="q9ieAOfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8832151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E76A86BE4;
	Fri,  6 Nov 2020 17:33:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GJ7knam4T-AW; Fri,  6 Nov 2020 17:33:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A222186BC5;
	Fri,  6 Nov 2020 17:33:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F3B2C088B;
	Fri,  6 Nov 2020 17:33:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57FCAC088B
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 397E32045A
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6C3dmGc4Zbbc for <iommu@lists.linux-foundation.org>;
 Fri,  6 Nov 2020 17:33:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by silver.osuosl.org (Postfix) with ESMTPS id D9ECE2E16D
 for <iommu@lists.linux-foundation.org>; Fri,  6 Nov 2020 17:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q5mN94C0GkWo+VfB8UZJYJyJ0FbV13s+5fRAPuv9Vi0=; b=q9ieAOfgH5dn9nd+5h7la82GAr
 H6p3fUY3rpgzh4OPt3P1l1PuI9h7ecYxc7I5RndJ9a1n+B3tAZOi3clUR6aY36i+UdMJ4QIggspKI
 6yb0s5rFl52pn/iuYtn20KNAe0dPDeUcJ8r2/dH+kZBokpsnruyp6xIniH+mT6z1cfVu4jfHwFsJC
 Hya2i2aUU1+GBaL5H5SwAp5e2z/heNFpcz8WmQlpjcq2aUmtRexe2J/4Xs9krhy3OVkBJDAKfiql6
 45GoV6VNGLaXjtSsULb9F/djCFEJ6Wk3aUs+czOqwLS3/XaChCuurdh1t143XkBIpFwDoxq/zLNqq
 QaXyaDng==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kb56Z-0002PY-5k; Fri, 06 Nov 2020 10:00:53 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kb56U-0004sw-Eh; Fri, 06 Nov 2020 10:00:46 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Fri,  6 Nov 2020 10:00:24 -0700
Message-Id: <20201106170036.18713-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201106170036.18713-1-logang@deltatee.com>
References: <20201106170036.18713-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, dan.j.williams@intel.com,
 iweiny@intel.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org,
 daniel.vetter@ffwll.ch, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 03/15] PCI/P2PDMA: Introduce pci_p2pdma_should_map_bus()
 and pci_p2pdma_bus_offset()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: John Hubbard <jhubbard@nvidia.com>, Ira Weiny <iweiny@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dan Williams <dan.j.williams@intel.com>, Stephen Bates <sbates@raithlin.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
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

Introduce pci_p2pdma_should_map_bus() which is meant to be called by
dma map functions to determine how to map a given p2pdma page.

pci_p2pdma_bus_offset() is also added to allow callers to get the bus
offset if they need to map the bus address.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c       | 46 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-p2pdma.h | 11 +++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index ea8472278b11..9961e779f430 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -930,6 +930,52 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 }
 EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
 
+/**
+ * pci_p2pdma_bus_offset - returns the bus offset for a given page
+ * @page: page to get the offset for
+ *
+ * Must be passed a pci p2pdma page.
+ */
+u64 pci_p2pdma_bus_offset(struct page *page)
+{
+	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(page->pgmap);
+
+	WARN_ON(!is_pci_p2pdma_page(page));
+
+	return p2p_pgmap->bus_offset;
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_bus_offset);
+
+/**
+ * pci_p2pdma_should_map_bus - determine if a dma mapping should use the
+ *	bus address
+ * @dev: device doing the DMA request
+ * @pgmap: dev_pagemap structure for the mapping
+ *
+ * Returns 1 if the page should be mapped with a bus address, 0 otherwise
+ * and -1 the device should not be mapping P2PDMA pages.
+ */
+int pci_p2pdma_should_map_bus(struct device *dev, struct dev_pagemap *pgmap)
+{
+	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
+	struct pci_dev *client;
+
+	if (!dev_is_pci(dev))
+		return -1;
+
+	client = to_pci_dev(dev);
+
+	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
+	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
+		return 0;
+	case PCI_P2PDMA_MAP_BUS_ADDR:
+		return 1;
+	default:
+		return -1;
+	}
+}
+EXPORT_SYMBOL_GPL(pci_p2pdma_should_map_bus);
+
 /**
  * pci_p2pdma_enable_store - parse a configfs/sysfs attribute store
  *		to enable p2pdma
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 8318a97c9c61..fc5de47eeac4 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -34,6 +34,8 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
 void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 		int nents, enum dma_data_direction dir, unsigned long attrs);
+u64 pci_p2pdma_bus_offset(struct page *page);
+int pci_p2pdma_should_map_bus(struct device *dev, struct dev_pagemap *pgmap);
 int pci_p2pdma_enable_store(const char *page, struct pci_dev **p2p_dev,
 			    bool *use_p2pdma);
 ssize_t pci_p2pdma_enable_show(char *page, struct pci_dev *p2p_dev,
@@ -83,6 +85,15 @@ static inline void pci_p2pmem_free_sgl(struct pci_dev *pdev,
 static inline void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 {
 }
+static inline u64 pci_p2pdma_bus_offset(struct page *page)
+{
+	return -1;
+}
+static inline int pci_p2pdma_should_map_bus(struct device *dev,
+					    struct dev_pagemap *pgmap)
+{
+	return -1;
+}
 static inline int pci_p2pdma_map_sg_attrs(struct device *dev,
 		struct scatterlist *sg, int nents, enum dma_data_direction dir,
 		unsigned long attrs)
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
