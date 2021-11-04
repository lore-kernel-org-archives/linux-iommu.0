Return-Path: <SRS0=75oM=PX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43317C433F5
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 08:53:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3486103B
	for <iommu@archiver.kernel.org>; Thu,  4 Nov 2021 08:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA3486103B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 717FA4022B;
	Thu,  4 Nov 2021 08:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h5fJVGGTKpKu; Thu,  4 Nov 2021 08:53:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C1D5403C5;
	Thu,  4 Nov 2021 08:53:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DE93C0019;
	Thu,  4 Nov 2021 08:53:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 074BFC0012
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 08:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E9E29403C5
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 08:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m9jBtLwHPpxZ for <iommu@lists.linux-foundation.org>;
 Thu,  4 Nov 2021 08:53:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C2974022B
 for <iommu@lists.linux-foundation.org>; Thu,  4 Nov 2021 08:53:41 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 89EB968AA6; Thu,  4 Nov 2021 09:53:36 +0100 (CET)
Date: Thu, 4 Nov 2021 09:53:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Walter Wu <walter-zh.wu@mediatek.com>
Subject: Re: [PATCH v2] dma-direct: improve DMA_ATTR_NO_KERNEL_MAPPING
Message-ID: <20211104085336.GA24260@lst.de>
References: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211104023221.16391-1-walter-zh.wu@mediatek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: wsd_upstream <wsd_upstream@mediatek.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Thu, Nov 04, 2021 at 10:32:21AM +0800, Walter Wu wrote:
> diff --git a/include/linux/set_memory.h b/include/linux/set_memory.h
> index f36be5166c19..6c7d1683339c 100644
> --- a/include/linux/set_memory.h
> +++ b/include/linux/set_memory.h
> @@ -7,11 +7,16 @@
>  
>  #ifdef CONFIG_ARCH_HAS_SET_MEMORY
>  #include <asm/set_memory.h>
> +
> +#ifndef CONFIG_RODATA_FULL_DEFAULT_ENABLED

This is an arm64-specific symbol, and one that only controls a
default.  I don't think it is suitable to key off stubs in common
code.

> +static inline int set_memory_valid(unsigned long addr, int numpages, int enable) { return 0; }

Pleae avoid overly long lines.

> +		if (IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED)) {
> +			kaddr = (unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle));

This can just use page_address.

> +			/* page remove kernel mapping for arm64 */
> +			set_memory_valid(kaddr, size >> PAGE_SHIFT, 0);
> +		}

But more importantly:  set_memory_valid only exists on arm64, this
will break compile everywhere else.  And this API is complete crap.
Passing kernel virtual addresses as unsigned long just sucks, and
passing an integer argument for valid/non-valid also is a horrible
API.

Not to mention the overly long line.  Same on the free side.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
