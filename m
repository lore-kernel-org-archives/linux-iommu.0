Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EED3C433DB
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 02:49:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE9A64DCD
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 02:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE9A64DCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B7287274D1;
	Thu, 28 Jan 2021 02:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cy9eiIXnlvUb; Thu, 28 Jan 2021 02:49:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B5BFB228E7;
	Thu, 28 Jan 2021 02:49:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 814FBC08A1;
	Thu, 28 Jan 2021 02:49:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7D7FC013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8DAEE86A0B
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hzMkmRGqx+TB for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 02:48:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 39297869BA
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 02:48:58 +0000 (UTC)
IronPort-SDR: An+1OAUgXiO1yOmGb+DbuAHo/8yp4XN7bz/Fvd6uFtKH+2bF301bI9rvmRn0JL0Hwu3brgdea1
 ds2jRKc/YxxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="198998783"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; d="scan'208";a="198998783"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 18:48:57 -0800
IronPort-SDR: aJF/wjIPpkc5qG5agi/TaEAFnHyoCRd1LVTevrJwZzJ2gW58ubDGH3UNSF03OeuROcA90fCABp
 xZG+o5LZzT0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; d="scan'208";a="403314572"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 27 Jan 2021 18:48:55 -0800
Subject: Re: [PATCH RFC 1/9] iommu: Move iotlb_sync_map out from __iommu_map
To: Chuck Lever <chuck.lever@oracle.com>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
 <161177762627.1311.2628379822104975433.stgit@manet.1015granger.net>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c37b95f9-ac52-af05-36a3-cde05446d524@linux.intel.com>
Date: Thu, 28 Jan 2021 10:40:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161177762627.1311.2628379822104975433.stgit@manet.1015granger.net>
Content-Language: en-US
Cc: isaacm@codeaurora.org, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, will@kernel.org
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

Hi,

On 1/28/21 4:00 AM, Chuck Lever wrote:
> From: Yong Wu <yong.wu@mediatek.com>
> 
> In the end of __iommu_map, It alway call iotlb_sync_map.
> 
> This patch moves iotlb_sync_map out from __iommu_map since it is
> unnecessary to call this for each sg segment especially iotlb_sync_map
> is flush tlb all currently. Add a little helper _iommu_map for this.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>   drivers/iommu/iommu.c |   23 ++++++++++++++++++-----
>   1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ffeebda8d6de..c304a6a30d42 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2426,9 +2426,6 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		size -= pgsize;
>   	}
>   
> -	if (ops->iotlb_sync_map)
> -		ops->iotlb_sync_map(domain);
> -
>   	/* unroll mapping in case something went wrong */
>   	if (ret)
>   		iommu_unmap(domain, orig_iova, orig_size - size);
> @@ -2438,18 +2435,31 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	return ret;
>   }
>   
> +static int _iommu_map(struct iommu_domain *domain, unsigned long iova,
> +		      phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	int ret;
> +
> +	ret = __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +	if (ret == 0 && ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain);

Previous code called iotlb_sync_map() regardless of whether the mapping
was successful or not. Here the logic changes, and the callback is only
called if mapping successfully.

Any reason? It's safer to always call iotlb_sync_map() even in failed
mapping case. In this way, we can ensure the consistency of cache as
much as possible.

Best regards,
baolu

> +
> +	return ret;
> +}
> +
>   int iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	      phys_addr_t paddr, size_t size, int prot)
>   {
>   	might_sleep();
> -	return __iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
> +	return _iommu_map(domain, iova, paddr, size, prot, GFP_KERNEL);
>   }
>   EXPORT_SYMBOL_GPL(iommu_map);
>   
>   int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
>   	      phys_addr_t paddr, size_t size, int prot)
>   {
> -	return __iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
> +	return _iommu_map(domain, iova, paddr, size, prot, GFP_ATOMIC);
>   }
>   EXPORT_SYMBOL_GPL(iommu_map_atomic);
>   
> @@ -2533,6 +2543,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   			     struct scatterlist *sg, unsigned int nents, int prot,
>   			     gfp_t gfp)
>   {
> +	const struct iommu_ops *ops = domain->ops;
>   	size_t len = 0, mapped = 0;
>   	phys_addr_t start;
>   	unsigned int i = 0;
> @@ -2563,6 +2574,8 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>   			sg = sg_next(sg);
>   	}
>   
> +	if (ops->iotlb_sync_map)
> +		ops->iotlb_sync_map(domain);
>   	return mapped;
>   
>   out_err:
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
