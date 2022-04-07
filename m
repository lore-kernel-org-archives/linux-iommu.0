Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004AEC43219
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 16:21:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88057612B0;
	Thu,  7 Apr 2022 16:21:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 179nA8VNT1Y6; Thu,  7 Apr 2022 16:21:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 27CCC612A5;
	Thu,  7 Apr 2022 16:21:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4412C0088;
	Thu,  7 Apr 2022 16:21:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 778F8C001D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 567FD41B5C
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QJTdzDxa-Mnh for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 16:21:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E3C141A66
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=ZOsyiabOyxecdEuYc3kJmut49yeuPwIWNC6/tcRPR9U=; b=mGO/cGmneP/dZW/WsfodTl7Ogz
 PEIgQwvjqGOvP7HfvYwFaT5lZ8aiSS2eZytzyjxCYimAQmmbhaa1XR3DHQEzrXgYBYFHa9y/aDKte
 KBkPf5kd0p8cByNnJoSO8kvewiiTQkzGyCyZu6v/sHFK1gxwE5YqTXMRzT5xGU7IzKQ2r3RKXDMZj
 PodJrYUo+VDNunK+R/AUaAezTvlwUo2DqO4n5ScdgFWcOKAfGAOioZEhI77wVtDxIERDGGRALxYi/
 z08rJQMeWbD/I5CD4FzVjnAf+70lUu4R5y5IpAH+TB4u7hSmRxUk2GFkQSih31bgB28vH6hEiIhVA
 x5tOBmYQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMH-002BBh-KX; Thu, 07 Apr 2022 09:47:43 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMB-00021N-Kh; Thu, 07 Apr 2022 09:47:35 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  7 Apr 2022 09:46:59 -0600
Message-Id: <20220407154717.7695-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
References: <20220407154717.7695-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, logang@deltatee.com, bhelgaas@google.com,
 jhubbard@nvidia.com, rcampbell@nvidia.com, jgg@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v6 03/21] PCI/P2PDMA: Expose pci_p2pdma_map_type()
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
 Ralph Campbell <rcampbell@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Logan Gunthorpe <logang@deltatee.com>,
 Robin Murphy <robin.murphy@arm.com>,
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

pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
implementation because it will need to determine the mapping type
ahead of actually doing the mapping to create the actual IOMMU mapping.

Prototypes for this helper are added to dma-map-ops.h as they are only
useful to dma map implementations and don't need to pollute the public
pci-p2pdma header

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/pci/p2pdma.c        | 25 +++++++++++++--------
 include/linux/dma-map-ops.h | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index c3a68e82cf36..8573bf9d651a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "pci-p2pdma: " fmt
 #include <linux/ctype.h>
+#include <linux/dma-map-ops.h>
 #include <linux/pci-p2pdma.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -20,13 +21,6 @@
 #include <linux/seq_buf.h>
 #include <linux/xarray.h>
 
-enum pci_p2pdma_map_type {
-	PCI_P2PDMA_MAP_UNKNOWN = 0,
-	PCI_P2PDMA_MAP_NOT_SUPPORTED,
-	PCI_P2PDMA_MAP_BUS_ADDR,
-	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
-};
-
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
@@ -842,8 +836,21 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
 }
 EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
 
-static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
-						    struct device *dev)
+/**
+ * pci_p2pdma_map_type - return the type of mapping that should be used for
+ *	a given device and pgmap
+ * @pgmap: the pagemap of a page to determine the mapping type for
+ * @dev: device that is mapping the page
+ *
+ * Returns one of:
+ *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
+ *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
+ *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done normally
+ *		using the CPU physical address (in dma-direct) or an IOVA
+ *		mapping for the IOMMU.
+ */
+enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+					     struct device *dev)
 {
 	enum pci_p2pdma_map_type type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 0d5b06b3a4a6..d693a0e33bac 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -379,4 +379,49 @@ static inline void debug_dma_dump_mappings(struct device *dev)
 
 extern const struct dma_map_ops dma_dummy_ops;
 
+enum pci_p2pdma_map_type {
+	/*
+	 * PCI_P2PDMA_MAP_UNKNOWN: Used internally for indicating the mapping
+	 * type hasn't been calculated yet. Functions that return this enum
+	 * never return this value.
+	 */
+	PCI_P2PDMA_MAP_UNKNOWN = 0,
+
+	/*
+	 * PCI_P2PDMA_MAP_NOT_SUPPORTED: Indicates the transaction will
+	 * traverse the host bridge and the host bridge is not in the
+	 * allowlist. DMA Mapping routines should return an error when
+	 * this is returned.
+	 */
+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
+
+	/*
+	 * PCI_P2PDMA_BUS_ADDR: Indicates that two devices can talk to
+	 * each other directly through a PCI switch and the transaction will
+	 * not traverse the host bridge. Such a mapping should program
+	 * the DMA engine with PCI bus addresses.
+	 */
+	PCI_P2PDMA_MAP_BUS_ADDR,
+
+	/*
+	 * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE: Indicates two devices can talk
+	 * to each other, but the transaction traverses a host bridge on the
+	 * allowlist. In this case, a normal mapping either with CPU physical
+	 * addresses (in the case of dma-direct) or IOVA addresses (in the
+	 * case of IOMMUs) should be used to program the DMA engine.
+	 */
+	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
+};
+
+#ifdef CONFIG_PCI_P2PDMA
+enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
+					     struct device *dev);
+#else /* CONFIG_PCI_P2PDMA */
+static inline enum pci_p2pdma_map_type
+pci_p2pdma_map_type(struct dev_pagemap *pgmap, struct device *dev)
+{
+	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+}
+#endif /* CONFIG_PCI_P2PDMA */
+
 #endif /* _LINUX_DMA_MAP_OPS_H */
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
