Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027ABC433F5
	for <iommu@archiver.kernel.org>; Tue, 17 May 2022 08:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9DCD83E19;
	Tue, 17 May 2022 08:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vG-1IWpiKPOq; Tue, 17 May 2022 08:38:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 92EB883E0A;
	Tue, 17 May 2022 08:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67181C0039;
	Tue, 17 May 2022 08:38:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5B83C002D
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 08:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B19CE400F1
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 08:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zEpnc6LFtw-V for <iommu@lists.linux-foundation.org>;
 Tue, 17 May 2022 08:38:39 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D3365400B8
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 08:38:38 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4240467373; Tue, 17 May 2022 10:38:35 +0200 (CEST)
Date: Tue, 17 May 2022 10:38:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@huawei.com>
Subject: Re: [RFC PATCH] dma-iommu: Add iommu_dma_max_mapping_size()
Message-ID: <20220517083834.GA16965@lst.de>
References: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1652706361-92557-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: will@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de,
 liyihang6@hisilicon.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, May 16, 2022 at 09:06:01PM +0800, John Garry wrote:
> For streaming DMA mappings involving an IOMMU and whose IOVA len regularly
> exceeds the IOVA rcache upper limit (meaning that they are not cached),
> performance can be reduced.
> 
> Add the IOMMU callback for DMA mapping API dma_max_mapping_size(), which
> allows the drivers to know the mapping limit and thus limit the requested 
> IOVA lengths.
> 
> This resolves the performance issue originally reported in [0] for a SCSI
> HBA driver which was regularly mapping SGLs which required IOVAs in
> excess of the IOVA caching limit. In this case the block layer limits the
> max sectors per request - as configured in __scsi_init_queue() - which
> will limit the total SGL length the driver tries to map and in turn limits
> IOVA lengths requested.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Sending as an RFC as iommu_dma_max_mapping_size() is a soft limit, and not
> a hard limit which I expect is the semantics of dma_map_ops.max_mapping_size
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..e2d5205cde37 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1442,6 +1442,21 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>  	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>  }
>  

> +	if (!domain)
> +		return 0;
> +
> +	cookie = domain->iova_cookie;
> +	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
> +		return 0;

Can these conditions even be true here?

> +static inline unsigned long iova_rcache_range(void)
> +{
> +	return 0;
> +}

Given that IOMMU_DMA select IOMMU_IOVA there is no need for this stub.

Otherwise this looks sensible to me.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
