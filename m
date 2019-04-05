Return-Path: <SRS0=Eb89=SH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A93BC282CE
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 17:41:59 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7602E206BA
	for <iommu@archiver.kernel.org>; Fri,  5 Apr 2019 17:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7602E206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5A80825B4;
	Fri,  5 Apr 2019 17:41:59 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7FF6E2573
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 17:41:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5229C83A
	for <iommu@lists.linux-foundation.org>;
	Fri,  5 Apr 2019 17:41:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA7CF168F;
	Fri,  5 Apr 2019 10:41:04 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920933F557;
	Fri,  5 Apr 2019 10:41:03 -0700 (PDT)
Subject: Re: [PATCH 03/21] dma-mapping: add a Kconfig symbol to indicated
	arch_dma_prep_coherent presence
To: Christoph Hellwig <hch@lst.de>
References: <20190327080448.5500-1-hch@lst.de>
	<20190327080448.5500-4-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7c464875-b23a-9da4-afe7-93d7879ca3b8@arm.com>
Date: Fri, 5 Apr 2019 18:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190327080448.5500-4-hch@lst.de>
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
Message-ID: <20190405174102.v-P5KM7La7TmlKUjBdTKbQugXvNkNr_C5kG4TO8VCHk@z>

On 27/03/2019 08:04, Christoph Hellwig wrote:
> Add a Kconfig symbol that indicates an architecture provides a
> arch_dma_prep_coherent implementation, and provide a stub otherwise.
> 
> This will allow the generic dma-iommu code to it while still allowing

I think you accidentally a word there.

> to be built for cache coherent architectures.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/Kconfig              | 1 +
>   arch/csky/Kconfig               | 1 +
>   include/linux/dma-noncoherent.h | 6 ++++++
>   kernel/dma/Kconfig              | 3 +++
>   4 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7e34b9eba5de..adda078d6df7 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -13,6 +13,7 @@ config ARM64
>   	select ARCH_HAS_DEVMEM_IS_ALLOWED
>   	select ARCH_HAS_DMA_COHERENT_TO_PFN
>   	select ARCH_HAS_DMA_MMAP_PGPROT
> +	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
>   	select ARCH_HAS_ELF_RANDOMIZE
>   	select ARCH_HAS_FAST_MULTIPLIER
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 725a115759c9..2c3178848b7d 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -1,6 +1,7 @@
>   config CSKY
>   	def_bool y
>   	select ARCH_32BIT_OFF_T
> +	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_SYNC_DMA_FOR_CPU
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select ARCH_USE_BUILTIN_BSWAP
> diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
> index 69b36ed31a99..9741767e400f 100644
> --- a/include/linux/dma-noncoherent.h
> +++ b/include/linux/dma-noncoherent.h
> @@ -72,6 +72,12 @@ static inline void arch_sync_dma_for_cpu_all(struct device *dev)
>   }
>   #endif /* CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL */
>   
> +#ifdef CONFIG_ARCH_HAS_DMA_PREP_COHERENT
>   void arch_dma_prep_coherent(struct page *page, size_t size);
> +#else
> +static inline void arch_dma_prep_coherent(struct page *page, size_t size)
> +{
> +}
> +#endif /* CONFIG_ARCH_HAS_DMA_PREP_COHERENT */
>   
>   #endif /* _LINUX_DMA_NONCOHERENT_H */
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index a06ba3013b3b..feff2d21d8ee 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -38,6 +38,9 @@ config ARCH_HAS_SYNC_DMA_FOR_CPU
>   config ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
>   	bool
>   
> +config ARCH_HAS_DMA_PREP_COHERENT
> +	bool
> +

I guess the sorting in this whole Kconfig is already more or less 
"randomly-perturbed semi-alphabetical" :(

Anyway,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   config ARCH_HAS_DMA_COHERENT_TO_PFN
>   	bool
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
