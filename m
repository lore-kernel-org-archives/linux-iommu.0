Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F337C433EF
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 22:57:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3495342723;
	Thu, 26 May 2022 22:57:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4BnQRqJ-7-3Z; Thu, 26 May 2022 22:56:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BBAFC42722;
	Thu, 26 May 2022 22:56:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90AC2C0039;
	Thu, 26 May 2022 22:56:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFB0CC002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 22:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 97EC642723
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 22:56:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aZs2R1XblBvV for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 22:56:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4411E42722
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 22:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653605816; x=1685141816;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=aI6/VxU2h7xTzqWQsH03zlgK2zXxTVp7REvISJhfkUM=;
 b=G0uKK9pbTMGSiuEnLKSKO/pU5CbRjX3DNimqJKT0NAwjbQHab6ZsPak/
 CFuGhJy8j7U7C96E17Qckmy9DSpZjAZRipxYx/HjuBEsHoQubSyuWkUS9
 jVOv2o1GN425wOOZ79XnH3d+BmoS7uobqpSz9SR694Hri7YJWbD7DrlJZ
 8Y2x4UEcQC17epxcKFUwkpXN5afm6QTmA+YsbOyyybPdj0ck3GmZvQnds
 tGfR91C65iPF5QQPCN5Jz5g2Bg7NdqYyXD1nqSebWAXUDJKFoEU2S53uh
 ciZWAybY7+9erzicSgKWHhjZJeRADTVoLyxNNImrPu26LM5gKHRfrVtNO Q==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647273600"; d="scan'208";a="313562613"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2022 06:56:55 +0800
IronPort-SDR: de7X+54KCYlSxG7sHRhu5NJW9cCLQV5sZEr6bWaDfe8IQANQzodmvVAVEJDN2ULbvuMqKE8YqO
 q1xKsm8BmgNrbXv0GE9DrpYfQDCue9scsckZRN7/Nyv4sljFVMgjuzpWQYPrLB9IkUVPeYkZi1
 OGcc21MLjJkzkZWjIa1YpU/UY4kN5JKoWUtucxNM3WMyL5nuitFMaD+8fVKHjmWoXam4R4Qz7K
 +T75bRbVm9ZJ03wRCgNP2nIvacdEyutD5C7aeI21UYRBz2EKNEW8bxR402Tuw+vIULZkGlNQKv
 sIVkiaVMMb4cVSkvt3Djthyb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 May 2022 15:16:25 -0700
IronPort-SDR: NXZs479/JPhosQCb2KUIoxkN4RGYcJUcuY/hXZjToEzP647EAEyXOJXW3oIZOlp/AdgcrnVthO
 dOOkSzruBjOAM1uQvfD6UKrnGiVbB0vDlWUE4Yc5wSLeq6knZ7i4GprPAUkbrskedIQJAFrBMJ
 XfO+S6sBgvYsl4CCyhG9t5e9wVew1QCOaRWWzoAItJaCAGykEK/FtRwiiCv/f2P/rtFD2QhA7+
 6lAEpz5yds5DcwBlLnVrXbtH8wWr5vQpCftSTHNJPMQbYu7Mc11V3XPp+ucgl95TnVPh01gD4p
 mqM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 May 2022 15:56:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L8Nbp6WL9z1Rwrw
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 15:56:54 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653605813; x=1656197814; bh=aI6/VxU2h7xTzqWQsH03zlgK2zXxTVp7REv
 ISJhfkUM=; b=ZMjnbG7olkfDf5l1SwlHU8A4lGWkNdfHPtKYVJRHL+5eszhJpP+
 XEyIWslNSQeJl8YYdu9noa4TAhHFBxIAw8jquqtu01xUi7+l30f3iHky1jC0pjbl
 8fWsJWgKoNkpssnhCIO+DeRD8dLG8ouA7Td+mlBidx8Spj+d3Ai+FNwcAwV3gIHs
 QovipGbyUGe3joG6No8N7KsmIJnH6ZfPkHSwKLaET55vJbSJ/KkWGLAN+xIXOoEP
 0QBw9YJb0fVwt7ZrEXDu0R4sIwrCUxnJRX0pZfCmW7ddqPlNlx3hJbyJ2B0oZRIF
 lSjn902FTXM8dV2sJcOXy25EW/9oAa6kAGw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id wPqqiJin0Lk1 for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 15:56:53 -0700 (PDT)
Received: from [10.89.80.98] (c02drav6md6t.dhcp.fujisawa.hgst.com
 [10.89.80.98])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L8Nbl3WbCz1Rvlc;
 Thu, 26 May 2022 15:56:51 -0700 (PDT)
Message-ID: <36dbfa77-d8f0-88d4-7dda-1e18c4c453b8@opensource.wdc.com>
Date: Fri, 27 May 2022 07:56:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1653560914-82185-1-git-send-email-john.garry@huawei.com>
 <1653560914-82185-3-git-send-email-john.garry@huawei.com>
Organization: Western Digital Research
In-Reply-To: <1653560914-82185-3-git-send-email-john.garry@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-doc@vger.kernel.org,
 liyihang6@hisilicon.com, linux-kernel@vger.kernel.org,
 linux-ide@vger.kernel.org, iommu@lists.linux-foundation.org
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
From: Damien Le Moal via iommu <iommu@lists.linux-foundation.org>
Reply-To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/05/26 19:28, John Garry wrote:
> Add the IOMMU callback for DMA mapping API dma_opt_mapping_size(), which
> allows the drivers to know the optimal mapping limit and thus limit the
> requested IOVA lengths.
> 
> This value is based on the IOVA rcache range limit, as IOVAs allocated
> above this limit must always be newly allocated, which may be quite slow.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/dma-iommu.c | 6 ++++++
>  drivers/iommu/iova.c      | 5 +++++
>  include/linux/iova.h      | 2 ++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..f619e41b9172 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1442,6 +1442,11 @@ static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
>  	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
>  }
>  
> +static size_t iommu_dma_opt_mapping_size(void)
> +{
> +	return iova_rcache_range();
> +}
> +
>  static const struct dma_map_ops iommu_dma_ops = {
>  	.alloc			= iommu_dma_alloc,
>  	.free			= iommu_dma_free,
> @@ -1462,6 +1467,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>  	.map_resource		= iommu_dma_map_resource,
>  	.unmap_resource		= iommu_dma_unmap_resource,
>  	.get_merge_boundary	= iommu_dma_get_merge_boundary,
> +	.opt_mapping_size	= iommu_dma_opt_mapping_size,
>  };
>  
>  /*
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index db77aa675145..9f00b58d546e 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -26,6 +26,11 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>  static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>  static void free_iova_rcaches(struct iova_domain *iovad);
>  
> +unsigned long iova_rcache_range(void)
> +{
> +	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
> +}
> +
>  static int iova_cpuhp_dead(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct iova_domain *iovad;
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 320a70e40233..c6ba6d95d79c 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -79,6 +79,8 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
>  int iova_cache_get(void);
>  void iova_cache_put(void);
>  
> +unsigned long iova_rcache_range(void);
> +
>  void free_iova(struct iova_domain *iovad, unsigned long pfn);
>  void __free_iova(struct iova_domain *iovad, struct iova *iova);
>  struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
