Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191FFC433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 15:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A041781750;
	Mon,  7 Feb 2022 15:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dpdBdhFF_zqP; Mon,  7 Feb 2022 15:55:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 687448174A;
	Mon,  7 Feb 2022 15:55:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4942BC001A;
	Mon,  7 Feb 2022 15:55:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2374C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 15:55:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C05860AFA
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 15:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JQL_wCfvFVET for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 15:55:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id CC87F606E7
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 15:55:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA37A11D4;
 Mon,  7 Feb 2022 07:55:37 -0800 (PST)
Received: from [10.57.70.156] (unknown [10.57.70.156])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FA303F718;
 Mon,  7 Feb 2022 07:55:36 -0800 (PST)
Message-ID: <58e77093-51e2-59a2-e413-164d83ecd9b8@arm.com>
Date: Mon, 7 Feb 2022 15:55:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 1/1] iommu/dma: Use DMA ops setter instead of direct
 assignment
Content-Language: en-GB
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20220207141321.8293-1-andriy.shevchenko@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220207141321.8293-1-andriy.shevchenko@linux.intel.com>
Cc: Will Deacon <will@kernel.org>
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

On 2022-02-07 14:13, Andy Shevchenko wrote:
> Use DMA ops setter instead of direct assignment. Even we know that
> this module doesn't perform access to the dma_ops member of struct device,
> it's better to use setter to avoid potential problems in the future.

What potential problems are you imagining? This whole file is a DMA ops 
implementation, not driver code (and definitely not a module); if anyone 
removes the "select DMA_OPS" from CONFIG_IOMMU_DMA they deserve whatever 
breakage they get.

I concur that there's no major harm in using the helper here, but I also 
see no point in pretending that there's any value to abstracting the 
operation in this particular context.

Thanks,
Robin.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: rebased on top of the latest codebase
>   drivers/iommu/dma-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d85d54f2b549..b585a3fdbc56 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1482,7 +1482,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
>   	if (iommu_is_dma_domain(domain)) {
>   		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
>   			goto out_err;
> -		dev->dma_ops = &iommu_dma_ops;
> +		set_dma_ops(dev, &iommu_dma_ops);
>   	}
>   
>   	return;
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
