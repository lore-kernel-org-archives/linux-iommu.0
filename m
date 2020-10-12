Return-Path: <SRS0=a71q=DT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD5C433DF
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 15:25:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1F65208B8
	for <iommu@archiver.kernel.org>; Mon, 12 Oct 2020 15:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxZf4iW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1F65208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 992AF86E03;
	Mon, 12 Oct 2020 15:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0dcGI7WbScKQ; Mon, 12 Oct 2020 15:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C56F786E00;
	Mon, 12 Oct 2020 15:25:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDDD3C0893;
	Mon, 12 Oct 2020 15:25:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B211BC0052
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 15:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8F57A875DA
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 15:25:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VumUImFM+fIb for <iommu@lists.linux-foundation.org>;
 Mon, 12 Oct 2020 15:25:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BDC04873D5
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 15:25:24 +0000 (UTC)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 31C9F208B8
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602516324;
 bh=bIkKTbcUZtX9LoLNwSifZfSlJSm+lTIbvj8ANEPWg+E=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=uxZf4iW79VnNA5czZ7+lfYfL5mZh/NTtQp8P1PUO/mrWTeniv1u3OVK8c7bMYmXVw
 wU947G/HociXcrlo7OV167y6SyyB9Lqora51+m25lwRLW/rlQgarEnehXa9R0cIao6
 JNo23nmkZcwJ70/WjKMzFieZygaW1q7ZDG+w2wzU=
Received: by mail-ot1-f48.google.com with SMTP id f37so16106251otf.12
 for <iommu@lists.linux-foundation.org>; Mon, 12 Oct 2020 08:25:24 -0700 (PDT)
X-Gm-Message-State: AOAM532P1oBMWn5Ic1jia2/ckIgQftELesxCuzBr09HLGuGWRdHKCxH9
 BQNGFjr4qoKZUaiZTR3RfNwyj1mu/YPfWS3ltw==
X-Google-Smtp-Source: ABdhPJzn/48d6MtUs58/VlMn2lXXGtFdr5KMFZ9WLc1IRZmoznfmeWfNkAM04VmTyhwnzuvsMRlIu9LYOOnGR3XI80o=
X-Received: by 2002:a9d:7993:: with SMTP id h19mr15487657otm.129.1602516323477; 
 Mon, 12 Oct 2020 08:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
 <20201010151235.20585-3-nsaenzjulienne@suse.de>
In-Reply-To: <20201010151235.20585-3-nsaenzjulienne@suse.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 12 Oct 2020 10:25:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL2cs+cko-UuTd37fnBKO_=3jQeyjB49USvm_VTBwcS8g@mail.gmail.com>
Message-ID: <CAL_JsqL2cs+cko-UuTd37fnBKO_=3jQeyjB49USvm_VTBwcS8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] of/address: Introduce of_dma_lower_bus_limit()
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

On Sat, Oct 10, 2020 at 10:12 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> The function provides the CPU physical address addressable by the most
> constrained bus in the system. It might be useful in order to
> dynamically set up memory zones during boot.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/of/address.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/of.h   |  7 +++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index eb9ab4f1e80b..755e97b65096 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -1024,6 +1024,40 @@ int of_dma_get_range(struct device_node *np, const struct bus_dma_region **map)
>  }
>  #endif /* CONFIG_HAS_DMA */
>
> +/**
> + * of_dma_safe_phys_limit - Get system wide DMA safe address space
> + *
> + * Gets the CPU physical address limit for safe DMA addressing system wide by
> + * searching for the most constraining dma-range. Otherwise it returns ~0ULL.
> + */
> +u64 __init of_dma_safe_phys_limit(void)
> +{
> +       struct device_node *np = NULL;
> +       struct of_range_parser parser;
> +       const __be32 *ranges = NULL;
> +       u64 phys_dma_limit = ~0ULL;
> +       struct of_range range;
> +       int len;
> +
> +       for_each_of_allnodes(np) {
> +               dma_addr_t cpu_end = 0;
> +
> +               ranges = of_get_property(np, "dma-ranges", &len);
> +               if (!ranges || !len)
> +                       continue;
> +
> +               of_dma_range_parser_init(&parser, np);
> +               for_each_of_range(&parser, &range)
> +                       if (range.cpu_addr + range.size > cpu_end)
> +                               cpu_end = range.cpu_addr + range.size;

This doesn't work if you have more than one level of dma-ranges. The
address has to be translated first. It should be okay to do that on
the start or end address (if not, your DT is broken).

Please add/extend a unittest for this.

> +
> +               if (phys_dma_limit > cpu_end)
> +                       phys_dma_limit = cpu_end;
> +       }
> +
> +       return phys_dma_limit;
> +}
> +
>  /**
>   * of_dma_is_coherent - Check if device is coherent
>   * @np:        device node
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 481ec0467285..958c64cffa92 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -558,6 +558,8 @@ int of_map_id(struct device_node *np, u32 id,
>                const char *map_name, const char *map_mask_name,
>                struct device_node **target, u32 *id_out);
>
> +u64 of_dma_safe_phys_limit(void);
> +
>  #else /* CONFIG_OF */
>
>  static inline void of_core_init(void)
> @@ -995,6 +997,11 @@ static inline int of_map_id(struct device_node *np, u32 id,
>         return -EINVAL;
>  }
>
> +static inline u64 of_dma_safe_phys_limit(void)
> +{
> +       return ~0ULL;
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
