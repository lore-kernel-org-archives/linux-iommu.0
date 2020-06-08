Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B6DC433DF
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 12:04:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C432072F
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 12:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C432072F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 98E1E21556;
	Mon,  8 Jun 2020 12:04:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H2PfBgNv8aoN; Mon,  8 Jun 2020 12:04:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2E13821537;
	Mon,  8 Jun 2020 12:04:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAB8EC0863;
	Mon,  8 Jun 2020 12:04:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DB80C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 12:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 14D7386576
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 12:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dERD9QWM64Zp for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 12:04:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3456A86382
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 12:04:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9697B1FB;
 Mon,  8 Jun 2020 05:04:00 -0700 (PDT)
Received: from [10.57.9.113] (unknown [10.57.9.113])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84C973F52E;
 Mon,  8 Jun 2020 05:03:59 -0700 (PDT)
Subject: Re: [PATCH] dma-pool: Fix too large DMA pools on medium systems
To: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 David Rientjes <rientjes@google.com>
References: <20200608085231.8924-1-geert@linux-m68k.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <92b53a24-2f1f-2add-6bea-eeda7317520f@arm.com>
Date: Mon, 8 Jun 2020 13:03:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608085231.8924-1-geert@linux-m68k.org>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 2020-06-08 09:52, Geert Uytterhoeven wrote:
> On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
> memory pools are much larger than intended (e.g. 2 MiB instead of 128
> KiB on a 256 MiB system).
> 
> Fix this by correcting the calculation of the number of GiBs of RAM in
> the system.
> 
> Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>   kernel/dma/pool.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 35bb51c31fff370f..1c7eab2cc0498003 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -175,8 +175,8 @@ static int __init dma_atomic_pool_init(void)
>   	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
>   	 */
>   	if (!atomic_pool_size) {
> -		atomic_pool_size = max(totalram_pages() >> PAGE_SHIFT, 1UL) *
> -					SZ_128K;
> +		unsigned long gigs = totalram_pages() >> (30 - PAGE_SHIFT);
> +		atomic_pool_size = max(gigs, 1UL) * SZ_128K;
>   		atomic_pool_size = min_t(size_t, atomic_pool_size,
>   					 1 << (PAGE_SHIFT + MAX_ORDER-1));
>   	}

Nit: although this probably is right, it seems even less readable than 
the broken version (where at least some at-a-glance 'dimensional 
analysis' flags up "(number of pages) >> PAGE_SHIFT" as rather 
suspicious). How about a something a little more self-explanatory, e.g.:

	unsigned long pages = totalram_pages() * SZ_128K / SZ_1GB;
	atomic_pool_size = min(pages, MAX_ORDER_NR_PAGES) << PAGE_SHIFT;
	atomic_pool_size = max_t(size_t, atomic_pool_size, SZ_128K);

?

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
