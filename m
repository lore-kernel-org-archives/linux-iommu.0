Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49699C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 15:02:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC7220651
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 15:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC7220651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DEECD2202;
	Mon, 29 Apr 2019 15:02:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9E07821F9
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 15:00:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5196D711
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 15:00:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E415280D;
	Mon, 29 Apr 2019 08:00:25 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D34E3F5C1;
	Mon, 29 Apr 2019 08:00:24 -0700 (PDT)
Subject: Re: [PATCH 26/26] arm64: trim includes in dma-mapping.c
To: Christoph Hellwig <hch@lst.de>
References: <20190422175942.18788-1-hch@lst.de>
	<20190422175942.18788-27-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8d257026-870c-c183-4c34-48b9f8bc6872@arm.com>
Date: Mon, 29 Apr 2019 16:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190422175942.18788-27-hch@lst.de>
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
Message-ID: <20190429150022.W1k9_cQcwfPR9kRmYOhsFgbSxPgHpf81y9Ik0U4vbs4@z>

On 22/04/2019 18:59, Christoph Hellwig wrote:
> With most of the previous functionality now elsewhere a lot of the
> headers included in this file are not needed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm64/mm/dma-mapping.c | 11 -----------
>   1 file changed, 11 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 184ef9ccd69d..15bd768ceb7e 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -5,20 +5,9 @@
>    */
>   
>   #include <linux/gfp.h>
> -#include <linux/acpi.h>
> -#include <linux/memblock.h>
>   #include <linux/cache.h>
> -#include <linux/export.h>
> -#include <linux/slab.h>
> -#include <linux/genalloc.h>
> -#include <linux/dma-direct.h>
>   #include <linux/dma-noncoherent.h>
> -#include <linux/dma-contiguous.h>
>   #include <linux/dma-iommu.h>
> -#include <linux/vmalloc.h>
> -#include <linux/swiotlb.h>
> -#include <linux/pci.h>
> -

Nit: please keep the blank line between linux/ and asm/ include blocks 
to match the predominant local style.

With that,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   #include <asm/cacheflush.h>
>   
>   pgprot_t arch_dma_mmap_pgprot(struct device *dev, pgprot_t prot,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
