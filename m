Return-Path: <SRS0=q6Nl=V6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922B2C433FF
	for <iommu@archiver.kernel.org>; Fri,  2 Aug 2019 17:20:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69B2E21773
	for <iommu@archiver.kernel.org>; Fri,  2 Aug 2019 17:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhaum2PD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69B2E21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3C00D153D;
	Fri,  2 Aug 2019 17:20:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 411FD1498
	for <iommu@lists.linux-foundation.org>;
	Fri,  2 Aug 2019 17:17:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C475A7ED
	for <iommu@lists.linux-foundation.org>;
	Fri,  2 Aug 2019 17:17:39 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
	[209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 67D71217F5
	for <iommu@lists.linux-foundation.org>;
	Fri,  2 Aug 2019 17:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564766259;
	bh=5vmjMpiDWDoHbfIEjw2l5ptTIfiiyZTgBi7QK8QIoHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lhaum2PDzZjeWUO+WsAPOwKR/YgoXWAR0RXVBZYh5t5+PfmXONrVeQpGaqPVUFLNV
	zeDEVI0jHfexKJbsQD+EJtDab3k6iGED56EBhGxGJaIwBy9kSo1dYlZn9j/4qmkL4a
	R3PlUQKqZUXTeiEG8RYoleZ6v44K+IO5A8+pUoig=
Received: by mail-qk1-f181.google.com with SMTP id r4so55276846qkm.13
	for <iommu@lists.linux-foundation.org>;
	Fri, 02 Aug 2019 10:17:39 -0700 (PDT)
X-Gm-Message-State: APjAAAWR0Q+7Z4EcByE2M+rVs5hVr3vpLi50cjdt1sq8XvPVlAx2BjUv
	8xXmAZKEGlRoaBQC4ePPePLuAr8Fj8G3QJD2Ag==
X-Google-Smtp-Source: APXvYqxL5GHe5mkbUxAz7mbqxNvzn4pWJks7bPOqG/UgQKQwi7xLsLORGJlb/4eoiQbYIUPfkF/if0CjxqkRI+lgyvY=
X-Received: by 2002:a37:a48e:: with SMTP id
	n136mr93644586qke.223.1564766258476; 
	Fri, 02 Aug 2019 10:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190731154752.16557-1-nsaenzjulienne@suse.de>
	<20190731154752.16557-4-nsaenzjulienne@suse.de>
In-Reply-To: <20190731154752.16557-4-nsaenzjulienne@suse.de>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 2 Aug 2019 11:17:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKF5nh3hcdLTG5+6RU3_TnFrNX08vD6qZ8wawoA3WSRpA@mail.gmail.com>
Message-ID: <CAL_JsqKF5nh3hcdLTG5+6RU3_TnFrNX08vD6qZ8wawoA3WSRpA@mail.gmail.com>
Subject: Re: [PATCH 3/8] of/fdt: add function to get the SoC wide DMA
	addressable memory size
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: phill@raspberryi.org, devicetree@vger.kernel.org,
	"moderated list:BROADCOM BCM2835 ARM ARCHITECTURE"
	<linux-rpi-kernel@lists.infradead.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Frank Rowand <frowand.list@gmail.com>, Eric Anholt <eric@anholt.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-mm@kvack.org, Linux IOMMU <iommu@lists.linux-foundation.org>,
	Matthias Brugger <mbrugger@suse.com>, wahrenst@gmx.net,
	Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
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

On Wed, Jul 31, 2019 at 9:48 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Some SoCs might have multiple interconnects each with their own DMA
> addressing limitations. This function parses the 'dma-ranges' on each of
> them and tries to guess the maximum SoC wide DMA addressable memory
> size.
>
> This is specially useful for arch code in order to properly setup CMA
> and memory zones.

We already have a way to setup CMA in reserved-memory, so why is this
needed for that?

I have doubts this can really be generic...

>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>
>  drivers/of/fdt.c       | 72 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/of_fdt.h |  2 ++
>  2 files changed, 74 insertions(+)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 9cdf14b9aaab..f2444c61a136 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -953,6 +953,78 @@ int __init early_init_dt_scan_chosen_stdout(void)
>  }
>  #endif
>
> +/**
> + * early_init_dt_dma_zone_size - Look at all 'dma-ranges' and provide the
> + * maximum common dmable memory size.
> + *
> + * Some devices might have multiple interconnects each with their own DMA
> + * addressing limitations. For example the Raspberry Pi 4 has the following:
> + *
> + * soc {
> + *     dma-ranges = <0xc0000000  0x0 0x00000000  0x3c000000>;
> + *     [...]
> + * }
> + *
> + * v3dbus {
> + *     dma-ranges = <0x00000000  0x0 0x00000000  0x3c000000>;
> + *     [...]
> + * }
> + *
> + * scb {
> + *     dma-ranges = <0x0 0x00000000  0x0 0x00000000  0xfc000000>;
> + *     [...]
> + * }
> + *
> + * Here the area addressable by all devices is [0x00000000-0x3bffffff]. Hence
> + * the function will write in 'data' a size of 0x3c000000.
> + *
> + * Note that the implementation assumes all interconnects have the same physical
> + * memory view and that the mapping always start at the beginning of RAM.

Not really a valid assumption for general code.

> + */
> +int __init early_init_dt_dma_zone_size(unsigned long node, const char *uname,
> +                                      int depth, void *data)

Don't use the old fdt scanning interface with depth/data. It's not
really needed now because you can just use libfdt calls.

> +{
> +       const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +       u64 phys_addr, dma_addr, size;
> +       u64 *dma_zone_size = data;
> +       int dma_addr_cells;
> +       const __be32 *reg;
> +       const void *prop;
> +       int len;
> +
> +       if (depth == 0)
> +               *dma_zone_size = 0;
> +
> +       /*
> +        * We avoid pci host controllers as they have their own way of using
> +        * 'dma-ranges'.
> +        */
> +       if (type && !strcmp(type, "pci"))
> +               return 0;
> +
> +       reg = of_get_flat_dt_prop(node, "dma-ranges", &len);
> +       if (!reg)
> +               return 0;
> +
> +       prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
> +       if (prop)
> +               dma_addr_cells = be32_to_cpup(prop);
> +       else
> +               dma_addr_cells = 1; /* arm64's default addr_cell size */

Relying on the defaults has been a dtc error longer than arm64 has
existed. If they are missing, just bail.

> +
> +       if (len < (dma_addr_cells + dt_root_addr_cells + dt_root_size_cells))
> +               return 0;
> +
> +       dma_addr = dt_mem_next_cell(dma_addr_cells, &reg);
> +       phys_addr = dt_mem_next_cell(dt_root_addr_cells, &reg);
> +       size = dt_mem_next_cell(dt_root_size_cells, &reg);
> +
> +       if (!*dma_zone_size || *dma_zone_size > size)
> +               *dma_zone_size = size;
> +
> +       return 0;
> +}

It's possible to have multiple levels of nodes and dma-ranges. You
need to handle that case too.

Doing that and handling differing address translations will be
complicated. IMO, I'd just do:

if (of_fdt_machine_is_compatible(blob, "brcm,bcm2711"))
    dma_zone_size = XX;

2 lines of code is much easier to maintain than 10s of incomplete code
and is clearer who needs this. Maybe if we have dozens of SoCs with
this problem we should start parsing dma-ranges.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
