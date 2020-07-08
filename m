Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77957C433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 23:14:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0FF20708
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 23:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0FF20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E6F6F872BB;
	Wed,  8 Jul 2020 23:14:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hEThAwlE4stq; Wed,  8 Jul 2020 23:14:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 58E9187236;
	Wed,  8 Jul 2020 23:14:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B22DC0893;
	Wed,  8 Jul 2020 23:14:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D08BAC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 23:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BF0DC872BB
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 23:14:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id poSI1MYcBDKW for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 23:14:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EBB0887236
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 23:14:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 328EE31B;
 Wed,  8 Jul 2020 16:14:51 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6F4B3F9AB;
 Wed,  8 Jul 2020 16:14:50 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, David Rientjes <rientjes@google.com>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <a32e1017-4724-7cd8-0ba9-daddfaad1f44@arm.com>
Date: Wed, 8 Jul 2020 18:14:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708164936.9340-1-nsaenzjulienne@suse.de>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-rpi-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
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

Hi,

On 7/8/20 11:49 AM, Nicolas Saenz Julienne wrote:
> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. So stop using it.
> 
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

With this patch and 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2226971.html 
the machine appears to be working fine with/without CMA and in both 
DT/ACPI mode.

The JBOD/etc I was having problems with are working fine, and the rtlsdr 
seems to be working better now too (its still not perfect, but that is 
likely another issue).

so:

tested-by: Jeremy Linton <jeremy.linton@arm.com>

thanks!


> 
> An more costly alternative would be adding an option to
> dma_alloc_from_contiguous() so it fails when the allocation doesn't fall
> in a specific zone.
> 
>   kernel/dma/pool.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 8cfa01243ed2..4bc1c46ae6ef 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -6,7 +6,6 @@
>   #include <linux/debugfs.h>
>   #include <linux/dma-direct.h>
>   #include <linux/dma-noncoherent.h>
> -#include <linux/dma-contiguous.h>
>   #include <linux/init.h>
>   #include <linux/genalloc.h>
>   #include <linux/set_memory.h>
> @@ -69,12 +68,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   
>   	do {
>   		pool_size = 1 << (PAGE_SHIFT + order);
> -
> -		if (dev_get_cma_area(NULL))
> -			page = dma_alloc_from_contiguous(NULL, 1 << order,
> -							 order, false);
> -		else
> -			page = alloc_pages(gfp, order);
> +		page = alloc_pages(gfp, order);
>   	} while (!page && order-- > 0);
>   	if (!page)
>   		goto out;
> @@ -118,8 +112,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   	dma_common_free_remap(addr, pool_size);
>   #endif
>   free_page: __maybe_unused
> -	if (!dma_release_from_contiguous(NULL, page, 1 << order))
> -		__free_pages(page, order);
> +	__free_pages(page, order);
>   out:
>   	return ret;
>   }
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
