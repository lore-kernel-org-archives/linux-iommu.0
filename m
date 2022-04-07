Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7B7C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 16:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E792741B5C;
	Thu,  7 Apr 2022 16:22:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00mC3XehjI_h; Thu,  7 Apr 2022 16:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8376A41A68;
	Thu,  7 Apr 2022 16:22:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92F75C0089;
	Thu,  7 Apr 2022 16:22:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D956C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69FED40CCD
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bTQt2qW9Mzcz for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 16:22:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E255D40CD0
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=ZRqXik+AbRLmYtJfL+C2eBMnrjpO8efYUeKCeHmi1ik=; b=Lm33E960X0HEggurxTc5ED8v5F
 ArL+/Y4Xsll2xJBwqN1YYJqdImLFWp4CkBPMrxv6eTaRnsDdmr+Y0+M+lB/K7jb6kW3D5XynL/hCI
 PfIFa5SsohA5CLAzbD/ckpTiJwC0Qqn3osjKuD0IdXmFvCzWRIOCGm5xSktfZ3VW6/jroF2E+fExE
 JyN2gczLjgxvDCXYBAeDx2i8i64aGV0p2CKHYfTZi5YERkT6weMeCOYKlRAcg3WfwcNZJYeNl7Kfi
 UBTutMHgzzmQOdcPnqCPWz7qM+lBMMxDGg22S0jMYCPhl8Sx/2RZXy8IzPqv2NwqSOTUEHpS3wgXm
 bKBsrcSQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMH-002BBg-KW; Thu, 07 Apr 2022 09:47:43 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMB-00021K-G4; Thu, 07 Apr 2022 09:47:35 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu,  7 Apr 2022 09:46:58 -0600
Message-Id: <20220407154717.7695-3-logang@deltatee.com>
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
 jhubbard@nvidia.com, rcampbell@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v6 02/21] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Stephen Bates <sbates@raithlin.com>,
 Jason Ekstrand <jason@jlekstrand.net>, Ira Weiny <ira.weiny@intel.com>,
 Christoph Hellwig <hch@lst.de>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ralph Campbell <rcampbell@nvidia.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
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

Attempt to find the mapping type for P2PDMA pages on the first
DMA map attempt if it has not been done ahead of time.

Previously, the mapping type was expected to be calculated ahead of
time, but if pages are to come from userspace then there's no
way to ensure the path was checked ahead of time.

This change will calculate the mapping type if it hasn't pre-calculated
so it is no longer invalid to call pci_p2pdma_map_sg() before the mapping
type is calculated, so drop the WARN_ON when that is the case.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/pci/p2pdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 30b1df3c9d2f..c3a68e82cf36 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -849,6 +849,7 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
 	struct pci_dev *client;
 	struct pci_p2pdma *p2pdma;
+	int dist;
 
 	if (!provider->p2pdma)
 		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
@@ -865,6 +866,10 @@ static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
 		type = xa_to_value(xa_load(&p2pdma->map_types,
 					   map_types_idx(client)));
 	rcu_read_unlock();
+
+	if (type == PCI_P2PDMA_MAP_UNKNOWN)
+		return calc_map_type_and_dist(provider, client, &dist, true);
+
 	return type;
 }
 
@@ -907,7 +912,7 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	case PCI_P2PDMA_MAP_BUS_ADDR:
 		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
 	default:
-		WARN_ON_ONCE(1);
+		/* Mapping is not Supported */
 		return 0;
 	}
 }
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
