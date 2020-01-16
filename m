Return-Path: <SRS0=QvS0=3F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F05C33CB1
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C76062176D
	for <iommu@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dH995/4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76062176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A675D838D9;
	Thu, 16 Jan 2020 16:53:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E+yz1qzlIqx7; Thu, 16 Jan 2020 16:53:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CF22B8682C;
	Thu, 16 Jan 2020 16:53:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4384C1D81;
	Thu, 16 Jan 2020 16:53:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 821A6C077D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 16:53:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7043987EA0
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 16:53:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZISP0ZqmVGj4 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jan 2020 16:53:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 61D0987A8E
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jan 2020 16:53:47 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 748DC2176D;
 Thu, 16 Jan 2020 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579193627;
 bh=pYUCGLdMi6gDXVvxrUjAARZ0xY91qBFUik0lqrR9TTg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dH995/4+8IWYVT/rxPyF/t4Uq6El59Hwf6S1KRacmZ+7o4GnUlKSnprMUlCjb2O7M
 HX18UkBq84wm0E/NvNxp7MWDEHC/g+7yO6ie8pRLgCbBVL9GjEGa6CKMXzo3g/SgaY
 KsXfSGOQstg4TSEaGCpz1B9Ph7PjyGLNKiSCE4c0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 161/205] dma-direct: don't check swiotlb=force in
 dma_direct_map_resource
Date: Thu, 16 Jan 2020 11:42:16 -0500
Message-Id: <20200116164300.6705-161-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 4268ac6ae5870af10a7417b22990d615f72f77e2 ]

When mapping resources we can't just use swiotlb ram for bounce
buffering.  Switch to a direct dma_capable check instead.

Fixes: cfced786969c ("dma-mapping: remove the default map_resource implementation")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8402b29c280f..867fd72cb260 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -375,7 +375,7 @@ dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 {
 	dma_addr_t dma_addr = paddr;
 
-	if (unlikely(!dma_direct_possible(dev, dma_addr, size))) {
+	if (unlikely(!dma_capable(dev, dma_addr, size))) {
 		report_addr(dev, dma_addr, size);
 		return DMA_MAPPING_ERROR;
 	}
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
