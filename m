Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08C3C432BE
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 10:26:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A8E610A2
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 10:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68A8E610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03E2940357;
	Thu,  5 Aug 2021 10:26:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UMBrKyzr2Mhx; Thu,  5 Aug 2021 10:26:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 76913402A3;
	Thu,  5 Aug 2021 10:26:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55C71C0010;
	Thu,  5 Aug 2021 10:26:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D79D7C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 10:26:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B943740330
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 10:26:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txaag-aUuwxV for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 10:26:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9415D402A3
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 10:26:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB591FB;
 Thu,  5 Aug 2021 03:26:21 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9178A3F719;
 Thu,  5 Aug 2021 03:26:20 -0700 (PDT)
Subject: Re: [PATCH] of: restricted dma: Don't fail device probe on rmem init
 failure
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20210805094736.902-1-will@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <af998e69-671c-6d13-bd9b-da71b389575c@arm.com>
Date: Thu, 5 Aug 2021 11:26:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210805094736.902-1-will@kernel.org>
Content-Language: en-GB
Cc: Claire Chang <tientzu@chromium.org>, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-08-05 10:47, Will Deacon wrote:
> If CONFIG_DMA_RESTRICTED_POOL=n then probing a device with a reference
> to a "restricted-dma-pool" will fail with a reasonably cryptic error:
> 
>    | pci-host-generic: probe of 10000.pci failed with error -22
> 
> Print a more helpful message in this case and try to continue probing
> the device as we do if the kernel doesn't have the restricted DMA patches
> applied or either CONFIG_OF_ADDRESS or CONFIG_HAS_DMA =n.

Makes sense to me;

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Although if we allow probe to succeed when a pool really was there for a 
reason, it may end up being much more fatal if the driver then tries to 
do a DMA transfer to any old memory and the device access causes an 
SError, or the VM to be killed, or whatever. That's not quite the same 
as the stubbed cases where the respective platforms couldn't have a 
genuine pool to parse either way, but as you say it is what could happen 
already if the user tried to use an older kernel, and I think the chance 
of of_reserved_mem_device_init_by_idx() failing without something being 
terminally wrong anyway - invalid DT, not enough RAM, etc. - is low 
enough that it's probably not a major concern. Plus I'd hope that the 
memory protection schemes people do actually implement don't take such 
such a zero-tolerance approach anyway - allowing a malicious or 
malfunctioning device to take down the system because it tried to make a 
rogue access which *was* already contained seems a bit silly.

Robin.

> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   drivers/of/address.c    | 8 ++++----
>   drivers/of/device.c     | 2 +-
>   drivers/of/of_private.h | 8 +++-----
>   3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 973257434398..f6bf4b423c2a 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -997,7 +997,7 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>   	return ret;
>   }
>   
> -int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
> +void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>   {
>   	struct device_node *node, *of_node = dev->of_node;
>   	int count, i;
> @@ -1022,11 +1022,11 @@ int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np)
>   		 */
>   		if (of_device_is_compatible(node, "restricted-dma-pool") &&
>   		    of_device_is_available(node))
> -			return of_reserved_mem_device_init_by_idx(dev, of_node,
> -								  i);
> +			break;
>   	}
>   
> -	return 0;
> +	if (i != count && of_reserved_mem_device_init_by_idx(dev, of_node, i))
> +		dev_warn(dev, "failed to initialise \"restricted-dma-pool\" memory node\n");
>   }
>   #endif /* CONFIG_HAS_DMA */
>   
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 2defdca418ec..258a2b099410 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -166,7 +166,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>   	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>   
>   	if (!iommu)
> -		return of_dma_set_restricted_buffer(dev, np);
> +		of_dma_set_restricted_buffer(dev, np);
>   
>   	return 0;
>   }
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index f557bd22b0cf..bc883f69496b 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -163,18 +163,16 @@ struct bus_dma_region;
>   #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
>   int of_dma_get_range(struct device_node *np,
>   		const struct bus_dma_region **map);
> -int of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
> +void of_dma_set_restricted_buffer(struct device *dev, struct device_node *np);
>   #else
>   static inline int of_dma_get_range(struct device_node *np,
>   		const struct bus_dma_region **map)
>   {
>   	return -ENODEV;
>   }
> -static inline int of_dma_set_restricted_buffer(struct device *dev,
> -					       struct device_node *np)
> +static inline void of_dma_set_restricted_buffer(struct device *dev,
> +						struct device_node *np)
>   {
> -	/* Do nothing, successfully. */
> -	return 0;
>   }
>   #endif
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
