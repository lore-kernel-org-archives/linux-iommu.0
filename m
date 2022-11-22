Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56C17CA3
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 22:55:09 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-3a7081e3b95so54699677b3.1
        for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vgVj81TaAJFPaup6fEizR2CqkCcmP7+hjUnyLuec4+o=;
        b=RuJwiWKaa2cOkX9/h/pterDKBIAJDyCMl3Gr2uokUaHiSgUYf21FBwhwfxGjFmEaux
         DBrN6a5QhNaok28H5BUN4BDVZPpvBg2kKMmzDbJkI3dN14ygAuhbKzSGa7RHQSIYVb6J
         M26ETl80wMn5iENf8wxbk0Q+FoFB6tTXpvTjNWzl5v1R5ed7nRKbE/JX3ORhTe5mVAJX
         FM9+59F9ZllVPLSRCp4yncMNAebZy8+1gwc+2Hg99EJhj9XIegPAVWMNOhNhYbwjRzXm
         vci4H/4bdTkf3ixODqhpo65YzIV0aiMt9txB6cEo61dfu7HSU17O1o0AqK/FzDJa+1eI
         sxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgVj81TaAJFPaup6fEizR2CqkCcmP7+hjUnyLuec4+o=;
        b=RIj7v+AP/YudLnjgIiERIiY0w7sjU8I4os4Tn118nzRkoqHbT3GyuBwIK8FsBQBzaq
         mnTvN13qHElpQ5IoP8nxEaxRYsldf39xGU2RCZT24BaG4TRpQ6dIFSsuaCqn5T66XF9n
         k4cOIJnU8myr80jdVymSRh0g8nRjlki8heY4AqDgL51IvfvtArHwxhkic/K11FHiCeoA
         U6N7Y8sYT50rELX6pBBUMZ8T4W+AguyEo0JIg6lhpDzEJPh/FK82bxsn7RgRnTWXiXMF
         4XyDurIypbVoc7a2e4Wsn90eETcQpwUe0ME2dXYVbh0OXJ2SovFuFtLPwawZwKGJlOj1
         gwqA==
X-Gm-Message-State: ANoB5pkmOa2PP961NWJ+r7u6/dMy8KZZd/qbmTOFy4GPZZfjixlLJgQf
	Mq4KhHTxqxI00EAIaWjNwY2tAbpIWVMxTYXNzbqxPg==
X-Google-Smtp-Source: AA0mqf5lWYRbouY3wvSyTTHF5VwEyw1ykqzKm2VlVp0D1XBZHCXBRTzTAdT5ZyzQLfVztmPc7a+6n8h/U/Z8cXwlc/M=
X-Received: by 2002:a81:5f04:0:b0:393:ab0b:5a31 with SMTP id
 t4-20020a815f04000000b00393ab0b5a31mr22706109ywb.55.1669157708673; Tue, 22
 Nov 2022 14:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221112040452.644234-1-edumazet@google.com> <Y30gZm0mO4YNO85d@localhost.localdomain>
In-Reply-To: <Y30gZm0mO4YNO85d@localhost.localdomain>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Nov 2022 14:54:57 -0800
Message-ID: <CANn89iL-hGPeaTzCibdaOoquAQYNYa8Fu337tqu98xyoZWarOQ@mail.gmail.com>
Subject: Re: [PATCH -next] iommu/dma: avoid expensive indirect calls for sync operations
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, iommu@lists.linux.dev, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 22, 2022 at 11:18 AM Michal Kubiak <michal.kubiak@intel.com> wrote:
>
> On Sat, Nov 12, 2022 at 04:04:52AM +0000, Eric Dumazet wrote:
> > Quite often, NIC devices do not need dma_sync operations
> > on x86_64 at least.
> >
> > Indeed, when dev_is_dma_coherent(dev) is true and
> > dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
> > and friends do nothing.
> >
> > However, indirectly calling them when CONFIG_RETPOLINE=y
> > consumes about 10% of cycles on a cpu receiving packets
> > from softirq at ~100Gbit rate, as shown in [1]
> >
> > Even if/when CONFIG_RETPOLINE is not set, there
> > is a cost of about 3%.
> >
> > This patch adds a copy of iommu_dma_ops structure,
> > where sync_single_for_cpu, sync_single_for_device,
> > sync_sg_for_cpu and sync_sg_for_device are unset.
>
>
> Larysa from our team has found out this patch introduces also a
> functional improvement for batch allocation in AF_XDP while iommmu is
> turned on.
> In 'xp_alloc_batch()' function there is a check if DMA needs a
> synchronization. If so, batch allocation is not supported and we can
> allocate only one buffer at a time.
>
> The flag 'dma_need_sync' is being set according to the value returned by
> the function 'dma_need_sync()' (from '/kernel/dma/mapping.c').
> That function only checks if at least one of two DMA ops is defined:
> 'ops->sync_single_for_cpu' or 'ops->sync_single_for_device'.
>
> > +static const struct dma_map_ops iommu_nosync_dma_ops = {
> > +     iommu_dma_ops_common_fields
> > +
> > +     .sync_single_for_cpu    = NULL,
> > +     .sync_single_for_device = NULL,
> > +     .sync_sg_for_cpu        = NULL,
> > +     .sync_sg_for_device     = NULL,
> > +};
> > +#undef iommu_dma_ops_common_fields
> > +
> >  /*
> >   * The IOMMU core code allocates the default DMA domain, which the underlying
> >   * IOMMU driver needs to support via the dma-iommu layer.
> > @@ -1586,7 +1612,8 @@ void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit)
> >       if (iommu_is_dma_domain(domain)) {
> >               if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
> >                       goto out_err;
> > -             dev->dma_ops = &iommu_dma_ops;
> > +             dev->dma_ops = dev_is_dma_sync_needed(dev) ?
> > +                             &iommu_dma_ops : &iommu_nosync_dma_ops;
> >       }
> >
> >       return;
>
>  This code removes defining 'sync_*' DMA ops if they are not actually
>  used. Thanks to that improvement the function 'dma_need_sync()' will
>  always return more meaningful information if any DMA synchronization is
>  actually needed for iommu.
>
>  Together with Larysa we have applied that patch and we can confirm it
>  helps for batch buffer allocation in AF_XDP ('xsk_buff_alloc_batch()'
>  call) when iommu is enabled.

Thanks for testing !

I am quite busy relocating, I will address Christoph feedback next week.
