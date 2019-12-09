Return-Path: <SRS0=4RPJ=Z7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC9C43603
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 19:34:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54B5220637
	for <iommu@archiver.kernel.org>; Mon,  9 Dec 2019 19:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B5220637
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1DA7F877EA;
	Mon,  9 Dec 2019 19:34:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HG2ornzaugcb; Mon,  9 Dec 2019 19:34:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 22653877F4;
	Mon,  9 Dec 2019 19:34:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CED3C1D7D;
	Mon,  9 Dec 2019 19:34:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ED39C0881
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 19:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3983520794
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 19:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K6FNUr-55Pm1 for <iommu@lists.linux-foundation.org>;
 Mon,  9 Dec 2019 19:34:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 43A4F2038B
 for <iommu@lists.linux-foundation.org>; Mon,  9 Dec 2019 19:34:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64E69328;
 Mon,  9 Dec 2019 11:34:02 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF67D3F6CF;
 Mon,  9 Dec 2019 11:34:01 -0800 (PST)
Subject: Re: [PATCH V2] iommu/iova: Init the struct iova to fix the possible
 memleak
To: Xiaotao Yin <xiaotao.yin@windriver.com>, joro@8bytes.org,
 iommu@lists.linux-foundation.org
References: <20191209082404.40166-1-xiaotao.yin@windriver.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <977971ed-f77f-847a-89ab-0ddf45abf24d@arm.com>
Date: Mon, 9 Dec 2019 19:33:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191209082404.40166-1-xiaotao.yin@windriver.com>
Content-Language: en-GB
Cc: linux-kernel@vger.kernel.org, Kexin.Hao@windriver.com
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 09/12/2019 8:24 am, Xiaotao Yin wrote:
> During ethernet(Marvell octeontx2) set ring buffer test:
> ethtool -G eth1 rx <rx ring size> tx <tx ring size>
> following kmemleak will happen sometimes:
> 
> unreferenced object 0xffff000b85421340 (size 64):
>    comm "ethtool", pid 867, jiffies 4295323539 (age 550.500s)
>    hex dump (first 64 bytes):
>      80 13 42 85 0b 00 ff ff ff ff ff ff ff ff ff ff  ..B.............
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      ff ff ff ff ff ff ff ff 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<000000001b204ddf>] kmem_cache_alloc+0x1b0/0x350
>      [<00000000d9ef2e50>] alloc_iova+0x3c/0x168
>      [<00000000ea30f99d>] alloc_iova_fast+0x7c/0x2d8
>      [<00000000b8bb2f1f>] iommu_dma_alloc_iova.isra.0+0x12c/0x138
>      [<000000002f1a43b5>] __iommu_dma_map+0x8c/0xf8
>      [<00000000ecde7899>] iommu_dma_map_page+0x98/0xf8
>      [<0000000082004e59>] otx2_alloc_rbuf+0xf4/0x158
>      [<000000002b107f6b>] otx2_rq_aura_pool_init+0x110/0x270
>      [<00000000c3d563c7>] otx2_open+0x15c/0x734
>      [<00000000a2f5f3a8>] otx2_dev_open+0x3c/0x68
>      [<00000000456a98b5>] otx2_set_ringparam+0x1ac/0x1d4
>      [<00000000f2fbb819>] dev_ethtool+0xb84/0x2028
>      [<0000000069b67c5a>] dev_ioctl+0x248/0x3a0
>      [<00000000af38663a>] sock_ioctl+0x280/0x638
>      [<000000002582384c>] do_vfs_ioctl+0x8b0/0xa80
>      [<000000004e1a2c02>] ksys_ioctl+0x84/0xb8
> 
> The reason:
> When alloc_iova_mem() without initial with Zero, sometimes fpn_lo will equal to
> IOVA_ANCHOR by chance, so when return from __alloc_and_insert_iova_range() with
> -ENOMEM(iova32_full), the new_iova will not be freed in free_iova_mem().

Ooh, subtle... nice catch!

I suppose we could also open-code the kmem_cache_free() call in 
alloc_iova() to bypass the check entirely because "we know what we're 
doing", but only if the zeroing proves to have a measurable overhead.

> Fixes: bb68b2fbfbd6 ("iommu/iova: Add rbtree anchor node")
> Signed-off-by: Xiaotao Yin <xiaotao.yin@windriver.com>
> ---
>   drivers/iommu/iova.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 41c605b0058f..2c27a661632c 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -233,7 +233,7 @@ static DEFINE_MUTEX(iova_cache_mutex);
>   
>   struct iova *alloc_iova_mem(void)
>   {
> -	return kmem_cache_alloc(iova_cache, GFP_ATOMIC);
> +	return kmem_cache_alloc(iova_cache, GFP_ATOMIC | __GFP_ZERO);

FWIW there is a kmem_cache_zalloc() helper, which seems fairly 
well-established. Either way, though,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   }
>   EXPORT_SYMBOL(alloc_iova_mem);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
