Return-Path: <SRS0=8SnF=MO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5D3C63799
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 10:10:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B57661249
	for <iommu@archiver.kernel.org>; Thu, 22 Jul 2021 10:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B57661249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3283A8290B;
	Thu, 22 Jul 2021 10:10:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hx_lS452Uby9; Thu, 22 Jul 2021 10:10:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0533B828F8;
	Thu, 22 Jul 2021 10:10:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAB68C001A;
	Thu, 22 Jul 2021 10:10:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC1C8C000E
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 10:10:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D3A678290B
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 10:10:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WtfT3WiUjfMR for <iommu@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 10:10:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 834D7828F8
 for <iommu@lists.linux-foundation.org>; Thu, 22 Jul 2021 10:10:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56BBC106F;
 Thu, 22 Jul 2021 03:10:31 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DF3C3F73D;
 Thu, 22 Jul 2021 03:10:30 -0700 (PDT)
Subject: Re: [PATCH] dma-debug: fix debugfs initialization order
To: Anthony Iliopoulos <ailiop@suse.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210722091818.13434-1-ailiop@suse.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1ea36b32-9bbc-a611-402d-9fa196eda166@arm.com>
Date: Thu, 22 Jul 2021 11:10:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722091818.13434-1-ailiop@suse.com>
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

On 2021-07-22 10:18, Anthony Iliopoulos wrote:
> Due to link order, dma_debug_init is called before debugfs has a chance
> to initialize (via debugfs_init which also happens in the core initcall
> stage), so the directories for dma-debug are never created.
> 
> Move the dma_debug_init initcall from core to postcore stage so that
> debugfs will already be initialized by the time this is called, making
> it oblivious to link-ordering.

Playing initcall chicken here doesn't work so well - the later you 
initialise dma-debug itself, the more chance it has to miss early 
mappings and raise false positives later. As discussed previously[1] the 
better solution would be to decouple the debugfs setup so that just that 
part can be deferred until core_initcall_sync or later.

Robin.

[1] https://lore.kernel.org/linux-iommu/YIgGa6yF%2Fadg8OSN@kroah.com/

> Fixes: 15b28bbcd567 ("dma-debug: move initialization to common code")
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>   kernel/dma/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 14de1271463f..49d80ef7f995 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -915,7 +915,7 @@ static int dma_debug_init(void)
>   	pr_info("debugging enabled by kernel config\n");
>   	return 0;
>   }
> -core_initcall(dma_debug_init);
> +postcore_initcall(dma_debug_init);
>   
>   static __init int dma_debug_cmdline(char *str)
>   {
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
