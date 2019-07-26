Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDB2C76191
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 13:42:09 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187FD22CC2
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 13:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="13drCaaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187FD22CC2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E2C66CB7;
	Fri, 26 Jul 2019 13:42:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2AF0BAD7
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 13:42:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D2EBE89C
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 13:42:07 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
	[73.47.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id F109822CBF;
	Fri, 26 Jul 2019 13:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564148527;
	bh=63hZ9egKx37hVIVrHIR+iW3hIjhT86QqwlTUfbow8ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=13drCaaYs1fy5Q4V6I3OCj9rdrrttgeYO9n6Owl7/KqxJ/icOXa6WZ8Enwn3rrHKV
	RJEhosfZ1DSVPVKh7alUMar8RTqijvfhq175z/bpQB97fvvvgDjKOTKnnIhqA3+9y0
	0JGWouMllXHX5Svv7NCkxdVACi3DCEMZCBb4PA8U=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 84/85] dma-direct: correct the physical addr in
	dma_direct_sync_sg_for_cpu/device
Date: Fri, 26 Jul 2019 09:39:34 -0400
Message-Id: <20190726133936.11177-84-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, Fugang Duan <fugang.duan@nxp.com>,
	Christoph Hellwig <hch@lst.de>
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

From: Fugang Duan <fugang.duan@nxp.com>

[ Upstream commit 449fa54d6815be8c2c1f68fa9dbbae9384a7c03e ]

dma_map_sg() may use swiotlb buffer when the kernel command line includes
"swiotlb=force" or the dma_addr is out of dev->dma_mask range.  After
DMA complete the memory moving from device to memory, then user call
dma_sync_sg_for_cpu() to sync with DMA buffer, and copy the original
virtual buffer to other space.

So dma_direct_sync_sg_for_cpu() should use swiotlb physical addr, not
the original physical addr from sg_phys(sg).

dma_direct_sync_sg_for_device() also has the same issue, correct it as
well.

Fixes: 55897af63091("dma-direct: merge swiotlb_dma_ops into the dma_direct code")
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 2c2772e9702a..2c6d51a62251 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -231,12 +231,14 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		if (unlikely(is_swiotlb_buffer(sg_phys(sg))))
-			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
+		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
+
+		if (unlikely(is_swiotlb_buffer(paddr)))
+			swiotlb_tbl_sync_single(dev, paddr, sg->length,
 					dir, SYNC_FOR_DEVICE);
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_device(dev, sg_phys(sg), sg->length,
+			arch_sync_dma_for_device(dev, paddr, sg->length,
 					dir);
 	}
 }
@@ -268,11 +270,13 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
+		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
+
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
-	
-		if (unlikely(is_swiotlb_buffer(sg_phys(sg))))
-			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length, dir,
+			arch_sync_dma_for_cpu(dev, paddr, sg->length, dir);
+
+		if (unlikely(is_swiotlb_buffer(paddr)))
+			swiotlb_tbl_sync_single(dev, paddr, sg->length, dir,
 					SYNC_FOR_CPU);
 	}
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
