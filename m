Return-Path: <SRS0=NBt+=KO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F9FC433ED
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 18:54:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902C061355
	for <iommu@archiver.kernel.org>; Wed, 19 May 2021 18:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902C061355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54179405EE;
	Wed, 19 May 2021 18:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ba5B0hSk-1uX; Wed, 19 May 2021 18:54:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D655C403A3;
	Wed, 19 May 2021 18:54:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9796C000D;
	Wed, 19 May 2021 18:54:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C07B0C0001
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 18:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 98F2E40153
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 18:54:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nYOTNE9ky1uu for <iommu@lists.linux-foundation.org>;
 Wed, 19 May 2021 18:54:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2AB74013C
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 18:54:48 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id 69so7585171plc.5
 for <iommu@lists.linux-foundation.org>; Wed, 19 May 2021 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dOHil3dku6us1u8ptJ6JIh3xpDeGpcOMbsXrWxsBKoE=;
 b=cnnxKuD9wRMCCtazVzj6toxbgXcwxrb9Ouc86iDvINHgDyupM9mykeJyyckQXE4Rnq
 hq06c/AhNLxAl+uKAOVIR8t75aOIsL0QVqGA5chzbeSt0vvpUDh6dyPJSN8iQr/8cSTT
 naFa7nEaysxmImWzMWxEPel5LUj87LeUzIBfbiDL5YPxen+HitAXivixEaC0dK5umZ9C
 /hRQaspTbmz5yXsVRHAtEaCoC9OrLSx5wv4NZtIDg4qqr8EWekVxY4epEeIxfEclRFCW
 3sXGad/MPi4oLZncAM2dP7ovJhLYIIt2FuIu6GCpyimyCgdKa0aICR4C+b71QYuc2obh
 TPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dOHil3dku6us1u8ptJ6JIh3xpDeGpcOMbsXrWxsBKoE=;
 b=C8JsjLEJsFe2nB7lYiLY9v5+iCLdiuj4L9iuX3gjVQ4fSzCm2YmiR6fGJ7fm/JTKBb
 FDyaOsbz+1qflqu7M5+vW9chEBfkQewSQSwV2IgeYK+iR1SkMjA2LGEVclsSsYw6LMh/
 E9LgMwuxtvPTHUp544RO046v4M8IzTuAcIPJ6kxrWmu4YW6BWh5ipwd6uXAT2E5GdcZM
 I8nKkQFDdwZ2d7nvR50ucSuNDA9N+6Q/94/vkeBydZ67pdcfdU1HgeP9W/YBVhe3KBD8
 mAErR+UVKlvUuxGoyqXFJYKbMoc3vSrhs1vSZVVN3sAIhHFIodE4aPlFMPKK7ehfIa7E
 qAtw==
X-Gm-Message-State: AOAM530jiAJnoVyb613hwfCRW/Bm3kb7y6rJoeFSrFG74QcFxNgTVgK9
 78Tvk262XG3YVFTmTDDwKgU=
X-Google-Smtp-Source: ABdhPJxW6B5ZCMhQ2r/PwVD83uNx0fbqHe93UAEa6y6ZOrEtjXLovPk1PFllt4xgN3GhSn3N4TP6jw==
X-Received: by 2002:a17:902:ab89:b029:ee:dc90:7008 with SMTP id
 f9-20020a170902ab89b02900eedc907008mr1143149plr.30.1621450488169; 
 Wed, 19 May 2021 11:54:48 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id k15sm142717pfi.0.2021.05.19.11.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 11:54:47 -0700 (PDT)
Subject: Re: [PATCH v7 04/15] swiotlb: Add restricted DMA pool initialization
To: Claire Chang <tientzu@chromium.org>, Rob Herring <robh+dt@kernel.org>,
 mpe@ellerman.id.au, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-5-tientzu@chromium.org>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ae050c36-8179-e465-84f0-e46c361bd71e@gmail.com>
Date: Wed, 19 May 2021 11:54:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-5-tientzu@chromium.org>
Content-Language: en-US
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, rodrigo.vivi@intel.com,
 bhelgaas@google.com, Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Add the initialization function to create restricted DMA pools from
> matching reserved-memory nodes.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  include/linux/device.h  |  4 +++
>  include/linux/swiotlb.h |  3 +-
>  kernel/dma/swiotlb.c    | 76 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 38a2071cf776..4987608ea4ff 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -416,6 +416,7 @@ struct dev_links_info {
>   * @dma_pools:	Dma pools (if dma'ble device).
>   * @dma_mem:	Internal for coherent mem override.
>   * @cma_area:	Contiguous memory area for dma allocations
> + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
>   * @archdata:	For arch-specific additions.
>   * @of_node:	Associated device tree node.
>   * @fwnode:	Associated device node supplied by platform firmware.
> @@ -521,6 +522,9 @@ struct device {
>  #ifdef CONFIG_DMA_CMA
>  	struct cma *cma_area;		/* contiguous memory area for dma
>  					   allocations */
> +#endif
> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +	struct io_tlb_mem *dma_io_tlb_mem;
>  #endif
>  	/* arch specific additions */
>  	struct dev_archdata	archdata;
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 216854a5e513..03ad6e3b4056 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -72,7 +72,8 @@ extern enum swiotlb_force swiotlb_force;
>   *		range check to see if the memory was in fact allocated by this
>   *		API.
>   * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
> - *		@end. This is command line adjustable via setup_io_tlb_npages.
> + *		@end. For default swiotlb, this is command line adjustable via
> + *		setup_io_tlb_npages.
>   * @used:	The number of used IO TLB block.
>   * @list:	The free list describing the number of free entries available
>   *		from each index.
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b849b01a446f..1d8eb4de0d01 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -39,6 +39,13 @@
>  #ifdef CONFIG_DEBUG_FS
>  #include <linux/debugfs.h>
>  #endif
> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/slab.h>
> +#endif
>  
>  #include <asm/io.h>
>  #include <asm/dma.h>
> @@ -690,3 +697,72 @@ static int __init swiotlb_create_default_debugfs(void)
>  late_initcall(swiotlb_create_default_debugfs);
>  
>  #endif
> +
> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> +				    struct device *dev)
> +{
> +	struct io_tlb_mem *mem = rmem->priv;
> +	unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
> +
> +	if (dev->dma_io_tlb_mem)
> +		return 0;
> +
> +	/*
> +	 * Since multiple devices can share the same pool, the private data,
> +	 * io_tlb_mem struct, will be initialized by the first device attached
> +	 * to it.
> +	 */
> +	if (!mem) {
> +		mem = kzalloc(struct_size(mem, slots, nslabs), GFP_KERNEL);
> +		if (!mem)
> +			return -ENOMEM;
> +
> +		if (PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
> +			kfree(mem);
> +			return -EINVAL;

This could probably deserve a warning here to indicate that the reserved
area must be accessible within the linear mapping as I would expect a
lot of people to trip over that.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
