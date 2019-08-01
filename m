Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3185C19759
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 14:09:35 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC76620679
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 14:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC76620679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EBA101970;
	Thu,  1 Aug 2019 14:09:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 355EB2397
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 14:08:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 989AD5F4
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 14:08:24 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7FDE168AFE; Thu,  1 Aug 2019 16:08:20 +0200 (CEST)
Date: Thu, 1 Aug 2019 16:08:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH 8/8] mm: comment arm64's usage of 'enum zone_type'
Message-ID: <20190801140820.GC23435@lst.de>
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
	<20190731154752.16557-9-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190731154752.16557-9-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: phill@raspberryi.org, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
	will@kernel.org, eric@anholt.net, marc.zyngier@arm.com,
	catalin.marinas@arm.com, frowand.list@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org, robh+dt@kernel.org,
	wahrenst@gmx.net, mbrugger@suse.com, akpm@linux-foundation.org,
	Robin Murphy <robin.murphy@arm.com>, hch@lst.de,
	linux-arm-kernel@lists.infradead.org
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

On Wed, Jul 31, 2019 at 05:47:51PM +0200, Nicolas Saenz Julienne wrote:
> +	 * Architecture			Limit
> +	 * ----------------------------------
> +	 * parisc, ia64, sparc, arm64	<4G
> +	 * s390, powerpc		<2G
> +	 * arm				Various
> +	 * alpha			Unlimited or 0-16MB.
>  	 *
>  	 * i386, x86_64 and multiple other arches
> -	 * 			<16M.
> +	 *				<16M.

powerpc is also Various now, arm64 isn't really < 4G, ia64 only uses
ZONE_DMA32 these days, and parisc doesn't seem to use neither ZONE_DMA
nor ZONE_DMA32.

Based on that I'm not sure the list really makes much sense.

>  	 */
>  	ZONE_DMA,
>  #endif
>  #ifdef CONFIG_ZONE_DMA32
>  	/*
> -	 * x86_64 needs two ZONE_DMAs because it supports devices that are
> -	 * only able to do DMA to the lower 16M but also 32 bit devices that
> -	 * can only do DMA areas below 4G.
> +	 * x86_64 and arm64 need two ZONE_DMAs because they support devices
> +	 * that are only able to DMA a fraction of the 32 bit addressable
> +	 * memory area, but also devices that are limited to that whole 32 bit
> +	 * area.
>  	 */
>  	ZONE_DMA32,

Maybe just say various architectures instead of mentioning specific
ones?  Something like "Some 64-bit platforms need.."
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
