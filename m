Return-Path: <SRS0=IUlV=GR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CAAC433DB
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 09:08:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CB6239FF
	for <iommu@archiver.kernel.org>; Thu, 14 Jan 2021 09:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CB6239FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D41542047B;
	Thu, 14 Jan 2021 09:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JHgf-QLf46Ar; Thu, 14 Jan 2021 09:08:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6BCFB20463;
	Thu, 14 Jan 2021 09:08:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 475D7C088B;
	Thu, 14 Jan 2021 09:08:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A24F2C013A
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:08:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1A7DC85CB4
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:08:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CFvOgrOAa8Bg for <iommu@lists.linux-foundation.org>;
 Thu, 14 Jan 2021 09:08:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com
 [209.85.166.48])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B955786A91
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 09:08:38 +0000 (UTC)
Received: by mail-io1-f48.google.com with SMTP id d13so6550291ioy.4
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XoX/j54i0jG8qEsxZKby76Lqj61QzippjPHzsTsj+5Y=;
 b=nY1GnsLlZi0Sxxm+zSGIGaqKpSxx6JueftrzPps7oTAcG91/bM9YfHLXW3YxSFcLzK
 y6cH1olpZ/FXA0Mp0cE9+mqoheJMPU0KT0091/GVtf67wUxU6MGGIWncH2X6oPgNN5KO
 QvrKMhyV8u8UB5lLj67P7d++Su0Uyq/z5gAtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XoX/j54i0jG8qEsxZKby76Lqj61QzippjPHzsTsj+5Y=;
 b=cPScGFliE4vWE2F3okpoGruQuagHGA/jvBIDINJjgn7nv3D8Z0Y89lXCpWlvCjuJ3Y
 VAR+tNp/RxAEDE4eILSzaOHxVTkF8YSabR0nlRCC92JHZdtIoL9NSR+Q1yO8MCssIr6G
 4Ysls8mNx4E2QeHkjBazIeg5mjGM/gYWIgKhzu5A5gNe0MjKD/ZwvF1RiubZmwfpYQvW
 50jl9eg/UuDrB/JjEVwEXszljBWEj6Tg9dNcC8s0Y1SQ4TTJ2sbJInD0wM+XV+wV5LqS
 /LvuyDKsOrUObldRyMpSG4KcoqpSOw7qx+/P4GnLbOiHgTnxVkydT71BzVxtl8B3qrST
 k6kA==
X-Gm-Message-State: AOAM5303OwDKY7YTh+ogI1MGXqMPeupCzuG1xRSI5eyBAcLjW34eYA80
 Aw+sydOs6awpIzr+5XSjuHUJQVThjh0b6w==
X-Google-Smtp-Source: ABdhPJz+9e+gcLfyPTEzwLSSLj+QY9XXi/hBZ8cqwSwRwIMTjC7Szv8vhE38eDOwRZksK2LwZnef9g==
X-Received: by 2002:a05:6638:164c:: with SMTP id
 a12mr5629631jat.128.1610615317701; 
 Thu, 14 Jan 2021 01:08:37 -0800 (PST)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com.
 [209.85.166.46])
 by smtp.gmail.com with ESMTPSA id q5sm3230714ilg.62.2021.01.14.01.08.36
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 01:08:36 -0800 (PST)
Received: by mail-io1-f46.google.com with SMTP id b19so7242441ioa.9
 for <iommu@lists.linux-foundation.org>; Thu, 14 Jan 2021 01:08:36 -0800 (PST)
X-Received: by 2002:a92:c206:: with SMTP id j6mr5789564ilo.189.1610615314989; 
 Thu, 14 Jan 2021 01:08:34 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <20210106034124.30560-7-tientzu@chromium.org>
 <95e6dd76-5e18-e445-c351-19fba18f36de@gmail.com>
In-Reply-To: <95e6dd76-5e18-e445-c351-19fba18f36de@gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Thu, 14 Jan 2021 17:08:24 +0800
X-Gmail-Original-Message-ID: <CALiNf29+8Yi93RacsZHr=qYBhQRwqujW6KZVVD=9xPMhpLH5pA@mail.gmail.com>
Message-ID: <CALiNf29+8Yi93RacsZHr=qYBhQRwqujW6KZVVD=9xPMhpLH5pA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/6] of: Add plumbing for restricted DMA pool
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, rafael.j.wysocki@intel.com, Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, will@kernel.org,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 rdunlap@infradead.org, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 xypron.glpk@gmx.de, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Jan 13, 2021 at 7:48 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/5/21 7:41 PM, Claire Chang wrote:
> > If a device is not behind an IOMMU, we look up the device node and set
> > up the restricted DMA when the restricted-dma-pool is presented.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
>
> [snip]
>
> > +int of_dma_set_restricted_buffer(struct device *dev)
> > +{
> > +     struct device_node *node;
> > +     int count, i;
> > +
> > +     if (!dev->of_node)
> > +             return 0;
> > +
> > +     count = of_property_count_elems_of_size(dev->of_node, "memory-region",
> > +                                             sizeof(phandle));
>
> You could have an early check for count < 0, along with an error
> message, if that is deemed useful.
>
> > +     for (i = 0; i < count; i++) {
> > +             node = of_parse_phandle(dev->of_node, "memory-region", i);
> > +             if (of_device_is_compatible(node, "restricted-dma-pool"))
>
> And you may want to add here an of_device_is_available(node). A platform
> that provides the Device Tree firmware and try to support multiple
> different SoCs may try to determine if an IOMMU is present, and if it
> is, it could be marking the restriced-dma-pool region with a 'status =
> "disabled"' property, or any variant of that scheme.

This function is called only when there is no IOMMU present (check in
drivers/of/device.c). I can still add of_device_is_available(node)
here if you think it's helpful.

>
> > +                     return of_reserved_mem_device_init_by_idx(
> > +                             dev, dev->of_node, i);
>
> This does not seem to be supporting more than one memory region, did not
> you want something like instead:
>
>                 ret = of_reserved_mem_device_init_by_idx(...);
>                 if (ret)
>                         return ret;
>

Yes. This implement only supports one restriced-dma-pool memory region
with the assumption that there is only one memory region with the
compatible string, restricted-dma-pool, in the dts. IIUC, it's similar
to shared-dma-pool.


> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index aedfaaafd3e7..e2c7409956ab 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -182,6 +182,10 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
> >       arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> >
> >       dev->dma_range_map = map;
> > +
> > +     if (!iommu)
> > +             return of_dma_set_restricted_buffer(dev);
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> > diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> > index d9e6a324de0a..28a2dfa197ba 100644
> > --- a/drivers/of/of_private.h
> > +++ b/drivers/of/of_private.h
> > @@ -161,12 +161,17 @@ struct bus_dma_region;
> >  #if defined(CONFIG_OF_ADDRESS) && defined(CONFIG_HAS_DMA)
> >  int of_dma_get_range(struct device_node *np,
> >               const struct bus_dma_region **map);
> > +int of_dma_set_restricted_buffer(struct device *dev);
> >  #else
> >  static inline int of_dma_get_range(struct device_node *np,
> >               const struct bus_dma_region **map)
> >  {
> >       return -ENODEV;
> >  }
> > +static inline int of_dma_get_restricted_buffer(struct device *dev)
> > +{
> > +     return -ENODEV;
> > +}
> >  #endif
> >
> >  #endif /* _LINUX_OF_PRIVATE_H */
> >
>
>
> --
> Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
