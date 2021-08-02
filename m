Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FCEC4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:02:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F76B610A2
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 15:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F76B610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5E63740015;
	Mon,  2 Aug 2021 15:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2AiaQBVCss08; Mon,  2 Aug 2021 15:02:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED1B3400A4;
	Mon,  2 Aug 2021 15:02:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE63AC001B;
	Mon,  2 Aug 2021 15:02:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87523C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 64A5440502
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:02:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gUyQ87sLU6yw for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 15:02:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7C79404FF
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 15:02:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0560260FC4;
 Mon,  2 Aug 2021 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627916520;
 bh=Itlu8DBFT8qE0fjbcCvRJBNsGuat0L/pnhVJ+0wi3t8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=p/ii3slm/ZyE9VlY2kJyItA2I3DwoyQ0TpfMuoDomWmhvGvptcP0as9XfixHJQH//
 FuMsgSg/A4CkXIfx7QWWSYKsqvSZw0TBy3FOtIvPs3tc+1Ig5cin/yd41fD4A4RyWD
 +q7k/MlQpe5F/kUyt1f0Aa34NJjp6dx0lB86o9K7hTRUJirTC1JNP4dFcjvkooB/y6
 wa3NFejkM5Pf6Ya/51cw+5bamOGgrd+krl7fAYBwB7Vj+BPWBI107/zuP49uXGyBhN
 J1biR41HoSwjTwB+JcfBMHKonNT8cadg9wp+s6tUXMbKY2aZLbwoykefGIHSXqjJXl
 YqQ7+CvdDoUbA==
Date: Mon, 2 Aug 2021 16:01:53 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 2/6] iova: Allow rcache range upper limit to be flexible
Message-ID: <20210802150153.GC28735@willie-the-truck>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1626259003-201303-3-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com, mst@redhat.com,
 airlied@linux.ie, gregkh@linuxfoundation.org, linuxarm@huawei.com,
 jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, daniel@ffwll.ch, bingbu.cao@intel.com,
 digetx@gmail.com, mchehab@kernel.org, robin.murphy@arm.com,
 jasowang@redhat.com, tian.shu.qiu@intel.com
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

On Wed, Jul 14, 2021 at 06:36:39PM +0800, John Garry wrote:
> Some LLDs may request DMA mappings whose IOVA length exceeds that of the
> current rcache upper limit.

What's an LLD?

> This means that allocations for those IOVAs will never be cached, and
> always must be allocated and freed from the RB tree per DMA mapping cycle.
> This has a significant effect on performance, more so since commit
> 4e89dce72521 ("iommu/iova: Retry from last rb tree node if iova search
> fails"), as discussed at [0].
> 
> As a first step towards allowing the rcache range upper limit be
> configured, hold this value in the IOVA rcache structure, and allocate
> the rcaches separately.
> 
> [0] https://lore.kernel.org/linux-iommu/20210129092120.1482-1-thunder.leizhen@huawei.com/
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/dma-iommu.c |  2 +-
>  drivers/iommu/iova.c      | 23 +++++++++++++++++------
>  include/linux/iova.h      |  4 ++--
>  3 files changed, 20 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 98ba927aee1a..4772278aa5da 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -434,7 +434,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
>  	 * rounding up anything cacheable to make sure that can't happen. The
>  	 * order of the unadjusted size will still match upon freeing.
>  	 */
> -	if (iova_len < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
> +	if (iova_len < (1 << (iovad->rcache_max_size - 1)))
>  		iova_len = roundup_pow_of_two(iova_len);
>  
>  	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b6cf5f16123b..07ce73fdd8c1 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -15,6 +15,8 @@
>  /* The anchor node sits above the top of the usable address space */
>  #define IOVA_ANCHOR	~0UL
>  
> +#define IOVA_RANGE_CACHE_MAX_SIZE 6    /* log of max cached IOVA range size (in pages) */

Is that the same as an 'order'? i.e. IOVA_RANGE_CACHE_MAX_ORDER?

> +
>  static bool iova_rcache_insert(struct iova_domain *iovad,
>  			       unsigned long pfn,
>  			       unsigned long size);
> @@ -881,7 +883,14 @@ static void init_iova_rcaches(struct iova_domain *iovad)
>  	unsigned int cpu;
>  	int i;
>  
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	iovad->rcache_max_size = IOVA_RANGE_CACHE_MAX_SIZE;
> +
> +	iovad->rcaches = kcalloc(iovad->rcache_max_size,
> +				 sizeof(*iovad->rcaches), GFP_KERNEL);
> +	if (!iovad->rcaches)
> +		return;

Returning quietly here doesn't seem like the right thing to do. At least, I
don't think the rest of the functions here are checking rcaches against
NULL.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
