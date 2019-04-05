Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94121C282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 18:09:17 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F60F2146F
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 18:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F60F2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A6D322636;
	Fri,  5 Apr 2019 18:09:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A87A3261D
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 18:08:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 4B84EFD
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 18:08:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C688168F;
	Fri,  5 Apr 2019 11:08:37 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B863D3F557;
	Fri,  5 Apr 2019 11:08:35 -0700 (PDT)
Subject: Re: [PATCH 06/21] dma-iommu: use for_each_sg in iommu_dma_alloc
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-7-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <e0143e7a-bfcd-36fb-ffe4-754cc1202fa3@arm.com>
Date: Fri, 5 Apr 2019 19:08:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-7-hch@lst.de>
Content-Language: en-GB
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190405180834.ZDa5SVv8Mtu5pZ6tGBmTfIuCE15LBovG42bAAj_ZylM@z>

On 27/03/2019 08:04, Christoph Hellwig wrote:
> arch_dma_prep_coherent can handle physically contiguous ranges larger
> than PAGE_SIZE just fine, which means we don't need a page-based
> iterator.

Heh, I got several minutes into writing a "but highmem..." reply before 
finding csky's arch_dma_prep_coherent() implementation. And of course 
that's why it specifically takes a page instead of any addresses. In 
hindsight I now have no idea why I didn't just write the flush_page() 
logic to work that way in the first place...

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/iommu/dma-iommu.c | 14 +++++---------
>   1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 77d704c8f565..f915cb7c46e6 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -577,15 +577,11 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
>   		goto out_free_iova;
>   
>   	if (!(prot & IOMMU_CACHE)) {
> -		struct sg_mapping_iter miter;
> -		/*
> -		 * The CPU-centric flushing implied by SG_MITER_TO_SG isn't
> -		 * sufficient here, so skip it by using the "wrong" direction.
> -		 */
> -		sg_miter_start(&miter, sgt.sgl, sgt.orig_nents, SG_MITER_FROM_SG);
> -		while (sg_miter_next(&miter))
> -			arch_dma_prep_coherent(miter.page, PAGE_SIZE);
> -		sg_miter_stop(&miter);
> +		struct scatterlist *sg;
> +		int i;
> +
> +		for_each_sg(sgt.sgl, sg, sgt.orig_nents, i)
> +			arch_dma_prep_coherent(sg_page(sg), sg->length);
>   	}
>   
>   	if (iommu_map_sg(domain, iova, sgt.sgl, sgt.orig_nents, prot)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
