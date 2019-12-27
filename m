Return-Path: <SRS0=vA4F=2R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862FAC47409
	for <iommu@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3D522522
	for <iommu@archiver.kernel.org>; Fri, 27 Dec 2019 17:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYosT19X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3D522522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1A73085BE4;
	Fri, 27 Dec 2019 17:45:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jqqxELr0wYNc; Fri, 27 Dec 2019 17:45:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6B5BC82DDF;
	Fri, 27 Dec 2019 17:45:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54162C1AE8;
	Fri, 27 Dec 2019 17:45:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71C6DC0881
 for <iommu@lists.linux-foundation.org>; Fri, 27 Dec 2019 17:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6B6338589A
 for <iommu@lists.linux-foundation.org>; Fri, 27 Dec 2019 17:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9OYKTdCHdvS2 for <iommu@lists.linux-foundation.org>;
 Fri, 27 Dec 2019 17:45:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CA6E08389C
 for <iommu@lists.linux-foundation.org>; Fri, 27 Dec 2019 17:45:06 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DFE7F24679;
 Fri, 27 Dec 2019 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1577468706;
 bh=Y+XNfaE3LXyuKB4B73gODgRnofkdHBQCljhdKRzPBCI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lYosT19X2pFiFzSIGllXrhrV/YorBKe/X3NWx3tNSnZxWYW3q4XvEdGmmoRn6KhgQ
 IKfjFP+5SQ1PYz4NCfECL0t4Q/GvuTyoH6VKREMbKvFeqaW/Y14YpHK2fkJROlPQZW
 taiSUNnDwIoYa4fq/vXz7pwWNgttT2AXa2i+7qh0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 62/84] iommu/iova: Init the struct iova to fix
 the possible memleak
Date: Fri, 27 Dec 2019 12:43:30 -0500
Message-Id: <20191227174352.6264-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Xiaotao Yin <xiaotao.yin@windriver.com>,
 iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>,
 Robin Murphy <robin.murphy@arm.com>
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

From: Xiaotao Yin <xiaotao.yin@windriver.com>

[ Upstream commit 472d26df5e8075eda677b6be730e0fbf434ff2a8 ]

During ethernet(Marvell octeontx2) set ring buffer test:
ethtool -G eth1 rx <rx ring size> tx <tx ring size>
following kmemleak will happen sometimes:

unreferenced object 0xffff000b85421340 (size 64):
  comm "ethtool", pid 867, jiffies 4295323539 (age 550.500s)
  hex dump (first 64 bytes):
    80 13 42 85 0b 00 ff ff ff ff ff ff ff ff ff ff  ..B.............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001b204ddf>] kmem_cache_alloc+0x1b0/0x350
    [<00000000d9ef2e50>] alloc_iova+0x3c/0x168
    [<00000000ea30f99d>] alloc_iova_fast+0x7c/0x2d8
    [<00000000b8bb2f1f>] iommu_dma_alloc_iova.isra.0+0x12c/0x138
    [<000000002f1a43b5>] __iommu_dma_map+0x8c/0xf8
    [<00000000ecde7899>] iommu_dma_map_page+0x98/0xf8
    [<0000000082004e59>] otx2_alloc_rbuf+0xf4/0x158
    [<000000002b107f6b>] otx2_rq_aura_pool_init+0x110/0x270
    [<00000000c3d563c7>] otx2_open+0x15c/0x734
    [<00000000a2f5f3a8>] otx2_dev_open+0x3c/0x68
    [<00000000456a98b5>] otx2_set_ringparam+0x1ac/0x1d4
    [<00000000f2fbb819>] dev_ethtool+0xb84/0x2028
    [<0000000069b67c5a>] dev_ioctl+0x248/0x3a0
    [<00000000af38663a>] sock_ioctl+0x280/0x638
    [<000000002582384c>] do_vfs_ioctl+0x8b0/0xa80
    [<000000004e1a2c02>] ksys_ioctl+0x84/0xb8

The reason:
When alloc_iova_mem() without initial with Zero, sometimes fpn_lo will
equal to IOVA_ANCHOR by chance, so when return with -ENOMEM(iova32_full)
from __alloc_and_insert_iova_range(), the new_iova will not be freed in
free_iova_mem().

Fixes: bb68b2fbfbd6 ("iommu/iova: Add rbtree anchor node")
Signed-off-by: Xiaotao Yin <xiaotao.yin@windriver.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index da4516fbf542..34c058c24b9d 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -236,7 +236,7 @@ static DEFINE_MUTEX(iova_cache_mutex);
 
 struct iova *alloc_iova_mem(void)
 {
-	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
+	return kmem_cache_zalloc(iova_cache, GFP_ATOMIC);
 }
 EXPORT_SYMBOL(alloc_iova_mem);
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
