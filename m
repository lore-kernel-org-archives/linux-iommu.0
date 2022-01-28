Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38500C4321E
	for <iommu@archiver.kernel.org>; Fri, 28 Jan 2022 00:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D53FE60BAD;
	Fri, 28 Jan 2022 00:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1R8M6_rb7Fna; Fri, 28 Jan 2022 00:26:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A76C460F4D;
	Fri, 28 Jan 2022 00:26:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ADD8C0039;
	Fri, 28 Jan 2022 00:26:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1164AC0031
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE24E84E3B
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:26:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w80q6eJTuV4l for <iommu@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 00:26:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8367484E44
 for <iommu@lists.linux-foundation.org>; Fri, 28 Jan 2022 00:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=SthFkrlch6Gbtf7JBQRiLJWdMmfUwEHz21EJfjIo+fM=; b=lVrUYYfTM6XGioXpaDhU8TWgMB
 vgyWwjfvd+30vJr+Otba/J2QVHspa3Wu4+iov+2m7rQKOg5weIdMqzazQUbzDHYz/fRPbobbTjO5b
 UNyFiauFRkM9u2G++t+v4M1vLtkmowFWMS9373R6QZsbG3PhE5YTIr3/j4GDVPVe3OLyDlBMdmJqN
 mFzzocv2QiaF5iml93QU7vLdFzdslWKLSEW57Lr82qElnNWvYeCTRV0ZIo+wIg2pZ9fvKyNQPfiOM
 XaVP54CtEyu7JavZqVHJGtJIBrobriUCTzscqeKhItJJolN6bghr2ERmQE1rWPH+JQMp6U7Sa+gRR
 IfM3RwOQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5t-005OcZ-MY; Thu, 27 Jan 2022 17:26:26 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1nDF5o-0001ct-6H; Thu, 27 Jan 2022 17:26:20 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Date: Thu, 27 Jan 2022 17:26:03 -0700
Message-Id: <20220128002614.6136-14-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220128002614.6136-1-logang@deltatee.com>
References: <20220128002614.6136-1-logang@deltatee.com>
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
 ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, jgg@nvidia.com, mgurtovoy@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 13/24] RDMA/core: introduce ib_dma_pci_p2p_dma_supported()
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
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
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

Introduce the helper function ib_dma_pci_p2p_dma_supported() to check
if a given ib_device can be used in P2PDMA transfers. This ensures
the ib_device is not using virt_dma and also that the underlying
dma_device supports P2PDMA.

Use the new helper in nvme-rdma to replace the existing check for
ib_uses_virt_dma(). Adding the dma_pci_p2pdma_supported() check allows
switching away from pci_p2pdma_[un]map_sg().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c |  2 +-
 include/rdma/ib_verbs.h    | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1deb4043e242..22519739a874 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -415,7 +415,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
 		goto out_free_rsp;
 
-	if (!ib_uses_virt_dma(ndev->device))
+	if (ib_dma_pci_p2p_dma_supported(ndev->device))
 		r->req.p2p_client = &ndev->device->dev;
 	r->send_sge.length = sizeof(*r->req.cqe);
 	r->send_sge.lkey = ndev->pd->local_dma_lkey;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 69d883f7fb41..79609ab73014 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4003,6 +4003,17 @@ static inline bool ib_uses_virt_dma(struct ib_device *dev)
 	return IS_ENABLED(CONFIG_INFINIBAND_VIRT_DMA) && !dev->dma_device;
 }
 
+/*
+ * Check if a IB device's underlying DMA mapping supports P2PDMA transfers.
+ */
+static inline bool ib_dma_pci_p2p_dma_supported(struct ib_device *dev)
+{
+	if (ib_uses_virt_dma(dev))
+		return false;
+
+	return dma_pci_p2pdma_supported(dev->dma_device);
+}
+
 /**
  * ib_dma_mapping_error - check a DMA addr for error
  * @dev: The device for which the dma_addr was created
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
