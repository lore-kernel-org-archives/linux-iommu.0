Return-Path: <SRS0=zShu=DV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6AEC43467
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 22:03:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6D6212CC
	for <iommu@archiver.kernel.org>; Wed, 14 Oct 2020 22:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/lahTRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6D6212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A64A888422;
	Wed, 14 Oct 2020 22:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tPZRSpmA4xnv; Wed, 14 Oct 2020 22:03:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ED2A688419;
	Wed, 14 Oct 2020 22:03:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD076C07FF;
	Wed, 14 Oct 2020 22:03:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA417C0051
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 22:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9D93A2E2E5
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 22:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pk5GWwLzzAqD for <iommu@lists.linux-foundation.org>;
 Wed, 14 Oct 2020 22:03:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 62C922E2D0
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 22:03:01 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B4BFF22248
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 22:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602712980;
 bh=Ju1dyFsTDcTPe6t7qyxytlV5nWkENiIe/ObQZVMzwiI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=U/lahTRHBOJ5lVrgoCVaTmILC7j4vTHf7+pSKfDi250oUm+0W2wXsNbH4lngjWBMV
 dlE6TK6OyKgCI5a8/MlkXliHYtv5xmTtN/MtBW6wFTjm7AkJJwXxfHfw6JM2BBhHJi
 S6zT6LeY0pxL4gZH2WTIzgCC6vFZJlJ4ggnU0p/M=
Received: by mail-oi1-f180.google.com with SMTP id m128so840727oig.7
 for <iommu@lists.linux-foundation.org>; Wed, 14 Oct 2020 15:03:00 -0700 (PDT)
X-Gm-Message-State: AOAM530wTVImsx3pKcYfYeec7S7x0ZGkf/BzFN9Z7LHbMitvu95XOQcO
 b1/IELpNtxuoplF+RGq3dXhg5D2yfVh49EW13w==
X-Google-Smtp-Source: ABdhPJxGk5zfowBhdNzlmIcozyf0G44SUP+GR2xq4nUFQfng/Qhw8aKoqsa/R6SQiIbmF4AWcENdwmFUI4y3kKdW2VM=
X-Received: by 2002:a54:4f89:: with SMTP id g9mr187632oiy.106.1602712979890;
 Wed, 14 Oct 2020 15:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-4-nsaenzjulienne@suse.de>
In-Reply-To: <20201014191211.27029-4-nsaenzjulienne@suse.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 14 Oct 2020 17:02:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
Message-ID: <CAL_JsqKMGSCTmKF2Lt8GQFx0DVFFH1bLVBw=bRDM7upahGvKDQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] of/address: Introduce of_dma_get_max_cpu_address()
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jeremy Linton <jeremy.linton@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Wed, Oct 14, 2020 at 2:12 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Introduce of_dma_get_max_cpu_address(), which provides the highest CPU
> physical address addressable by all DMA masters in the system. It's
> specially useful for setting memory zones sizes at early boot time.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Changes since v2:
>  - Use PHYS_ADDR_MAX
>  - return phys_dma_t
>  - Rename function
>  - Correct subject
>  - Add support to start parsing from an arbitrary device node in order
>    for the function to work with unit tests
>
>  drivers/of/address.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of.h   |  7 +++++++
>  2 files changed, 49 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index eb9ab4f1e80b..b5a9695aaf82 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -1024,6 +1024,48 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>  }
>  #endif /* CONFIG_HAS_DMA */
>
> +/**
> + * of_dma_get_max_cpu_address - Gets highest CPU address suitable for DMA
> + * @np: The node to start searching from or NULL to start from the root
> + *
> + * Gets the highest CPU physical address that is addressable by all DMA masters
> + * in the system (or subtree when np is non-NULL). If no DMA constrained device
> + * is found, it returns PHYS_ADDR_MAX.
> + */
> +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> +{
> +       phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;

One issue with using phys_addr_t is it may be 32-bit even though the
DT is 64-bit addresses. LPAE capable system with LPAE disabled. Maybe
the truncation is fine here? Maybe not.

> +       struct of_range_parser parser;
> +       phys_addr_t subtree_max_addr;
> +       struct device_node *child;
> +       phys_addr_t cpu_end = 0;
> +       struct of_range range;
> +       const __be32 *ranges;
> +       int len;
> +
> +       if (!np)
> +               np = of_root;
> +
> +       ranges = of_get_property(np, "dma-ranges", &len);

I'm not really following why you changed the algorithm here. You're
skipping disabled nodes which is good. Was there some other reason?

> +       if (ranges && len) {
> +               of_dma_range_parser_init(&parser, np);
> +               for_each_of_range(&parser, &range)
> +                       if (range.cpu_addr + range.size > cpu_end)
> +                               cpu_end = range.cpu_addr + range.size;
> +
> +               if (max_cpu_addr > cpu_end)
> +                       max_cpu_addr = cpu_end;
> +       }
> +
> +       for_each_available_child_of_node(np, child) {
> +               subtree_max_addr = of_dma_get_max_cpu_address(child);
> +               if (max_cpu_addr > subtree_max_addr)
> +                       max_cpu_addr = subtree_max_addr;
> +       }
> +
> +       return max_cpu_addr;
> +}
> +
>  /**
>   * of_dma_is_coherent - Check if device is coherent
>   * @np:        device node
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 481ec0467285..db8db8f2c967 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -558,6 +558,8 @@ int of_map_id(struct device_node *np, u32 id,
>                const char *map_name, const char *map_mask_name,
>                struct device_node **target, u32 *id_out);
>
> +phys_addr_t of_dma_get_max_cpu_address(struct device_node *np);
> +
>  #else /* CONFIG_OF */
>
>  static inline void of_core_init(void)
> @@ -995,6 +997,11 @@ static inline int of_map_id(struct device_node *np, u32 id,
>         return -EINVAL;
>  }
>
> +static inline phys_addr_t of_dma_get_max_cpu_address(struct device_node *np)
> +{
> +       return PHYS_ADDR_MAX;
> +}
> +
>  #define of_match_ptr(_ptr)     NULL
>  #define of_match_node(_matches, _node) NULL
>  #endif /* CONFIG_OF */
> --
> 2.28.0
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
