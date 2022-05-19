Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F60C433EF
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 10:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 626AB41C2B;
	Thu, 19 May 2022 10:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 62EYB54F_8Bd; Thu, 19 May 2022 10:20:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED99B41C21;
	Thu, 19 May 2022 10:20:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9B13C0039;
	Thu, 19 May 2022 10:20:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3105BC002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 10:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 08BDD41C2B
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 10:20:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CQ0lRwCvAs7u for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 10:20:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D75BA41C21
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 10:20:46 +0000 (UTC)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L3m4z1Chfz6H8Vm;
 Thu, 19 May 2022 18:17:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 12:20:42 +0200
Received: from [10.47.92.25] (10.47.92.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 11:20:42 +0100
Message-ID: <7ced25fb-9048-3df8-a62c-bfcb29176579@huawei.com>
Date: Thu, 19 May 2022 11:20:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] iommu/dma: Add config for PCI SAC address trick
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
References: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
In-Reply-To: <ef8abf1c6b0839e39b272738fc7bc4d9699c8bcb.1652895419.git.robin.murphy@arm.com>
X-Originating-IP: [10.47.92.25]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, hch@lst.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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
From: John Garry via iommu <iommu@lists.linux-foundation.org>
Reply-To: John Garry <john.garry@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 18/05/2022 18:36, Robin Murphy wrote:
> For devices stuck behind a conventional PCI bus, saving extra cycles at
> 33MHz is probably fairly significant. However since native PCI Express
> is now the norm for high-performance devices, the optimisation to always
> prefer 32-bit addresses for the sake of avoiding DAC is starting to look
> rather anachronistic. Technically 32-bit addresses do have shorter TLPs
> on PCIe, but unless the device is saturating its link bandwidth with
> small transfers it seems unlikely that the difference is appreciable.
> 
> What definitely is appreciable, however, is that the IOVA allocator
> doesn't behave all that well once the 32-bit space starts getting full.
> As DMA working sets get bigger, this optimisation increasingly backfires
> and adds considerable overhead to the dma_map path for use-cases like
> high-bandwidth networking. We've increasingly bandaged the allocator
> in attempts to mitigate this, but it remains fundamentally at odds with
> other valid requirements to try as hard as possible to satisfy a request
> within the given limit; what we really need is to just avoid this odd
> notion of a speculative allocation when it isn't beneficial anyway.
> 
> Unfortunately that's where things get awkward... Having been present on
> x86 for 15 years or so now, it turns out there are systems which fail to
> properly define the upper limit of usable IOVA space for certain devices
> and this trick was the only thing letting them work OK. I had a similar
> ulterior motive for a couple of early arm64 systems when originally
> adding it to iommu-dma, but those really should now be fixed with proper
> firmware bindings, and other arm64 users really need it out of the way,
> so let's just leave it default-on for x86.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/Kconfig     | 24 ++++++++++++++++++++++++
>   drivers/iommu/dma-iommu.c |  2 +-

It might be worth printing this default value always and not just for 
when it is set from commandline, like what we do for default domain type 
and IOTLB invalidation policy

>   2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index c79a0df090c0..bf9b295f1c89 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -144,6 +144,30 @@ config IOMMU_DMA
>   	select IRQ_MSI_IOMMU
>   	select NEED_SG_DMA_LENGTH
>   
> +config IOMMU_DMA_PCI_SAC_OPT
> +	bool "Enable 64-bit legacy PCI optimisation by default"
> +	depends on IOMMU_DMA
> +	default X86

Do we have a strategy for if and when issues start popping up on other 
architectures? Is it to simply tell them to just turn this flag on (and 
also fix your platform)?

> +	help
> +	  Enable by default an IOMMU optimisation for 64-bit legacy PCI devices,
> +	  wherein the DMA API layer will always first try to allocate a 32-bit
> +	  DMA address suitable for a single address cycle, before falling back
> +	  to allocating from the full usable address range. If your system has
> +	  64-bit legacy PCI devices in 32-bit slots where using dual address
> +	  cycles reduces DMA throughput significantly, this optimisation may be
> +	  beneficial to overall performance.
> +
> +	  If you have a modern PCI Express based system, it should usually be
> +	  safe to say "n" here and avoid the potential extra allocation overhead.
> +	  However, beware that this optimisation has also historically papered
> +	  over bugs where the IOMMU address range above 32 bits is not fully
> +	  usable. If device DMA problems and/or IOMMU faults start occurring
> +	  with IOMMU translation enabled after disabling this option, it is
> +	  likely a sign of a latent driver or firmware/BIOS bug.
> +
> +	  If this option is not set, the optimisation can be enabled at
> +	  boot time with the "iommu.forcedac=0" command-line argument.
> +

Thanks,
John
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
