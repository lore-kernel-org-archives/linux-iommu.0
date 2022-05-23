Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87371C433F5
	for <iommu@archiver.kernel.org>; Mon, 23 May 2022 07:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 29874405C6;
	Mon, 23 May 2022 07:34:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2McBucD5b-tF; Mon, 23 May 2022 07:34:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 02AFF40AFA;
	Mon, 23 May 2022 07:34:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF903C0032;
	Mon, 23 May 2022 07:34:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F4CAC002D
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E3C441877
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=wdc.com header.b="Til5lEN3";
 dkim=pass (2048-bit key) header.d=opensource.wdc.com
 header.b="cqZ6jZYr"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bOR6SCyLMh0W for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 07:34:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C7EB341874
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 07:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1653291254; x=1684827254;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=h+UmZzsA9DQ/myvorGwrWNQn+6DDRetvo79UNzgmtCs=;
 b=Til5lEN3MiL4VyuoCs9ilESIOcVZ1vxlVX7DaCxJrp+xX54sk6DHiW2Y
 reW8VuE/qCqIQDBD2dMkrqWAqjtemhlN/CdPL068ACnO76W2Tda1FkTfL
 j2jQzNdhdLZs03g7QLVngN8mHyQzOfPxWRcVPBSFRPO1yvI8OXRcaKCce
 RR00gtvP23QJ9F/lVwlZscVlBTbKzGoDcQz90rERly2CoMlaOzcgGuy2m
 +dPO58W6l0Dpk4ikp7d9aeyKYlzOBRsSGsv67O7Ih2odNaRN1Su5vt2+A
 CasXowcRi/XOOSV55eMEQPDz6PwdGTa/XnW0kTMHw980P4ZvPALCb23/I w==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647273600"; d="scan'208";a="205998870"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 15:34:13 +0800
IronPort-SDR: ncvPaDKzyYU542sYDbsqfVAmK+2sLtakrrvbkWr5l26yk72jG2842Ljp0VH+EdPoczL7CIOplP
 epzMkieFABvPlfZ40znbkJKSlRg3xw/ri4W4upHUBYVOjgscE48IqReLqz0mztxXMUzevIQHke
 smrfj0qlWpZQd6UAxngrLtZX/WVcofFL9fxkgVoP3QRePQmy55TlBwC5MljdW6xizcULK6yM9t
 T/AtOqO79CGPWlEPIB1zXa+zgOIcPD8lY+R+/JteOJalyyV+CWsR5CzrEm6efWCHYFntYC1He8
 58+TjGBWSkzJmGZa4as9Wg00
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2022 23:58:13 -0700
IronPort-SDR: XrBP/dzayK90ZY63QEXXpkmXYGzEQyxBUXGNlJRQsAA9mCobP5Efo9P2jAIoZ7+rU/dKSZQ7qr
 7mf1+4kcNkF1u2IM2V0GUpbrjB6zv/vrfYleGP+yUqIvnmdbHe7Nnhp/2b/3hM3CvQPcGBAnTn
 nY28BlmQ3rZN/FCrLTekeI44FeCOfMRaix59APtMf/uTpPZw49TNSGByBR+Q0D7glqe1g0PEoP
 t7NRs0UFDBNIctJ1Feg45krgV2XDBv0RjOdfpSkoVaV83UCwdo9yXaUhCR3sKz2iA3ibyrsFnD
 Xjs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 May 2022 00:34:14 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L68GY2qbLz1SVp1
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 00:34:13 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1653291252; x=1655883253; bh=h+UmZzsA9DQ/myvorGwrWNQn+6DDRetvo79
 UNzgmtCs=; b=cqZ6jZYr4SmGijrtOIj6+lh3jkOdhPWaMe1i8SQ8n9EsLA7R4Au
 xsGI6TnzMuDc3fW9vZ0EbZgWOppQbWljo11SqlkkneKM+AbW5a2/dUQPUBH6UIaB
 7HiWKvZvszAAoCkzl740RmSVmbcJEUdbzQW4WNtBKltAr+K6+65cm5sL6UG2bbcT
 dG94j80enwe/hHM2mUGEGmq2+odtp51yZTqxCSL9czjWlXDG+vQ2/mIU1JDsmefY
 IH9xVqhPt3Mr1w+stzyZh6+hNxCt4IHC+EIoBkEHV8HqO0RRhbs3bE+DxUtCxqpZ
 IwoNO46u6CIkSUODSzVJULgcky7ZCKlWyzw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id QhpMF8UwiYhG for <iommu@lists.linux-foundation.org>;
 Mon, 23 May 2022 00:34:12 -0700 (PDT)
Received: from [10.89.85.73] (c02drav6md6t.dhcp.fujisawa.hgst.com
 [10.89.85.73])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L68GT6WZQz1Rvlc;
 Mon, 23 May 2022 00:34:09 -0700 (PDT)
Message-ID: <4e4aa6f0-7be4-d815-81b5-52f49e5f0455@opensource.wdc.com>
Date: Mon, 23 May 2022 16:34:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] dma-iommu: Add iommu_dma_opt_mapping_size()
Content-Language: en-US
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
References: <1653035003-70312-1-git-send-email-john.garry@huawei.com>
 <1653035003-70312-3-git-send-email-john.garry@huawei.com>
Organization: Western Digital Research
In-Reply-To: <1653035003-70312-3-git-send-email-john.garry@huawei.com>
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

On 2022/05/20 17:23, John Garry wrote:
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
