Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC98C4332F
	for <iommu@archiver.kernel.org>; Sat, 21 May 2022 00:06:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCDB760FE2;
	Sat, 21 May 2022 00:06:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u11EPmPYFfJH; Sat, 21 May 2022 00:06:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2ED9460FEC;
	Sat, 21 May 2022 00:06:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FF39C0086;
	Sat, 21 May 2022 00:06:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4505CC002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F62A60FDA
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:33:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4y5sGIOSafAm for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 23:33:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DA6F60FD2
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 23:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653089614; x=1684625614;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=KysS6TGl8Pc7oX51Xw7igXQNpZmTRMOUskNztCAEee0=;
 b=SDiKNmZzgt8CoztNStaO0EkxMnRnGZUtM+dNbJno11cp0jGEOERp6EJe
 l7vto3codnHgcMWkmO/p2I8D28qgzhDgODHqa5+CSL3uUwnCdP5oxAIQb
 sdCb9QdLM7v24bbnxQl0i4zKg/ZtFQs50ypOVGcL8eCPIalrYC57vzDTb
 9BpBN6nLe6CuelJbEeT3j09ZyQcbg8ECEnnU/td5++Lr1baiOaTqfp5bQ
 PmGR6Gehy0515uw8IkbEH58AgXQi7+pQoulLeYblpDcbMYRQ0O4hnEOGi
 I3udZs7+pzETnZCXSfu3+mTCVNc48opLUWiySdrkXsbTS2HGBDWT881aT Q==;
X-IronPort-AV: E=Sophos;i="5.91,240,1647273600"; d="scan'208";a="199759770"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 May 2022 07:33:33 +0800
IronPort-SDR: C0HDEwFlDcBY/8tRFUqdMqQe1zt8u1/RuIRUtzPq42gJGZJ3alx8bOyWvt1bDgZQ4sCmMq/Ajq
 +7BxuHQyhuAbN5CLMeA5aZn18YFjANkrCXhSs8qgOB8H25pE6Fn265HnV96PB+Cnexz3hoon9d
 huHH+3uM+Zt/1oaBT93dMVC3+GZbtvyrL8hfojVQlGmP81IcS/rcptxw1nQnr2EhJTMdYYt052
 kbNk6Kb9bWr44QEQ08pOGtCrXcY6mW+FKo7IIGfawJh5o2q3b4Q10I2Iz9pHjrNL1vfYREuNyc
 zNi8F1fXvjVaqFWM9L7+nD8E
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 May 2022 15:56:16 -0700
IronPort-SDR: wRfGwMj+FHFStku861/0Od6WuWuJZwD5hgWu3wtBFYlM8XHS+AOWQki/hCvBXs97kuJE0+99Y2
 dYuvPbL18tPBLc6gJLC0uxJat9Mw2+Bd3zGAQp6coPlqGri5K5T2tS36EgeK0PHeGtkY9/1+75
 QF7uLUf6xLP9KklxeEERWenBfCAisTa9Edfi/O6gYnjrMKn+ejJ2cP0fsSggt+/gqEVQ4jo8qp
 B1B0oIvboyK5fBzwpLBQjqBv1e0JjLUTNV2KG0uO2Ysx7Dq4qTgqtnQ35d9ICZyxacLhfaTjqk
 yZY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 20 May 2022 16:33:33 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4jhs0HMsz1Rvlx
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 16:33:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653089612; x=1655681613; bh=KysS6TGl8Pc7oX51Xw7igXQNpZmTRMOUskN
 ztCAEee0=; b=uDGNOQIsh48inaoun4AJwCUgoJIBlCt2pvcG1/RPSae5nO73YFv
 dTjg1WJbEhrRrJrL6FBx9wI2n5x3PtQ3g7JxNREFUo1z0h8Wcsk+WF5izoeuwNqH
 5jS0Kz3SYNDbFExwLsgoDjZJgb/Ucoy9tTCeI+mAppQxcV5PuqkSjRGCglCLQalS
 pw67JD9iyU/mfxiU94bNsf6CnzD81OkVdHhRpUGqWsj20ClGWM7ej9elGn21cVjq
 H/bA5J78ULBEWq2jSPrlOwkLJrJ/Xjr1tQ4Qm9Sphuo/ih9Be4N1Cwlc2JTqAIlw
 bvuzzI1ozKNOCj8qIPICikHcZQLCqaxHFzA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id L9VoaoujDuwu for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 16:33:32 -0700 (PDT)
Received: from [10.225.163.51] (unknown [10.225.163.51])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4jhn73qjz1Rvlc;
 Fri, 20 May 2022 16:33:29 -0700 (PDT)
Message-ID: <250a10e6-40ae-e4e8-ae01-4f7144b089f8@opensource.wdc.com>
Date: Sat, 21 May 2022 08:33:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-3-git-send-email-john.garry@huawei.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-3-git-send-email-john.garry@huawei.com>
X-Mailman-Approved-At: Sat, 21 May 2022 00:06:20 +0000
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

On 5/20/22 17:23, John Garry wrote:
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

Why not a size_t return type ?

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


-- 
Damien Le Moal
Western Digital Research
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
