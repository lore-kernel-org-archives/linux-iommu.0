Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D99C2D0C0
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 08:46:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBECF2073D
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 08:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBECF2073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 567F486519;
	Mon,  9 Dec 2019 08:46:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OjrgQP724DCw; Mon,  9 Dec 2019 08:46:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2DBD08651C;
	Mon,  9 Dec 2019 08:46:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09818C1D84;
	Mon,  9 Dec 2019 08:46:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34FBCC1D7D
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 08:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1AC4D864C3
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 08:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3MhFJu4pzECD for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 08:00:03 +0000 (UTC)
X-Greylist: delayed 00:16:36 by SQLgrey-1.7.6
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E2B49864AD
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 08:00:02 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id xB97hJIj019132
 (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
 Sun, 8 Dec 2019 23:43:20 -0800
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.163]) by
 ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0468.000; Sun, 8
 Dec 2019 23:43:19 -0800
From: "Yin, Xiaotao" <Xiaotao.Yin@windriver.com>
To: "Yin, Xiaotao" <Xiaotao.Yin@windriver.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH] iommu/iova: kmemleak when pfn_lo equals IOVA_ANCHOR
Thread-Topic: [PATCH] iommu/iova: kmemleak when pfn_lo equals IOVA_ANCHOR
Thread-Index: AQHVrmCJeJQaOQWxzUyaXwOpMaGc4aexakGw
Date: Mon, 9 Dec 2019 07:43:18 +0000
Message-ID: <47B7036B26F82C43B9F7EAE984D54CB459DB3C@ALA-MBD.corp.ad.wrs.com>
References: <20191209071609.35690-1-xiaotao.yin@windriver.com>
In-Reply-To: <20191209071609.35690-1-xiaotao.yin@windriver.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.162.224]
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Dec 2019 08:46:49 +0000
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Hao,
 Kexin" <Kexin.Hao@windriver.com>
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

Please ignore this one, I'll send v2.

Br.

-----Original Message-----
From: Xiaotao Yin <xiaotao.yin@windriver.com> 
Sent: Monday, December 9, 2019 3:16 PM
To: joro@8bytes.org; iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org; Hao, Kexin <Kexin.Hao@windriver.com>; Yin, Xiaotao <Xiaotao.Yin@windriver.com>
Subject: [PATCH] iommu/iova: kmemleak when pfn_lo equals IOVA_ANCHOR

During ethernet(Marvell octeontx2) set ring buffer test:
ethtool -G eth1 rx <rx ring size> tx <tx ring size> following kmemleak will happen sometimes:

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
When alloc_iova_mem() without initial with Zero, sometimes fpn_lo will equal to IOVA_ANCHOR by chance, so when return from __alloc_and_insert_iova_range() with -ENOMEM(iova32_full), the new_iova will not be freed in free_iova_mem().

Fixes: bb68b2fbfbd6 ("iommu/iova: Add rbtree anchor node")
Signed-off-by: Xiaotao Yin <xiaotao.yin@windriver.com>
---
 drivers/iommu/iova.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c index 41c605b0058f..2c27a661632c 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -233,7 +233,7 @@ static DEFINE_MUTEX(iova_cache_mutex);
 
 struct iova *alloc_iova_mem(void)
 {
-	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
+	return kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_ZERO);
 }
 EXPORT_SYMBOL(alloc_iova_mem);
 
--
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
