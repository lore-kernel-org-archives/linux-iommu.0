Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853B6C433E7
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 11:37:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C452076D
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 11:37:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C452076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AE867869A4;
	Mon, 12 Oct 2020 11:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ziyrrZitXB-c; Mon, 12 Oct 2020 11:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0D9408699E;
	Mon, 12 Oct 2020 11:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE49EC0052;
	Mon, 12 Oct 2020 11:37:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39875C0051
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 11:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A45C1204D5
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 11:37:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fmCnFsj0bOs6 for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 11:37:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id D1B7D20452
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 11:37:53 +0000 (UTC)
Received: from gaia (unknown [95.149.105.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 196EE206E5;
 Mon, 12 Oct 2020 11:37:50 +0000 (UTC)
Date: Mon, 12 Oct 2020 12:37:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 1/5] arm64: mm: Move zone_dma_bits initialization into
 zone_sizes_init()
Message-ID: <20201012113748.GE9844@gaia>
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
 <20201010151235.20585-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201010151235.20585-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, jeremy.linton@arm.com, ardb@kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-rpi-kernel@lists.infradead.org, robin.murphy@arm.com, hch@lst.de,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sat, Oct 10, 2020 at 05:12:31PM +0200, Nicolas Saenz Julienne wrote:
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index f6902a2b4ea6..0eca5865dcb1 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -196,14 +196,16 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
>  
>  #ifdef CONFIG_ZONE_DMA
> +	zone_dma_bits = ARM64_ZONE_DMA_BITS;
> +
>  	if (IS_ENABLED(CONFIG_ACPI)) {
>  		extern unsigned int acpi_iort_get_zone_dma_size(void);
>  
>  		zone_dma_bits = min(zone_dma_bits,
>  				    acpi_iort_get_zone_dma_size());
> -		arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
>  	}
>  
> +	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif
>  #ifdef CONFIG_ZONE_DMA32
> @@ -394,11 +396,6 @@ void __init arm64_memblock_init(void)
>  
>  	early_init_fdt_scan_reserved_mem();
>  
> -	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
> -		zone_dma_bits = ARM64_ZONE_DMA_BITS;
> -		arm64_dma_phys_limit = max_zone_phys(ARM64_ZONE_DMA_BITS);
> -	}

arm64_dma_phys_limit is used by memblock_alloc_low() (via
ARCH_LOW_ADDRESS_LIMIT). I think it's too late to leave its
initialisation to zone_sizes_init().

-- 
Catalin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
