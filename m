Return-Path: <SRS0=PBOI=OA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF143C433F5
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 12:56:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81723611C0
	for <iommu@archiver.kernel.org>; Fri, 10 Sep 2021 12:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81723611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F0EC406A8;
	Fri, 10 Sep 2021 12:56:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y7DzS9QTyl86; Fri, 10 Sep 2021 12:56:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 03EA24069D;
	Fri, 10 Sep 2021 12:56:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5711C000F;
	Fri, 10 Sep 2021 12:56:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62BFCC000D
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 12:56:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5229C60EAA
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 12:56:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yyxRvOq3HbSg for <iommu@lists.linux-foundation.org>;
 Fri, 10 Sep 2021 12:56:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2010860EBC
 for <iommu@lists.linux-foundation.org>; Fri, 10 Sep 2021 12:56:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3058D6D;
 Fri, 10 Sep 2021 05:56:00 -0700 (PDT)
Received: from [10.57.15.112] (unknown [10.57.15.112])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57DC83F5A1;
 Fri, 10 Sep 2021 05:55:59 -0700 (PDT)
Subject: Re: [PATCH] dma-debug: prevent an error message from causing runtime
 problems
To: Hamza Mahfooz <someguy@effective-light.com>, linux-kernel@vger.kernel.org
References: <20210910120541.39938-1-someguy@effective-light.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <215cd3ba-3f4c-ab74-c59e-f099fa64aaac@arm.com>
Date: Fri, 10 Sep 2021 13:55:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210910120541.39938-1-someguy@effective-light.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
 Jeremy Linton <jeremy.linton@arm.com>
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

On 2021-09-10 13:05, Hamza Mahfooz wrote:
> For some drivers, that call add_dma_entry() from somewhere down the call
> stack.

Nit: strictly, drivers don't call add_dma_entry(). Drivers only call the 
DMA API functions, and it is the DMA API internals which take a detour 
through dma-debug when desired.

> If this error condition is triggered once, it causes the error
> message to spam the kernel's printk buffer

Is that true? It doesn't look like anything in dma-debug itself can 
obviously lead to that; I was assuming that in Jeremy's case it's the 
driver which has managed to do something such that every new mapping 
call it makes ends up hitting the warning. A busy network interface is 
probably more than capable of saturating the kernel log with a print for 
every packet (particularly a great big 100GBE-capable multi-queue thing 
like that one).

> and bring the CPU usage up to
> 100%. Also, since there is at least one driver that is in the mainline
> and suffers from the error condition, it is more useful to WARN_ON() here
> instead of just printing the error message (in hopes that it will make it
> easier for other drivers that suffer from this issue to be spotted).
> 
> Link: https://lkml.kernel.org/r/fd67fbac-64bf-f0ea-01e1-5938ccfab9d0@arm.com
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
> ---
>   kernel/dma/debug.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 6c90c69e5311..d9806689666e 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -567,7 +567,9 @@ static void add_dma_entry(struct dma_debug_entry *entry)
>   		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
>   		global_disable = true;
>   	} else if (rc == -EEXIST) {
> -		pr_err("cacheline tracking EEXIST, overlapping mappings aren't supported\n");
> +		WARN_ONCE(1,
> +			  pr_fmt("cacheline tracking EEXIST, overlapping mappings aren't supported\n"
> +			 ));

Unless there's some subtlety I'm missing, it would be better to use 
err_printk() here - not only for consistency of output, but also to tie 
in with dma-debug's existing output-limiting controls.

Robin.

>   	}
>   }
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
