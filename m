Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B3AC74A4B
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 08:59:41 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288B920872
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 08:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288B920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E2DAA4CE0;
	Thu, 11 Jul 2019 08:59:40 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 331814CC5
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 08:51:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 90E91CF
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 08:51:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3EDE2B;
	Thu, 11 Jul 2019 01:51:00 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12F223F59C;
	Thu, 11 Jul 2019 01:50:59 -0700 (PDT)
Subject: Re: [PATCH] kernel/dma: export dma_alloc_from_contiguous to modules
To: miles.chen@mediatek.com, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>
References: <20190711053343.28873-1-miles.chen@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7d14b94f-454f-d512-bc8f-589f71bc07ea@arm.com>
Date: Thu, 11 Jul 2019 09:50:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190711053343.28873-1-miles.chen@mediatek.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
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
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 11/07/2019 06:33, miles.chen@mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> This change exports dma_alloc_from_contiguous and
> dma_release_from_contiguous to modules.
> 
> Currently, we can add a reserve a memory node in dts files, make
> it a CMA memory by setting compatible = "shared-dma-pool",
> and setup the dev->cma_area by using of_reserved_mem_device_init_by_idx().
> 
> Export dma_alloc_from_contiguous and dma_release_from_contiguous, so we
> can allocate/free from/to dev->cma_area in kernel modules.

As far as I understand, this was never intended for drivers to call 
directly. If a device has its own private CMA area, then regular 
dma_alloc_attrs() should allocate from that automatically; if that's not 
happening already, then there's a bug somewhere.

Robin.

> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   kernel/dma/contiguous.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index b2a87905846d..d5920bdedc77 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -197,6 +197,7 @@ struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
>   
>   	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
>   }
> +EXPORT_SYMBOL_GPL(dma_alloc_from_contiguous);
>   
>   /**
>    * dma_release_from_contiguous() - release allocated pages
> @@ -213,6 +214,7 @@ bool dma_release_from_contiguous(struct device *dev, struct page *pages,
>   {
>   	return cma_release(dev_get_cma_area(dev), pages, count);
>   }
> +EXPORT_SYMBOL_GPL(dma_release_from_contiguous);
>   
>   /*
>    * Support for reserved memory regions defined in device tree
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
