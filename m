Return-Path: <SRS0=2duP=DS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9621DC43457
	for <iommu@archiver.kernel.org>; Sun, 11 Oct 2020 07:47:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3703020759
	for <iommu@archiver.kernel.org>; Sun, 11 Oct 2020 07:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v/c/sPXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3703020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D51F78795A;
	Sun, 11 Oct 2020 07:47:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v8XeZPXnP7vH; Sun, 11 Oct 2020 07:47:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 16C0E87933;
	Sun, 11 Oct 2020 07:47:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E90C9C07FF;
	Sun, 11 Oct 2020 07:47:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54E36C0051
 for <iommu@lists.linux-foundation.org>; Sun, 11 Oct 2020 07:47:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4967987238
 for <iommu@lists.linux-foundation.org>; Sun, 11 Oct 2020 07:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SD3TJ5cvcMvG for <iommu@lists.linux-foundation.org>;
 Sun, 11 Oct 2020 07:47:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BC237871DB
 for <iommu@lists.linux-foundation.org>; Sun, 11 Oct 2020 07:47:18 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5326C2173E
 for <iommu@lists.linux-foundation.org>; Sun, 11 Oct 2020 07:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602402438;
 bh=LeMk4xJlrd34ez5NF8BLWNvKsm7wmDmT9qOElPmUWJE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=v/c/sPXgnEOq4jJilWSpg55W4tKtlomIYm1wAbddQ2HT95xbpKy1cqZuTe19B0HXa
 vXtH1ypj1myh2B5wxSb07CcHyn/W0XRokJ8BC/2+18WZAtTserlel3yq1lSoDlkCya
 siAgTAnuorrjI5JTy0j7BmFwcMGRtGYCNnXGXOu4=
Received: by mail-oi1-f173.google.com with SMTP id u17so15260605oie.3
 for <iommu@lists.linux-foundation.org>; Sun, 11 Oct 2020 00:47:18 -0700 (PDT)
X-Gm-Message-State: AOAM532y7uZyeNeVZfhFZ2eDCdmYcUuUUCDbgR7BGqTaGKLPrtlfdvTx
 qE5vq9cS4E9SUxwHFTXwIFaSMiUegeWXXP08n/A=
X-Google-Smtp-Source: ABdhPJzehloTufc7iRScDFdIAGd9rllMxSjs4e6a5wOBu7xWhcMoE7AB1Xcx7jsGo6uja6Hkh8/PgItFqPjyPS/T9s4=
X-Received: by 2002:aca:d845:: with SMTP id p66mr7029591oig.47.1602402437582; 
 Sun, 11 Oct 2020 00:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201010151235.20585-1-nsaenzjulienne@suse.de>
 <20201010151235.20585-3-nsaenzjulienne@suse.de>
In-Reply-To: <20201010151235.20585-3-nsaenzjulienne@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 11 Oct 2020 09:47:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF26z54XA-eMz76eJKuK1T8mZmDfibt+6SQw9bR=RFS_Q@mail.gmail.com>
Message-ID: <CAMj1kXF26z54XA-eMz76eJKuK1T8mZmDfibt+6SQw9bR=RFS_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] of/address: Introduce of_dma_lower_bus_limit()
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Robin Murphy <robin.murphy@arm.com>, Jeremy Linton <jeremy.linton@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, Frank Rowand <frowand.list@gmail.com>,
 Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Nicolas,

$SUBJECT is out of sync with the patch below. Also, for legibility, it
helps if the commit log is intelligible by itself, rather than relying
on $SUBJECT being the first line of the first paragraph.

On Sat, 10 Oct 2020 at 17:12, Nicolas Saenz Julienne
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

I don't think 'safe' strikes the right tone here. You are looking for
the highest CPU address that is addressable by all DMA masters in the
system.

Something like

of_dma_get_max_cpu_address(void)

perhaps? Also, since this is generic code, phys_addr_t is probably a
better type to return.


> +{
> +       struct device_node *np = NULL;
> +       struct of_range_parser parser;
> +       const __be32 *ranges = NULL;

I think you can drop these NULL initializers.

> +       u64 phys_dma_limit = ~0ULL;

PHYS_ADDR_MAX

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
