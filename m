Return-Path: <SRS0=at/m=D5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE35C388F2
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 12:23:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC183221FB
	for <iommu@archiver.kernel.org>; Thu, 22 Oct 2020 12:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qojjYkQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC183221FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2DD6D8710D;
	Thu, 22 Oct 2020 12:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hypEgs2kerRP; Thu, 22 Oct 2020 12:23:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5B90E86C90;
	Thu, 22 Oct 2020 12:23:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43C33C0052;
	Thu, 22 Oct 2020 12:23:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A3D1C0051
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 12:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 42DDC8700F
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 12:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V90c2vaIX9hx for <iommu@lists.linux-foundation.org>;
 Thu, 22 Oct 2020 12:23:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6F67F87009
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 12:23:49 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B83C5223FB
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603369428;
 bh=gFUO9/jr1NGmcSup6f9HJPZXgJ9BgTXZE7zsdNPQVi4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qojjYkQq8wwxNEyfqUP8JGvud2JfsDcJi5zR36v9o7gMAdlAGWQZO82j20Lc6U1vB
 Eh3BRLTVoQht2Ac4xpSlY1mj/1iE+ijLKk25xArVkm5R1fWJfXJSjKiE3R10CAuQFS
 LTuvM04QGXciadqYm9iswhMC638pc2oy1rUaLyzw=
Received: by mail-ot1-f53.google.com with SMTP id m22so1290650ots.4
 for <iommu@lists.linux-foundation.org>; Thu, 22 Oct 2020 05:23:48 -0700 (PDT)
X-Gm-Message-State: AOAM530SPBRV8lx3MvZfFYZT7SHwBxhch6NdMsdRS36UnolrqqzlGiiC
 sHvj4OHg2QsM8Ig6mwAeWCO/Yx3vuE0gBymg87s=
X-Google-Smtp-Source: ABdhPJxt9LSXVEywyIzGmHFLorZcX5jGT+8e1UeINkXR1Ln9Mj13c0gwDJmF9PMI6zWnbKCdusuBtu5X8LYczt2JBns=
X-Received: by 2002:a9d:6c92:: with SMTP id c18mr1604110otr.108.1603369427884; 
 Thu, 22 Oct 2020 05:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
 <20201021123437.21538-4-nsaenzjulienne@suse.de>
In-Reply-To: <20201021123437.21538-4-nsaenzjulienne@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 Oct 2020 14:23:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEV846XaZWGFmmq4-1UQBb3kw+E_xQf7tGZG7=wQp9xUQ@mail.gmail.com>
Message-ID: <CAMj1kXEV846XaZWGFmmq4-1UQBb3kw+E_xQf7tGZG7=wQp9xUQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] of/address: Introduce of_dma_get_max_cpu_address()
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>, Hanjun Guo <guohanjun@huawei.com>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
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

On Wed, 21 Oct 2020 at 14:35, Nicolas Saenz Julienne
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
> Changes since v3:
>  - use u64 with cpu_end
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
> index eb9ab4f1e80b..47dfe5881e18 100644
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
> + * in the sub-tree pointed by np, or the whole tree if NULL is passed. If no
> + * DMA constrained device is found, it returns PHYS_ADDR_MAX.
> + */
> +phys_addr_t __init of_dma_get_max_cpu_address(struct device_node *np)
> +{
> +       phys_addr_t max_cpu_addr = PHYS_ADDR_MAX;
> +       struct of_range_parser parser;
> +       phys_addr_t subtree_max_addr;
> +       struct device_node *child;
> +       struct of_range range;
> +       const __be32 *ranges;
> +       u64 cpu_end = 0;
> +       int len;
> +
> +       if (!np)
> +               np = of_root;
> +
> +       ranges = of_get_property(np, "dma-ranges", &len);
> +       if (ranges && len) {
> +               of_dma_range_parser_init(&parser, np);
> +               for_each_of_range(&parser, &range)
> +                       if (range.cpu_addr + range.size > cpu_end)
> +                               cpu_end = range.cpu_addr + range.size;

Shouldn't this be 'range.cpu_addr + range.size - 1' ?

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
