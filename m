Return-Path: <SRS0=GPDh=E7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15821C63798
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:38:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D92E21527
	for <iommu@archiver.kernel.org>; Wed, 25 Nov 2020 16:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D92E21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E5F212E1A7;
	Wed, 25 Nov 2020 16:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zZjbdMk9tjfE; Wed, 25 Nov 2020 16:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CDA41203B4;
	Wed, 25 Nov 2020 16:38:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B50C6C0891;
	Wed, 25 Nov 2020 16:38:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F0BCC0052
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D97402E19F
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3kmRXX0SKbq for <iommu@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 16:38:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 3A373203B4
 for <iommu@lists.linux-foundation.org>; Wed, 25 Nov 2020 16:38:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF38131B;
 Wed, 25 Nov 2020 08:38:38 -0800 (PST)
Received: from [10.57.59.159] (unknown [10.57.59.159])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EE6E3F7BB;
 Wed, 25 Nov 2020 08:38:36 -0800 (PST)
Subject: Re: [PATCH v2 4/6] iommu: Add granule_ignore when tlb gather
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
 <20201119061836.15238-5-yong.wu@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <49bae447-d662-e6cf-7500-ab78e3b75dc4@arm.com>
Date: Wed, 25 Nov 2020 16:38:35 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119061836.15238-5-yong.wu@mediatek.com>
Content-Language: en-GB
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, jun.wen@mediatek.com,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
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

On 2020-11-19 06:18, Yong Wu wrote:
> Add a granule_ignore option when tlb gather for some HW which don't care
> about granule when it flush tlb.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   include/linux/iommu.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 794d4085edd3..1aad32238510 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -171,6 +171,7 @@ enum iommu_dev_features {
>    * @start: IOVA representing the start of the range to be flushed
>    * @end: IOVA representing the end of the range to be flushed (exclusive)
>    * @pgsize: The interval at which to perform the flush
> + * @granule_ignore: For tlb flushing that could be regardless of granule.
>    *
>    * This structure is intended to be updated by multiple calls to the
>    * ->unmap() function in struct iommu_ops before eventually being passed
> @@ -180,6 +181,7 @@ struct iommu_iotlb_gather {
>   	unsigned long		start;
>   	unsigned long		end;
>   	size_t			pgsize;
> +	bool			granule_ignore;

I can't see that this would ever need to vary on a per-unmap-operation 
basis, so this doesn't seem like the right level of abstraction. AFAICS 
it should simply be hard-coded in the driver logic.

>   };
>   
>   /**
> @@ -544,7 +546,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
>   	 * a different granularity, then sync the TLB so that the gather
>   	 * structure can be rewritten.
>   	 */
> -	if (gather->pgsize != size ||
> +	if ((!gather->granule_ignore && gather->pgsize != size) ||

I also think this is a slippery slope in the wrong direction anyway - 
there is likely to be a fair bit of hardware-dependent variation around 
how low-level TLB maintenance works (also consider drivers that may want 
to convert a sufficiently large range to an "invalidate all" operation), 
so if a generic helper function doesn't do the right thing for a given 
driver, that driver should simply not use the helper, and directly 
implement the logic it does need.

Robin.

>   	    end < gather->start || start > gather->end) {
>   		if (gather->pgsize)
>   			iommu_iotlb_sync(domain, gather);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
