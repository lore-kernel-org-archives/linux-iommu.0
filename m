Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B18EC433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 02:53:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA381613DB
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 02:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA381613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 623B6843E3;
	Fri, 23 Apr 2021 02:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5-M6hrt15VzL; Fri, 23 Apr 2021 02:53:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 513F88438E;
	Fri, 23 Apr 2021 02:53:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24EFDC000F;
	Fri, 23 Apr 2021 02:53:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A843C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 02:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CFD8843B5
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 02:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mV05kHLx1GMi for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 02:53:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 526228438E
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 02:53:12 +0000 (UTC)
Received: by mail-il1-x129.google.com with SMTP id r5so940383ilb.2
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 19:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=40nhsz+kltJTf7tq6pLLkes92lT1dy5Rll207DlKzWM=;
 b=HdsQJQRkixDre+dpQSVR58nl8K7T4MbrI4XmlnSivkYb875qGKmhwngqhS/XX43exh
 bg5Ne9Oub0puKLH8FRaSSn/FCuQxwpgf1ynisAFuTF4Wvjhe+t5iF+WotV6g96hB8Oro
 fWaQA0hAXWZxawu4WTORJsnwcVbFEg+0cCZO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=40nhsz+kltJTf7tq6pLLkes92lT1dy5Rll207DlKzWM=;
 b=MxxhHGJ9Xu3G4ykFs1uf2acFIctyj4J1gXjXgMbQk1PO6BfVrCQtDXzJVdlKYTs2rM
 5Bw8R736Ygj4CJQNvO7Lm/edOR6AV5dHft6e1Nmn5RG/leVmvD1IGLdCJJSB3nRvyefm
 ALiSG02KCC2RDUqKrEku0YhAxzyd5mi0JMFSX4pwB+D+QfNLj33Z2RLhCiDHRyZYQeEz
 vyspaCJ8yqmPGJJknef/72IBYZ3WtChV36qlMyd8w8vh/XyaO1xzPvfikaUg2saxcOmF
 vumcAV4NY9AiSKQDiHzQIZ+uL4sT3L2UyZ115V1qX26o1gjjY54A8jeJHhmcHRljFJ/g
 hZLw==
X-Gm-Message-State: AOAM531KQXlhAwnYB11gj7tISmS+hiW9ttuQiXH7seuJYx39PHNDVChY
 YbjuUSRELtYGyefOBNIyLVS+YLtmKdmUkQ==
X-Google-Smtp-Source: ABdhPJwVR/56B8kK2AZh1LVSig4ozKmTXOXm9lKjQpncSPNsnuKgFxL3neZdTJNhh7eXBpanlYoJXw==
X-Received: by 2002:a92:cf50:: with SMTP id c16mr1259773ilr.2.1619146390998;
 Thu, 22 Apr 2021 19:53:10 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com.
 [209.85.166.51])
 by smtp.gmail.com with ESMTPSA id f1sm1938655ilu.46.2021.04.22.19.53.09
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Apr 2021 19:53:10 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id v123so40742959ioe.10
 for <iommu@lists.linux-foundation.org>; Thu, 22 Apr 2021 19:53:09 -0700 (PDT)
X-Received: by 2002:a6b:c913:: with SMTP id z19mr1627785iof.50.1619146389385; 
 Thu, 22 Apr 2021 19:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210422081508.3942748-1-tientzu@chromium.org>
 <20210422081508.3942748-17-tientzu@chromium.org>
In-Reply-To: <20210422081508.3942748-17-tientzu@chromium.org>
From: Claire Chang <tientzu@chromium.org>
Date: Fri, 23 Apr 2021 10:52:58 +0800
X-Gmail-Original-Message-ID: <CALiNf29NzRTRB-0JbCL7=0qF0SAiER_pJ_-SCtVRA7DHCsSpEg@mail.gmail.com>
Message-ID: <CALiNf29NzRTRB-0JbCL7=0qF0SAiER_pJ_-SCtVRA7DHCsSpEg@mail.gmail.com>
Subject: Re: [PATCH v5 16/16] of: Add plumbing for restricted DMA pool
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
 boris.ostrovsky@oracle.com, jgross@suse.com, Christoph Hellwig <hch@lst.de>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
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
 nouveau@lists.freedesktop.org, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
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

On Thu, Apr 22, 2021 at 4:17 PM Claire Chang <tientzu@chromium.org> wrote:
>
> If a device is not behind an IOMMU, we look up the device node and set
> up the restricted DMA when the restricted-dma-pool is presented.
>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  drivers/of/address.c    | 25 +++++++++++++++++++++++++
>  drivers/of/device.c     |  3 +++
>  drivers/of/of_private.h |  5 +++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index 54f221dde267..fff3adfe4986 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -8,6 +8,7 @@
>  #include <linux/logic_pio.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/pci.h>
>  #include <linux/pci_regs.h>
>  #include <linux/sizes.h>
> @@ -1109,6 +1110,30 @@ bool of_dma_is_coherent(struct device_node *np)
>  }
>  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
>
> +int of_dma_set_restricted_buffer(struct device *dev)
> +{
> +       struct device_node *node;
> +       int count, i;
> +
> +       if (!dev->of_node)
> +               return 0;
> +
> +       count = of_property_count_elems_of_size(dev->of_node, "memory-region",
> +                                               sizeof(phandle));
> +       for (i = 0; i < count; i++) {
> +               node = of_parse_phandle(dev->of_node, "memory-region", i);
> +               /* There might be multiple memory regions, but only one
> +                * restriced-dma-pool region is allowed.
> +                */
> +               if (of_device_is_compatible(node, "restricted-dma-pool") &&
> +                   of_device_is_available(node))
> +                       return of_reserved_mem_device_init_by_idx(
> +                               dev, dev->of_node, i);
> +       }
> +
> +       return 0;
> +}
> +
>  /**
>   * of_mmio_is_nonposted - Check if device uses non-posted MMIO
>   * @np:        device node
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index c5a9473a5fb1..d8d865223e51 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -165,6 +165,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>
>         arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>
> +       if (!iommu)
> +               return of_dma_set_restricted_buffer(dev);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index d717efbd637d..e9237f5eff48 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -163,12 +163,17 @@ struct bus_dma_region;
>  #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
>  int of_dma_get_range(struct device_node *np,
>                 const struct bus_dma_region **map);
> +int of_dma_set_restricted_buffer(struct device *dev);
>  #else
>  static inline int of_dma_get_range(struct device_node *np,
>                 const struct bus_dma_region **map)
>  {
>         return -ENODEV;
>  }
> +static inline int of_dma_get_restricted_buffer(struct device *dev)

This one should be of_dma_set_restricted_buffer. Sorry for the typo.

> +{
> +       return -ENODEV;
> +}
>  #endif
>
>  #endif /* _LINUX_OF_PRIVATE_H */
> --
> 2.31.1.368.gbe11c130af-goog
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
