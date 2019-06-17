Return-Path: <SRS0=Kmd8=UQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F75AC31E58
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:36:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51E5B20657
	for <iommu@archiver.kernel.org>; Mon, 17 Jun 2019 13:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51E5B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 1E4D0D1A;
	Mon, 17 Jun 2019 13:36:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D7822CD1
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:36:32 +0000 (UTC)
X-Greylist: delayed 00:05:38 by SQLgrey-1.7.6
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EA4DF822
	for <iommu@lists.linux-foundation.org>;
	Mon, 17 Jun 2019 13:36:31 +0000 (UTC)
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
	(mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
	1Mnq8Y-1iQnn21uzS-00pKbB; Mon, 17 Jun 2019 15:29:50 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] swiotlb: fix phys_addr_t overflow warning
Date: Mon, 17 Jun 2019 15:28:43 +0200
Message-Id: <20190617132946.2817440-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:WxAlzhRk05Boo+/YM4l5i3GHyI9GeBc8OiWCfJusR6LAoI1zMkq
	mI5T09W/WmD7J75VlpcbwtZqQ0SrDUbM08mliK9OyOpw5VGdZN1zx6lKdkmnejKI2IWefXV
	gD87Cuo+tKgxk+8DVFi5MULUIVmtKYjNbQ/mH9PLbLfMO/vz0NadJP8Sg5EQz6l4Rygh/yT
	LeEipTLCyl1mG60QYU9LA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EzVBvm4Eeto=:HRETReHTnJ8QFSk4hEn1qQ
	krBULTtSEsRA+SKfHiPAXB12Zs69NRs0bPjQGoTcievwJnntyFT3O24n7nfWasqk9oCcIPIbq
	8+ub1689HW7yvCboXuImPFTSlh2tCL0NLL7Bcoix/CBAyqNw3Fi9G6HeFavkYC+F1zWwgeru+
	J12wYgm9/hNAHPURyds0+ZcnPMuiXNsJUTjX38YiCC3jYWEwDu6xPDeBBEHoP9OcVGriBUDWx
	nOtpS/DXsQQd+AfDKT6V9MlZKf6oYAzTUGT9C6k2rM/ribM2s5yRUCIzrSxhHhcXMDrt8nIdG
	QffskYVm5eCdyxQAD9mhkvA6fi3d+AZdyUtGBFzT1+XJWRyKQMf1TF6sSqPK7AytRi+IRwx7Y
	3rb29jaADxJKPd4GvDST7YSFTPove1KdKtNJo3c8gfvPfQjpPQS79o/SQKKi4p9gInDRS3zkP
	84iLKTn4IoIztZmlEVRaBsoyGXi/JuB10WGEascz18nsRl0CJDr7p4IFPhIl7rqsKO5lVyGIT
	JcUAfPeH2Hp61ihPdVXkAc8a0tYdfKI9Zdq5LcLB+9Hvcf4bYyzbdLeOcsoHD0fE7hRnLW/g6
	MXQnltmz0Y0jzkKjcvyGJ91jeVoEMhXhIPAjHhltucQCT8il67h1/F7BIWNZaWbRmC2/fzPGA
	5clNyY5Oy0AMXYtToCeUcnEUfnDkQxd5TWThoKjDGXT+p+UaSGc+DU299OuWrcBhv7ClOU4Zu
	PEGu0P+KUJrEzvcWvrRXDjgnWaQ4ZOCrNDfRcA==
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
	iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
	Jesper Dangaard Brouer <brouer@redhat.com>, xen-devel@lists.xenproject.org,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On architectures that have a larger dma_addr_t than phys_addr_t,
the swiotlb_tbl_map_single() function truncates its return code
in the failure path, making it impossible to identify the error
later, as we compare to the original value:

kernel/dma/swiotlb.c:551:9: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to 'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
        return DMA_MAPPING_ERROR;

Use an explicit typecast here to convert it to the narrower type,
and use the same expression in the error handling later.

Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I still think that reverting the original commit would have
provided clearer semantics for this corner case, but at least
this patch restores the correct behavior.
---
 drivers/xen/swiotlb-xen.c | 2 +-
 kernel/dma/swiotlb.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index d53f3493a6b9..cfbe46785a3b 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -402,7 +402,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 
 	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
 				     attrs);
-	if (map == DMA_MAPPING_ERROR)
+	if (map == (phys_addr_t)DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
 	dev_addr = xen_phys_to_bus(map);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index e906ef2e6315..a3be651973ad 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -548,7 +548,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
 			 size, io_tlb_nslabs, tmp_io_tlb_used);
-	return DMA_MAPPING_ERROR;
+	return (phys_addr_t)DMA_MAPPING_ERROR;
 found:
 	io_tlb_used += nslots;
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
@@ -666,7 +666,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 	/* Oh well, have to allocate and map a bounce buffer. */
 	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
 			*phys, size, dir, attrs);
-	if (*phys == DMA_MAPPING_ERROR)
+	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
 		return false;
 
 	/* Ensure that the address returned is DMA'ble */
-- 
2.20.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
