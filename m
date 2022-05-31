Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8290DC433EF
	for <iommu@archiver.kernel.org>; Tue, 31 May 2022 22:00:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3351541856;
	Tue, 31 May 2022 22:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cpxogBLSxK8E; Tue, 31 May 2022 22:00:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D9A944184E;
	Tue, 31 May 2022 22:00:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A93B9C0032;
	Tue, 31 May 2022 22:00:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E18C1C002D
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 22:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D621660B8A
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 22:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RnDgzSax2nQB for <iommu@lists.linux-foundation.org>;
 Tue, 31 May 2022 22:00:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D82460B74
 for <iommu@lists.linux-foundation.org>; Tue, 31 May 2022 22:00:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 773DC23A;
 Tue, 31 May 2022 15:00:25 -0700 (PDT)
Received: from [10.57.81.38] (unknown [10.57.81.38])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 640F93F66F;
 Tue, 31 May 2022 15:00:24 -0700 (PDT)
Message-ID: <39d1fa65-8e82-721c-171e-ef36bda1c561@arm.com>
Date: Tue, 31 May 2022 23:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dma-debug: Make things less spammy under memory pressure
Content-Language: en-GB
To: Rob Clark <robdclark@gmail.com>, linux-kernel@vger.kernel.org
References: <20220531215106.192271-1-robdclark@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220531215106.192271-1-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
 Christoph Hellwig <hch@lst.de>
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

On 2022-05-31 22:51, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Ratelimit the error msg to avoid flooding the console.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   kernel/dma/debug.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index f8ff598596b8..683966f0247b 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -564,7 +564,7 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
>   
>   	rc = active_cacheline_insert(entry);
>   	if (rc == -ENOMEM) {
> -		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
> +		pr_err_ratelimited("cacheline tracking ENOMEM, dma-debug disabled\n");
>   		global_disable = true;

Given that it's supposed to disable itself entirely if it ever gets 
here, just how spammy is it exactly?

Thanks,
Robin.

>   	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
>   		err_printk(entry->dev, entry,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
