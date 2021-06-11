Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EE4C48BD1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 13:57:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693D0613FA
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 13:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693D0613FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 367C3404CB;
	Fri, 11 Jun 2021 13:57:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9IHDh33TEi4H; Fri, 11 Jun 2021 13:57:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 13D1340242;
	Fri, 11 Jun 2021 13:57:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D985EC000E;
	Fri, 11 Jun 2021 13:57:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22F47C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 13:57:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 109CE404C8
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 13:57:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xY5QNSekpqrU for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 13:57:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 698E740242
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 13:57:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AE0D6136D;
 Fri, 11 Jun 2021 13:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623419871;
 bh=AWgV4bmc3bhqQ3YMzaNffyJ3Z0ebJe9ErfEnzD8ZC4k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ftgXHKBP57eTVl2kXNV5HOJw8snhE5MH/1WJh/0rLs0dfdeUBjDBQmSfjOJ/j3bCW
 fFenox6M2hbp34GAEAGU6KJNuYnhp5+4s2EJeoCCDcVbi/i1OroqYVGsPpVg6pyGMS
 BE+vKIKp9s06CVOp944zx+GQmoauzg9vDpVE0zoynExgfn1uO0l4puYhrAexm2UHeE
 40BUL8C3dPCFJL2YeZajxim0GeYcyVShC77WLyHZaCZXM2YaD1uzpQes7Oy5nWiZUf
 LTdjFuhoyvsPUlyADkjSKFrzH/aSj6HG/RnS9+MJtJE/yWMzkUl1WXxJfSo5wMit3H
 Yr8DD9hvvAqRQ==
Date: Fri, 11 Jun 2021 14:57:47 +0100
From: Will Deacon <will@kernel.org>
To: Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Message-ID: <20210611135746.GC15776@willie-the-truck>
References: <20210607182541.119756-1-namit@vmware.com>
 <20210607182541.119756-5-namit@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210607182541.119756-5-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Nadav Amit <namit@vmware.com>, Jiajun Cao <caojiajun@vmware.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jun 07, 2021 at 11:25:39AM -0700, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Refactor iommu_iotlb_gather_add_page() and factor out the logic that
> detects whether IOTLB gather range and a new range are disjoint. To be
> used by the next patch that implements different gathering logic for
> AMD.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jiajun Cao <caojiajun@vmware.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-kernel@vger.kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  include/linux/iommu.h | 41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)

[...]

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f254c62f3720..b5a2bfc68fb0 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
>  	iommu_iotlb_gather_init(iotlb_gather);
>  }
>  
> +/**
> + * iommu_iotlb_gather_is_disjoint - Checks whether a new range is disjoint
> + *
> + * @gather: TLB gather data
> + * @iova: start of page to invalidate
> + * @size: size of page to invalidate
> + *
> + * Helper for IOMMU drivers to check whether a new range is and the gathered
> + * range are disjoint. 

I can't quite parse this. Delete the "is"?

>     For many IOMMUs, flushing the IOMMU in this case is
> + * better than merging the two, which might lead to unnecessary invalidations.
> + */
> +static inline
> +bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather *gather,
> +				    unsigned long iova, size_t size)
> +{
> +	unsigned long start = iova, end = start + size - 1;
> +
> +	return gather->end != 0 &&
> +		(end + 1 < gather->start || start > gather->end + 1);
> +}
> +
> +
>  /**
>   * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
>   * @gather: TLB gather data
> @@ -533,20 +555,16 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>  					       struct iommu_iotlb_gather *gather,
>  					       unsigned long iova, size_t size)
>  {
> -	unsigned long start = iova, end = start + size - 1;
> -
>  	/*
>  	 * If the new page is disjoint from the current range or is mapped at
>  	 * a different granularity, then sync the TLB so that the gather
>  	 * structure can be rewritten.
>  	 */
> -	if (gather->pgsize != size ||
> -	    end + 1 < gather->start || start > gather->end + 1) {
> -		if (gather->pgsize)
> -			iommu_iotlb_sync(domain, gather);
> -		gather->pgsize = size;
> -	}
> +	if ((gather->pgsize && gather->pgsize != size) ||
> +	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
> +		iommu_iotlb_sync(domain, gather);
>  
> +	gather->pgsize = size;

Why have you made this unconditional? I think it's ok, but just not sure
if it's necessary or not.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
