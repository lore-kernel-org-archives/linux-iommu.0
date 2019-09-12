Return-Path: <SRS0=PtwI=XH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29788C43331
	for <iommu@archiver.kernel.org>; Thu, 12 Sep 2019 10:47:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9476208C2
	for <iommu@archiver.kernel.org>; Thu, 12 Sep 2019 10:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9476208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9CFAAA95;
	Thu, 12 Sep 2019 10:47:53 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BCE7C89C
	for <iommu@lists.linux-foundation.org>;
	Thu, 12 Sep 2019 10:47:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 509B387D
	for <iommu@lists.linux-foundation.org>;
	Thu, 12 Sep 2019 10:47:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 029601000;
	Thu, 12 Sep 2019 03:47:52 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EA643F59C;
	Thu, 12 Sep 2019 03:47:50 -0700 (PDT)
Subject: Re: [PATCH 2/3] iommu/io-pgtable-arm: Support more Mali configurations
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org
References: <cover.1568211045.git.robin.murphy@arm.com>
	<69c934789ad2bf486b03682563ea2262ea6d9301.1568211045.git.robin.murphy@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <6e3f7b2f-fa84-422f-602a-0773835018cb@arm.com>
Date: Thu, 12 Sep 2019 11:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <69c934789ad2bf486b03682563ea2262ea6d9301.1568211045.git.robin.murphy@arm.com>
Content-Language: en-GB
Cc: robh@kernel.org, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org, tomeu.vizoso@collabora.com,
	narmstrong@baylibre.com
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

On 11/09/2019 15:42, Robin Murphy wrote:
> In principle, Midgard GPUs supporting smaller VA sizes should only
> require 3-level pagetables, since the address bits resolved at level 0
> (47:40) will never change. However, the kbase driver does not appear to
> have any notion of a variable start level, and empirically T720 and T820
> rapidly blow up with translation faults unless given a full 4-level
> table, despite only supporting a 33-bit VA size.

Midgard 'LPAE' isn't really LPAE and does indeed always require all
levels of page tables. The 33-bit VA size is really only limiting the
storage of virtual addresses in the GPU and not affecting the MMU.

> The 'real' IAS value is still valuable in terms of validating addresses
> on map/unmap, so tweak the allocator to allow smaller values while still
> forcing the resultant tables to the full 4 levels.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Steve

> ---
>  drivers/iommu/io-pgtable-arm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 9e35cd991f06..77f41c9dd9be 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -1022,7 +1022,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>  	if (cfg->quirks)
>  		return NULL;
>  
> -	if (cfg->ias != 48 || cfg->oas > 40)
> +	if (cfg->ias > 48 || cfg->oas > 40)
>  		return NULL;
>  
>  	cfg->pgsize_bitmap &= (SZ_4K | SZ_2M | SZ_1G);
> @@ -1031,6 +1031,11 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>  	if (!data)
>  		return NULL;
>  
> +	/* Mali seems to need a full 4-level table regardless of IAS */
> +	if (data->levels < ARM_LPAE_MAX_LEVELS) {
> +		data->levels = ARM_LPAE_MAX_LEVELS;
> +		data->pgd_size = sizeof(arm_lpae_iopte);
> +	}
>  	/*
>  	 * MEMATTR: Mali has no actual notion of a non-cacheable type, so the
>  	 * best we can do is mimic the out-of-tree driver and hope that the
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
