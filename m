Return-Path: <SRS0=0Jvo=UX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92FBC43613
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 06:24:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBBE321670
	for <iommu@archiver.kernel.org>; Mon, 24 Jun 2019 06:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBE321670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8095DC21;
	Mon, 24 Jun 2019 06:24:47 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4FC60BA9
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 06:24:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D3149710
	for <iommu@lists.linux-foundation.org>;
	Mon, 24 Jun 2019 06:24:45 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id 19E9568AFE; Mon, 24 Jun 2019 08:24:15 +0200 (CEST)
Date: Mon, 24 Jun 2019 08:24:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [RFC PATCH v7 5/5] mmc: queue: Use bigger segments if DMA MAP
	layer can merge the segments
Message-ID: <20190624062414.GD2989@lst.de>
References: <1561020610-953-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1561020610-953-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1561020610-953-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: axboe@kernel.dk, linux-renesas-soc@vger.kernel.org, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-block@vger.kernel.org,
	wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Jun 20, 2019 at 05:50:10PM +0900, Yoshihiro Shimoda wrote:
> When the max_segs of a mmc host is smaller than 512, the mmc
> subsystem tries to use 512 segments if DMA MAP layer can merge
> the segments, and then the mmc subsystem exposes such information
> to the block layer by using blk_queue_can_use_dma_map_merging().
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/mmc/core/queue.c | 35 ++++++++++++++++++++++++++++++++---
>  include/linux/mmc/host.h |  1 +
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 92900a0..ab0ecc6 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -24,6 +24,8 @@
>  #include "card.h"
>  #include "host.h"
>  
> +#define MMC_DMA_MAP_MERGE_SEGMENTS	512
> +
>  static inline bool mmc_cqe_dcmd_busy(struct mmc_queue *mq)
>  {
>  	/* Allow only 1 DCMD at a time */
> @@ -196,6 +198,12 @@ static void mmc_queue_setup_discard(struct request_queue *q,
>  		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
>  }
>  
> +static unsigned int mmc_get_max_segments(struct mmc_host *host)
> +{
> +	return host->can_dma_map_merge ? MMC_DMA_MAP_MERGE_SEGMENTS :
> +					 host->max_segs;

I personally don't like superflous use of ? : if an if would be more
obvious:

	if (host->can_dma_map_merge)
		return MMC_DMA_MAP_MERGE_SEGMENTS;
	return host->max_segs;

but that is really just a nitpick and for the mmc maintainer to decide.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
