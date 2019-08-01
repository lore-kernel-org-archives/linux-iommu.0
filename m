Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E53C433FF
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 14:05:58 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FE620838
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 14:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FE620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 00E76155A;
	Thu,  1 Aug 2019 14:05:35 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 5692C1117
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 14:04:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2E7165F4
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 14:04:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5620168AFE; Thu,  1 Aug 2019 16:04:52 +0200 (CEST)
Date: Thu, 1 Aug 2019 16:04:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 6/8] dma-direct: turn ARCH_ZONE_DMA_BITS into a variable
Message-ID: <20190801140452.GB23435@lst.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
	<20190731154752.16557-7-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190731154752.16557-7-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Heiko Carstens <heiko.carstens@de.ibm.com>, eric@anholt.net,
	Paul Mackerras <paulus@samba.org>, will@kernel.org, hch@lst.de,
	phill@raspberryi.org, linux-s390@vger.kernel.org,
	f.fainelli@gmail.com, frowand.list@gmail.com,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	catalin.marinas@arm.com, devicetree@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>, marc.zyngier@arm.com,
	robh+dt@kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, mbrugger@suse.com,
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	wahrenst@gmx.net, Michael Ellerman <mpe@ellerman.id.au>,
	akpm@linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

A few nitpicks, otherwise this looks great:

> @@ -201,7 +202,7 @@ static int __init mark_nonram_nosave(void)
>   * everything else. GFP_DMA32 page allocations automatically fall back to
>   * ZONE_DMA.
>   *
> - * By using 31-bit unconditionally, we can exploit ARCH_ZONE_DMA_BITS to
> + * By using 31-bit unconditionally, we can exploit arch_zone_dma_bits to
>   * inform the generic DMA mapping code.  32-bit only devices (if not handled
>   * by an IOMMU anyway) will take a first dip into ZONE_NORMAL and get
>   * otherwise served by ZONE_DMA.
> @@ -237,9 +238,18 @@ void __init paging_init(void)
>  	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
>  	       (long int)((top_of_ram - total_ram) >> 20));
>  
> +	/*
> +	 * Allow 30-bit DMA for very limited Broadcom wifi chips on many
> +	 * powerbooks.
> +	 */
> +	if (IS_ENABLED(CONFIG_PPC32))
> +		arch_zone_dma_bits = 30;
> +	else
> +		arch_zone_dma_bits = 31;
> +

So the above unconditionally comment obviously isn't true any more, and
Ben also said for the recent ppc32 hack he'd prefer dynamic detection.

Maybe Ben and or other ppc folks can chime in an add a patch to the series
to sort this out now that we have a dynamic ZONE_DMA threshold?

> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 59bdceea3737..40dfc9b4ee4c 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -19,9 +19,7 @@
>   * Most architectures use ZONE_DMA for the first 16 Megabytes, but
>   * some use it for entirely different regions:
>   */
> -#ifndef ARCH_ZONE_DMA_BITS
> -#define ARCH_ZONE_DMA_BITS 24
> -#endif
> +unsigned int arch_zone_dma_bits __ro_after_init = 24;

I'd prefer to drop the arch_ prefix and just calls this zone_dma_bits.
In the long run we really need to find a way to just automatically set
this from the meminit code, but that is out of scope for this series.
For now can you please just update the comment above to say something
like:

/*
 * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use it
 * it for entirely different regions.  In that case the arch code needs to
 * override the variable below for dma-direct to work properly.
 */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
