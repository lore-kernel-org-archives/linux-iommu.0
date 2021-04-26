Return-Path: <SRS0=8mM2=JX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61594C433ED
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 16:38:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D531C6103E
	for <iommu@archiver.kernel.org>; Mon, 26 Apr 2021 16:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D531C6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7738F4029B;
	Mon, 26 Apr 2021 16:38:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0EJapgF1soEc; Mon, 26 Apr 2021 16:38:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EFFE40285;
	Mon, 26 Apr 2021 16:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E67CC000F;
	Mon, 26 Apr 2021 16:38:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54510C000B
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 16:38:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 41E8D6061E
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 16:38:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jg-X238qoxh1 for <iommu@lists.linux-foundation.org>;
 Mon, 26 Apr 2021 16:38:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66140606C6
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 16:38:03 +0000 (UTC)
Received: by mail-io1-xd2a.google.com with SMTP id f21so20492768ioh.8
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cFKXKq/sKurvSVgvNvGkxgOiMlOZ5bG92GQyZxG6/Ow=;
 b=hQyrvIvY0OkwlUkO65L/o3TMJboyrA/EOLuUe0Pq7KgqeFtR8O9LJWrjeU2EQISYlu
 bJHPBsPqEo2jNERM7Qly7inrbryADiFPyU5whSnn5mfATXbgH1UnC4GjWrov7E7itgl/
 y/vmAUUGiGEmxu0IFynSQLccMWdifgG50rRhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cFKXKq/sKurvSVgvNvGkxgOiMlOZ5bG92GQyZxG6/Ow=;
 b=LtSBmo1FKKnofVPxGeLbi6XYpo7RnKraGdioxQoKFELIooLFDrs/XJOZ5Y741nQchR
 zPFbSrOXVZLJCBp56cVq9ON96FMgjasW8qL4oBEfqnn+gqCjjk3xNMqs3evibCp3+ZRn
 ZzPAgU2NSL2PFdMgYwA5027RvuFMr3sYFqsII9stJSpPYa5UWBDzvXm1VOBjwdxlsXHD
 HCmcBGotGTNKDIZ2vWAFBxI/xMAldz0JgD+mXbBs2Ad2VwgKrhdGedYsAHfMtWCkrBJl
 akWUF0gyY15yhnnjl6uQNHWayJY5uWtVuczz9dPpX3HSOaj7IlMyZmUL0qbdtBOWIKXS
 zc4Q==
X-Gm-Message-State: AOAM532YBmBR6zd3PTIJoELwL9HwBY8rdk6NGlr5yhqBIPfX/m08b98S
 BtRxbAdK1skrjE9R4MGJnZxkQ1aYNsb4IA==
X-Google-Smtp-Source: ABdhPJzU7IHBA3iYvAg+C9t9EUFOdYHponmYpjW0sGqW9jZQa3wEb3Ew5ehuLU1K/bVmMHxbRUnCaw==
X-Received: by 2002:a02:818b:: with SMTP id n11mr17608378jag.62.1619455081152; 
 Mon, 26 Apr 2021 09:38:01 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com.
 [209.85.166.173])
 by smtp.gmail.com with ESMTPSA id a8sm7889643iod.4.2021.04.26.09.37.58
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Apr 2021 09:37:58 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id r5so6917248ilb.2
 for <iommu@lists.linux-foundation.org>; Mon, 26 Apr 2021 09:37:58 -0700 (PDT)
X-Received: by 2002:a92:7307:: with SMTP id o7mr14655769ilc.5.1619455077553;
 Mon, 26 Apr 2021 09:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210422081508.3942748-1-tientzu@chromium.org>
 <20210422081508.3942748-9-tientzu@chromium.org>
 <1f84aa4c-f966-0986-b5a4-eecbf3b454ec@arm.com>
In-Reply-To: <1f84aa4c-f966-0986-b5a4-eecbf3b454ec@arm.com>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 27 Apr 2021 00:37:46 +0800
X-Gmail-Original-Message-ID: <CALiNf29N3U5GZKNN90NzjSeQ0WG4dxyRzU97fJ-r9OuChzLWKA@mail.gmail.com>
Message-ID: <CALiNf29N3U5GZKNN90NzjSeQ0WG4dxyRzU97fJ-r9OuChzLWKA@mail.gmail.com>
Subject: Re: [PATCH v5 08/16] swiotlb: Update is_swiotlb_active to add a
 struct device argument
To: Robin Murphy <robin.murphy@arm.com>
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 lkml <linux-kernel@vger.kernel.org>, grant.likely@arm.com, paulus@samba.org,
 Will Deacon <will@kernel.org>, mingo@kernel.org, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 Jianxiong Gao <jxgao@google.com>, Daniel Vetter <daniel@ffwll.ch>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, jani.nikula@linux.intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, rodrigo.vivi@intel.com,
 Bjorn Helgaas <bhelgaas@google.com>, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 chris@chris-wilson.co.uk, nouveau@lists.freedesktop.org,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, linuxppc-dev@lists.ozlabs.org,
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

On Fri, Apr 23, 2021 at 9:31 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-04-22 09:15, Claire Chang wrote:
> > Update is_swiotlb_active to add a struct device argument. This will be
> > useful later to allow for restricted DMA pool.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >   drivers/gpu/drm/i915/gem/i915_gem_internal.c | 2 +-
> >   drivers/gpu/drm/nouveau/nouveau_ttm.c        | 2 +-
> >   drivers/pci/xen-pcifront.c                   | 2 +-
> >   include/linux/swiotlb.h                      | 4 ++--
> >   kernel/dma/direct.c                          | 2 +-
> >   kernel/dma/swiotlb.c                         | 4 ++--
> >   6 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> > index ce6b664b10aa..7d48c433446b 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> > @@ -42,7 +42,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
> >
> >       max_order = MAX_ORDER;
> >   #ifdef CONFIG_SWIOTLB
> > -     if (is_swiotlb_active()) {
> > +     if (is_swiotlb_active(NULL)) {
> >               unsigned int max_segment;
> >
> >               max_segment = swiotlb_max_segment();
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> > index e8b506a6685b..2a2ae6d6cf6d 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> > @@ -321,7 +321,7 @@ nouveau_ttm_init(struct nouveau_drm *drm)
> >       }
> >
> >   #if IS_ENABLED(CONFIG_SWIOTLB) && IS_ENABLED(CONFIG_X86)
> > -     need_swiotlb = is_swiotlb_active();
> > +     need_swiotlb = is_swiotlb_active(NULL);
> >   #endif
> >
> >       ret = ttm_device_init(&drm->ttm.bdev, &nouveau_bo_driver, drm->dev->dev,
> > diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> > index b7a8f3a1921f..6d548ce53ce7 100644
> > --- a/drivers/pci/xen-pcifront.c
> > +++ b/drivers/pci/xen-pcifront.c
> > @@ -693,7 +693,7 @@ static int pcifront_connect_and_init_dma(struct pcifront_device *pdev)
> >
> >       spin_unlock(&pcifront_dev_lock);
> >
> > -     if (!err && !is_swiotlb_active()) {
> > +     if (!err && !is_swiotlb_active(NULL)) {
> >               err = pci_xen_swiotlb_init_late();
> >               if (err)
> >                       dev_err(&pdev->xdev->dev, "Could not setup SWIOTLB!\n");
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 2a6cca07540b..c530c976d18b 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -123,7 +123,7 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
> >   void __init swiotlb_exit(void);
> >   unsigned int swiotlb_max_segment(void);
> >   size_t swiotlb_max_mapping_size(struct device *dev);
> > -bool is_swiotlb_active(void);
> > +bool is_swiotlb_active(struct device *dev);
> >   void __init swiotlb_adjust_size(unsigned long size);
> >   #else
> >   #define swiotlb_force SWIOTLB_NO_FORCE
> > @@ -143,7 +143,7 @@ static inline size_t swiotlb_max_mapping_size(struct device *dev)
> >       return SIZE_MAX;
> >   }
> >
> > -static inline bool is_swiotlb_active(void)
> > +static inline bool is_swiotlb_active(struct device *dev)
> >   {
> >       return false;
> >   }
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 84c9feb5474a..7a88c34d0867 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -495,7 +495,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
> >   size_t dma_direct_max_mapping_size(struct device *dev)
> >   {
> >       /* If SWIOTLB is active, use its maximum mapping size */
> > -     if (is_swiotlb_active() &&
> > +     if (is_swiotlb_active(dev) &&
> >           (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
>
> I wonder if it's worth trying to fold these other conditions into
> is_swiotlb_active() itself? I'm not entirely sure what matters for Xen,
> but for the other cases it seems like they probably only care about
> whether bouncing may occur for their particular device or not (possibly
> they want to be using dma_max_mapping_size() now anyway - TBH I'm
> struggling to make sense of what the swiotlb_max_segment business is
> supposed to mean).

I think leaving those conditions outside of is_swiotlb_active() might
help avoid confusion with is_dev_swiotlb_force() in patch #9? We need
is_dev_swiotlb_force() only because the restricted DMA pool supports
memory allocation, but the default swiotlb doesn't.

>
> Otherwise, patch #9 will need to touch here as well to make sure that
> per-device forced bouncing is reflected correctly.

You're right. Otherwise, is_dev_swiotlb_force is needed here.


>
> Robin.
>
> >               return swiotlb_max_mapping_size(dev);
> >       return SIZE_MAX;
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index ffbb8724e06c..1d221343f1c8 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -659,9 +659,9 @@ size_t swiotlb_max_mapping_size(struct device *dev)
> >       return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
> >   }
> >
> > -bool is_swiotlb_active(void)
> > +bool is_swiotlb_active(struct device *dev)
> >   {
> > -     return io_tlb_default_mem != NULL;
> > +     return get_io_tlb_mem(dev) != NULL;
> >   }
> >   EXPORT_SYMBOL_GPL(is_swiotlb_active);
> >
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
