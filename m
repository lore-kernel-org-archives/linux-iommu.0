Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FE0C41514
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588CF22BF5
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 13:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLhHdUp7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588CF22BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 282E5C84;
	Fri, 26 Jul 2019 13:40:10 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D3418C7A
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 13:40:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7BA2389C
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 13:40:09 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
	[73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 8A19122CBF;
	Fri, 26 Jul 2019 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148409;
	bh=tm7Y0GezpikEYvCrzvAS38HkjuB5/K0CmseOd6YnkoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kLhHdUp7e30CpRtubBfT+2W//1zpenTCCn+xphNeETZ/dwPZWO2m7aNeFgZ6yCaAy
	CMo6B3a4boVTGqMQgmJ6jqRTv48/Cub3OUMDruGi7CnsWaLd4y03LOG1UV/yIM/LRw
	IKNbkadJVHvEZxFzmbLiyPRf3I7m9S9d1wd0G01A=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 18/85] swiotlb: fix phys_addr_t overflow warning
Date: Fri, 26 Jul 2019 09:38:28 -0400
Message-Id: <20190726133936.11177-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
	Stefano Stabellini <sstabellini@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9c106119f6538f65bdddb7948a157d90625effa7 ]

On architectures that have a larger dma_addr_t than phys_addr_t,
the swiotlb_tbl_map_single() function truncates its return code
in the failure path, making it impossible to identify the error
later, as we compare to the original value:

kernel/dma/swiotlb.c:551:9: error: implicit conversion from 'dma_addr_t' (aka 'unsigned long long') to 'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Werror,-Wconstant-conversion]
        return DMA_MAPPING_ERROR;

Use an explicit typecast here to convert it to the narrower type,
and use the same expression in the error handling later.

Fixes: b907e20508d0 ("swiotlb: remove SWIOTLB_MAP_ERROR")
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 13f0cb080a4d..5f4e1b78babb 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -546,7 +546,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
 			 size, io_tlb_nslabs, tmp_io_tlb_used);
-	return DMA_MAPPING_ERROR;
+	return (phys_addr_t)DMA_MAPPING_ERROR;
 found:
 	io_tlb_used += nslots;
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
@@ -664,7 +664,7 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 	/* Oh well, have to allocate and map a bounce buffer. */
 	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
 			*phys, size, dir, attrs);
-	if (*phys == DMA_MAPPING_ERROR)
+	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
 		return false;
 
 	/* Ensure that the address returned is DMA'ble */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
