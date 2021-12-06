Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFE1C43219
	for <iommu@archiver.kernel.org>; Mon,  6 Dec 2021 15:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 165B381AAD;
	Mon,  6 Dec 2021 15:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UeKJ9mtPMThL; Mon,  6 Dec 2021 15:01:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16E2781D3D;
	Mon,  6 Dec 2021 15:01:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9085C001E;
	Mon,  6 Dec 2021 15:00:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 523F6C0012
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:00:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3274F40289
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:00:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ip9tNMWvXaiv for <iommu@lists.linux-foundation.org>;
 Mon,  6 Dec 2021 15:00:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58F9D400C9
 for <iommu@lists.linux-foundation.org>; Mon,  6 Dec 2021 15:00:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C093CED1;
 Mon,  6 Dec 2021 07:00:56 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6B0D3F5A1;
 Mon,  6 Dec 2021 07:00:54 -0800 (PST)
Message-ID: <ddcdde8c-5118-048e-d5f8-6b8bc860947d@arm.com>
Date: Mon, 6 Dec 2021 15:00:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [RFC PATCH] provide per numa cma with an initial default size
Content-Language: en-GB
To: Jay Chen <jkchen@linux.alibaba.com>, hch@lst.de,
 m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
References: <20211130074556.11091-1-jkchen@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211130074556.11091-1-jkchen@linux.alibaba.com>
Cc: zhangliguang@linux.alibaba.com
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

[ +Barry ]

On 2021-11-30 07:45, Jay Chen wrote:
>    In the actual production environment, when we open
> cma and per numa cma, if we do not increase the per
> numa size configuration in cmdline, we find that our
> performance has dropped by 20%.
>    Through analysis, we found that the default size of
> per numa is 0, which causes the driver to allocate
> memory from cma, which affects performance. Therefore,
> we think we need to provide a default size.

Looking back at some of the review discussions, I think it may have been 
intentional that per-node areas are not allocated by default, since it's 
the kind of thing that really wants to be tuned to the particular system 
and workload, and as such it seemed reasonable to expect users to 
provide a value on the command line if they wanted the feature. That's 
certainly what the Kconfig text implies.

Thanks,
Robin.

> Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> ---
>   kernel/dma/contiguous.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index 3d63d91cba5c..3bef8bf371d9 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -99,7 +99,7 @@ early_param("cma", early_cma);
>   #ifdef CONFIG_DMA_PERNUMA_CMA
>   
>   static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> -static phys_addr_t pernuma_size_bytes __initdata;
> +static phys_addr_t pernuma_size_bytes __initdata = size_bytes;
>   
>   static int __init early_cma_pernuma(char *p)
>   {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
