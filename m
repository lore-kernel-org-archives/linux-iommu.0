Return-Path: <SRS0=QAIZ=3T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8322C2D0DB
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 23:46:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84ADA20661
	for <iommu@archiver.kernel.org>; Thu, 30 Jan 2020 23:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84ADA20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 54E0E8660A;
	Thu, 30 Jan 2020 23:46:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MJUZylMgdQVT; Thu, 30 Jan 2020 23:46:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C765F861C1;
	Thu, 30 Jan 2020 23:46:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BA459C1796;
	Thu, 30 Jan 2020 23:46:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32B6CC0171
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 23:46:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 20CC68735E
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 23:46:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1v7SVaNqNBkg for <iommu@lists.linux-foundation.org>;
 Thu, 30 Jan 2020 23:46:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id D93EE8733E
 for <iommu@lists.linux-foundation.org>; Thu, 30 Jan 2020 23:46:53 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 280A11FB;
 Thu, 30 Jan 2020 15:46:53 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 794433F67D;
 Thu, 30 Jan 2020 15:46:51 -0800 (PST)
Subject: Re: [PATCH] dma-debug: dynamic allocation of hash table
To: Eric Dumazet <edumazet@google.com>, Christoph Hellwig <hch@lst.de>,
 Joerg Roedel <jroedel@suse.de>
References: <20200130191049.190569-1-edumazet@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
Date: Thu, 30 Jan 2020 23:46:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200130191049.190569-1-edumazet@google.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Eric Dumazet <eric.dumazet@gmail.com>
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

Hi Eric,

On 2020-01-30 7:10 pm, Eric Dumazet via iommu wrote:
> Increasing the size of dma_entry_hash size by 327680 bytes
> has reached some bootloaders limitations.

[ That might warrant some further explanation - I don't quite follow how 
this would relate to a bootloader specifically :/ ]

> Simply use dynamic allocations instead, and take
> this opportunity to increase the hash table to 65536
> buckets. Finally my 40Gbit mlx4 NIC can sustain
> line rate with CONFIG_DMA_API_DEBUG=y.

That's pretty cool, but I can't help but wonder if making the table 
bigger caused a problem in the first place, whether making it bigger yet 
again in the name of a fix is really the wisest move. How might this 
impact DMA debugging on 32-bit embedded systems with limited vmalloc 
space and even less RAM, for instance? More to the point, does vmalloc() 
even work for !CONFIG_MMU builds? Obviously we don't want things to be 
*needlessly* slow if avoidable, but is there a genuine justification for 
needing to optimise what is fundamentally an invasive heavyweight 
correctness check - e.g. has it helped expose race conditions that were 
otherwise masked?

That said, by moving to dynamic allocation maybe there's room to be 
cleverer and make HASH_SIZE scale with, say, system memory size? (I 
assume from the context it's not something we can expand on-demand like 
we did for the dma_debug_entry pool)

Robin.

> Fixes: 5e76f564572b ("dma-debug: increase HASH_SIZE")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>   kernel/dma/debug.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 2031ed1ad7fa109bb8a8c290bbbc5f825362baba..a310dbb1515e92c081f8f3f9a7290dd5e53fc889 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -27,7 +27,7 @@
>   
>   #include <asm/sections.h>
>   
> -#define HASH_SIZE       16384ULL
> +#define HASH_SIZE       65536ULL
>   #define HASH_FN_SHIFT   13
>   #define HASH_FN_MASK    (HASH_SIZE - 1)
>   
> @@ -90,7 +90,8 @@ struct hash_bucket {
>   };
>   
>   /* Hash list to save the allocated dma addresses */
> -static struct hash_bucket dma_entry_hash[HASH_SIZE];
> +static struct hash_bucket *dma_entry_hash __read_mostly;
> +
>   /* List of pre-allocated dma_debug_entry's */
>   static LIST_HEAD(free_entries);
>   /* Lock for the list above */
> @@ -934,6 +935,10 @@ static int dma_debug_init(void)
>   	if (global_disable)
>   		return 0;
>   
> +	dma_entry_hash = vmalloc(HASH_SIZE * sizeof(*dma_entry_hash));
> +	if (!dma_entry_hash)
> +		goto err;
> +
>   	for (i = 0; i < HASH_SIZE; ++i) {
>   		INIT_LIST_HEAD(&dma_entry_hash[i].list);
>   		spin_lock_init(&dma_entry_hash[i].lock);
> @@ -950,6 +955,7 @@ static int dma_debug_init(void)
>   		pr_warn("%d debug entries requested but only %d allocated\n",
>   			nr_prealloc_entries, nr_total_entries);
>   	} else {
> +err:
>   		pr_err("debugging out of memory error - disabled\n");
>   		global_disable = true;
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
