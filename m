Return-Path: <SRS0=PtwI=XH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B193ECDE2A
	for <iommu@archiver.kernel.org>; Thu, 12 Sep 2019 10:53:57 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 408B620678
	for <iommu@archiver.kernel.org>; Thu, 12 Sep 2019 10:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 408B620678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 016E1D48;
	Thu, 12 Sep 2019 10:53:57 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id EC542CC0
	for <iommu@lists.linux-foundation.org>;
	Thu, 12 Sep 2019 10:53:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 84B0C89B
	for <iommu@lists.linux-foundation.org>;
	Thu, 12 Sep 2019 10:53:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D01551000;
	Thu, 12 Sep 2019 03:53:54 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF10C3F59C;
	Thu, 12 Sep 2019 03:53:53 -0700 (PDT)
Subject: Re: [PATCH 3/3] iommu/io-pgtable-arm: Allow coherent walks for Mali
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org
References: <cover.1568211045.git.robin.murphy@arm.com>
	<8eb563978e7e872ddde45c0413e1a3f30b792658.1568211045.git.robin.murphy@arm.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <5aee1c30-65ba-a608-6033-dedf004b24ea@arm.com>
Date: Thu, 12 Sep 2019 11:53:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8eb563978e7e872ddde45c0413e1a3f30b792658.1568211045.git.robin.murphy@arm.com>
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
> Midgard GPUs have ACE-Lite master interfaces which allows systems to
> integrate them in an I/O-coherent manner. It seems that from the GPU's
> viewpoint, the rest of the system is its outer shareable domain, and it
> will only emit snoop signals for outer shareable accesses. As such,
> setting the TTBR_SHARE_OUTER bit does indeed get coherent pagetable
> walks working nicely.
> 
> Making data accesses coherent seems to be more of a challenge...
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Note the terminology in the GPU is *very* confusing here. Midgard refers
to the system's inner shareable domain as "outer shareable", and uses
"inner shareable" to mean purely within the GPU.

For data access kbase sets up a different default MEMATTR if ACE is
available:

	/* Set to implementation defined, outer caching */
	#define AS_MEMATTR_LPAE_OUTER_IMPL_DEF        0x88ull
[...]
	#define AS_MEMATTR_INDEX_DEFAULT_ACE           3
[...]
	/* Outer coherent, inner implementation defined policy */
	#define AS_MEMATTR_INDEX_OUTER_IMPL_DEF        3

Steve

> ---
>  drivers/iommu/io-pgtable-arm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 77f41c9dd9be..2794d4661339 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -1061,6 +1061,9 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>  	cfg->arm_mali_lpae_cfg.transtab = virt_to_phys(data->pgd) |
>  					  ARM_MALI_LPAE_TTBR_READ_INNER |
>  					  ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
> +	if (cfg->coherent_walk)
> +		cfg->arm_mali_lpae_cfg.transtab |= ARM_MALI_LPAE_TTBR_SHARE_OUTER;
> +
>  	return &data->iop;
>  
>  out_free_data:
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
