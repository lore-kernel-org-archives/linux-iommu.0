Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040E4C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Dec 2021 10:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 775ED8242D;
	Wed, 22 Dec 2021 10:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wD7jy851xtSX; Wed, 22 Dec 2021 10:55:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5F5FB823DD;
	Wed, 22 Dec 2021 10:55:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40D2DC002F;
	Wed, 22 Dec 2021 10:55:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B35AFC0012
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 10:55:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8ACFD40189
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 10:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-zLwoTJaJnH for <iommu@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 10:55:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46F2640153
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 10:55:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67D481FB;
 Wed, 22 Dec 2021 02:55:32 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FAF13F5A1;
 Wed, 22 Dec 2021 02:55:31 -0800 (PST)
Message-ID: <bd8f7c86-983a-58fa-460c-7e361df66cec@arm.com>
Date: Wed, 22 Dec 2021 10:55:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] Swiotlb: remove a duplicate include
Content-Language: en-GB
To: Guo Zhengkui <guozhengkui@vivo.com>, Christoph Hellwig
 <hch@infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 "open list:SWIOTLB SUBSYSTEM" <iommu@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20211222025416.3505-1-guozhengkui@vivo.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20211222025416.3505-1-guozhengkui@vivo.com>
Cc: kernel@vivo.com
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

On 2021-12-22 02:54, Guo Zhengkui wrote:
> Remove a duplicate "#include <linux/io.h>". The deleted one in line 43
> is under "#ifdef CONFIG_DMA_RESTRICTED_POOL". However, there is already
> one in line 53 with no conditional compile.
> 
> Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
> ---
>   kernel/dma/swiotlb.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1b0501fd3e0e..8c091626ca35 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -33,21 +33,20 @@
>   #include <linux/ctype.h>
>   #include <linux/highmem.h>
>   #include <linux/gfp.h>
>   #include <linux/scatterlist.h>
>   #include <linux/cc_platform.h>
>   #include <linux/set_memory.h>
>   #ifdef CONFIG_DEBUG_FS
>   #include <linux/debugfs.h>
>   #endif
>   #ifdef CONFIG_DMA_RESTRICTED_POOL
> -#include <linux/io.h>
>   #include <linux/of.h>
>   #include <linux/of_fdt.h>
>   #include <linux/of_reserved_mem.h>
>   #include <linux/slab.h>
>   #endif
>   
>   #include <asm/io.h>

By the same token we don't need this one either - as a general rule, 
linux/* headers can be assumed to include their asm/* equivalent, and 
that is certainly true for io.h.

>   #include <asm/dma.h>
>   
>   #include <linux/io.h>

TBH, now that I'm looking, the whole lot is a mess and I'm sure there's 
more legacy cruft that doesn't need to be here. If I remember, I might 
have a crack at a cleanup once rc1 is out.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
