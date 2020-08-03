Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FA0C433E0
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 15:15:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7433A2054F
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 15:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xh6Tk89e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7433A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3E25987A8D;
	Mon,  3 Aug 2020 15:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mq4Sulm04RYi; Mon,  3 Aug 2020 15:15:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5D75C87A77;
	Mon,  3 Aug 2020 15:15:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DE8BC0051;
	Mon,  3 Aug 2020 15:15:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20749C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1CA5485BD5
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Uvn5mMHqpof for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 15:15:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DC44985BD3
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 15:15:36 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id c2so21641865edx.8
 for <iommu@lists.linux-foundation.org>; Mon, 03 Aug 2020 08:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZuffSV18EU8xXSBhhfIwDGXYr/xPk0io21XcCQbtbWg=;
 b=Xh6Tk89eXSY7i4v3XL6YA/R//V/PF6If0rB7BsjJsL1YvBB2H6U2naNnR4xQgcVtK9
 5NMYwXK2oHiQcbumBgSP1qBIr1C6/6/JPq0EV+XOE3xiFQZn3ZnGx02QsR3aMU/cHkxg
 ivTK+tKnbWJ+7aVF2V+YV6Qqiv2o1MQ4lbzqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZuffSV18EU8xXSBhhfIwDGXYr/xPk0io21XcCQbtbWg=;
 b=Jpa+0qLpaWhxbuP9opirg2/JTWNktnlDEdchVbB8tpBb5r+0dgk8BZ9QKmSORd8SyP
 DEwsHPWrqv1f3pmdyhsx8r0jYP+K4oDTQ80WDEAZzjmoLKWrtP6I2FYSQtBesDE16nKU
 wLnvZWtUvDVMbfg7wEHsI8U0V1Vq6wD7XXXcec7hEyjYvpuKLHtKlXQR8sj9upeREo46
 Xajsxk4+ypVXqTClQcGZxnlL7Y51AyWAq6jl/qSW1zmogqkrbqI2rjJ9NqTi6a6AWC5d
 eD6DYP/dX3+G8+8vHOBqxh2MIXgT7ijwrJFjZn4dQmdVHesuRxHS8UfSU6a14BWeX9cu
 CLBQ==
X-Gm-Message-State: AOAM532pF/IuZ2VgLmxVY8BoYK8l8xy/azkbVgUjtwDU8nGKmhgAOjWs
 aS0vkqGmDgzutDMMZR6qog0f+B453Ck=
X-Google-Smtp-Source: ABdhPJxcdbIsuyA+nmIAWD0mBXMqqwk1SCs1RM+zYJjG4at7kutEpk1ZwD5d45do1pkL6LRCFzU7BA==
X-Received: by 2002:a05:6402:3090:: with SMTP id
 de16mr15697338edb.16.1596467734752; 
 Mon, 03 Aug 2020 08:15:34 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47])
 by smtp.gmail.com with ESMTPSA id u17sm16131564ejx.10.2020.08.03.08.15.33
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 08:15:33 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id r4so31596792wrx.9
 for <iommu@lists.linux-foundation.org>; Mon, 03 Aug 2020 08:15:33 -0700 (PDT)
X-Received: by 2002:a5d:6744:: with SMTP id l4mr16794657wrw.105.1596467732538; 
 Mon, 03 Aug 2020 08:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200728050140.996974-1-tientzu@chromium.org>
 <20200728050140.996974-5-tientzu@chromium.org>
 <20200731205804.GB756942@bogus>
 <CALiNf2-BGQ+8Lm6A61oM6v+6N1zRTJYvod7LQLsCmK-ADsrMaw@mail.gmail.com>
In-Reply-To: <CALiNf2-BGQ+8Lm6A61oM6v+6N1zRTJYvod7LQLsCmK-ADsrMaw@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 3 Aug 2020 17:15:20 +0200
X-Gmail-Original-Message-ID: <CAAFQd5Cm+ZGx9ia2sAdvHQC6zC1U=+9AWs7iW7o-qE4g7wZgsw@mail.gmail.com>
Message-ID: <CAAFQd5Cm+ZGx9ia2sAdvHQC6zC1U=+9AWs7iW7o-qE4g7wZgsw@mail.gmail.com>
Subject: Re: [RFC v2 4/5] dt-bindings: of: Add plumbing for restricted DMA pool
To: Claire Chang <tientzu@chromium.org>, Rob Herring <robh@kernel.org>
Cc: linux-devicetree <devicetree@vger.kernel.org>,
 heikki.krogerus@linux.intel.com, Saravana Kannan <saravanak@google.com>,
 Frank Rowand <frowand.list@gmail.com>, suzuki.poulose@arm.com,
 Greg KH <gregkh@linuxfoundation.org>, lkml <linux-kernel@vger.kernel.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Nicolas Boichat <drinkcat@chromium.org>, dan.j.williams@intel.com,
 Thierry Reding <treding@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

Hi Claire and Rob,

On Mon, Aug 3, 2020 at 4:26 PM Claire Chang <tientzu@chromium.org> wrote:
>
> On Sat, Aug 1, 2020 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Tue, Jul 28, 2020 at 01:01:39PM +0800, Claire Chang wrote:
> > > Introduce the new compatible string, device-swiotlb-pool, for restricted
> > > DMA. One can specify the address and length of the device swiotlb memory
> > > region by device-swiotlb-pool in the device tree.
> > >
> > > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > > ---
> > >  .../reserved-memory/reserved-memory.txt       | 35 +++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > index 4dd20de6977f..78850896e1d0 100644
> > > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > @@ -51,6 +51,24 @@ compatible (optional) - standard definition
> > >            used as a shared pool of DMA buffers for a set of devices. It can
> > >            be used by an operating system to instantiate the necessary pool
> > >            management subsystem if necessary.
> > > +        - device-swiotlb-pool: This indicates a region of memory meant to be
> >
> > swiotlb is a Linux thing. The binding should be independent.
> Got it. Thanks for pointing this out.
>
> >
> > > +          used as a pool of device swiotlb buffers for a given device. When
> > > +          using this, the no-map and reusable properties must not be set, so the
> > > +          operating system can create a virtual mapping that will be used for
> > > +          synchronization. Also, there must be a restricted-dma property in the
> > > +          device node to specify the indexes of reserved-memory nodes. One can
> > > +          specify two reserved-memory nodes in the device tree. One with
> > > +          shared-dma-pool to handle the coherent DMA buffer allocation, and
> > > +          another one with device-swiotlb-pool for regular DMA to/from system
> > > +          memory, which would be subject to bouncing. The main purpose for
> > > +          restricted DMA is to mitigate the lack of DMA access control on
> > > +          systems without an IOMMU, which could result in the DMA accessing the
> > > +          system memory at unexpected times and/or unexpected addresses,
> > > +          possibly leading to data leakage or corruption. The feature on its own
> > > +          provides a basic level of protection against the DMA overwriting buffer
> > > +          contents at unexpected times. However, to protect against general data
> > > +          leakage and system memory corruption, the system needs to provide a
> > > +          way to restrict the DMA to a predefined memory region.
> >
> > I'm pretty sure we already support per device carveouts and I don't
> > understand how this is different.
> We use this to bounce streaming DMA in and out of a specially allocated region.
> I'll try to merge this with the existing one (i.e., shared-dma-pool)
> to see if that
> makes things clearer.
>

Indeed, from the firmware point of view, this is just a carveout, for
which we have the "shared-dma-pool" compatible string defined already.

However, depending on the device and firmware setup, the way the
carevout is used may change. I can see the following scenarios:

1) coherent DMA (dma_alloc_*) within a reserved pool and no
non-coherent DMA (dma_map_*).

This is how the "memory-region" property is handled today in Linux for
devices which can only DMA from/to the given memory region. However,
I'm not sure if no non-coherent DMA is actually enforced in any way by
the DMA subsystem.

2) coherent DMA from a reserved pool and non-coherent DMA from system memory

This is the case for the systems which have some dedicated part of
memory which is guaranteed to be coherent with the DMA, but still can
do non-coherent DMA to any part of the system memory. Linux handles it
the same way as 1), which is what made me believe that 1) might not
actually be handled correctly.

3) coherent DMA and bounced non-coherent DMA within a reserved pool
4) coherent DMA within one pool and bounced non-coherent within another pool

These are the two cases we're interested in. Basically they make it
possible for non-coherent DMA from arbitrary system memory to be
bounced through a reserved pool, which the device has access to. The
current series implements 4), but I'd argue that it:

- is problematic from the firmware point of view, because on most of
the systems, both pools would be just some carveouts and the fact that
Linux would use one for coherent and the other for non-coherent DMA
would be an OS implementation detail,
- suffers from the static memory split between coherent and
non-coherent DMA, which could either result in some wasted memory or
the DMA stopped working after a kernel update if the driver changes
its allocation pattern,

and so we should rather go with 3).

Now, from the firmware point of view, it doesn't matter how the OS
uses the carveout, but I think it's still necessary to tell the OS
about the device DMA capability. Right now we use "memory-region" for
any kind of reserved memory, but looking at the above scenarios, there
are 2 cases:

a) the memory region is preferred for the device, e.g. it enables
coherency, but the device can still DMA across the rest of the system
memory. This is the case in scenario 2) and is kind of assumed in the
Linux DMA subsystem, although it's certainly not the case for a lot of
hardware, even if they use the "memory-region" binding.

b) the memory region is the only region that the device can access.
This is the case in scenarios 1), 3) and 4).

For this, I'd like to propose a "restricted-dma-region" (feel free to
suggest a better name) binding, which is explicitly specified to be
the only DMA-able memory for this device and make Linux use the given
pool for coherent DMA allocations and bouncing non-coherent DMA.

What do you think?

Best regards,
Tomasz

> >
> > What is the last sentence supposed to imply? You need an IOMMU?
> The main purpose is to mitigate the lack of DMA access control on
> systems without an IOMMU.
> For example, we plan to use this plus a MPU for our PCIe WiFi which is
> not behind an IOMMU.
>
> >
> > >          - vendor specific string in the form <vendor>,[<device>-]<usage>
> > >  no-map (optional) - empty property
> > >      - Indicates the operating system must not create a virtual mapping
> > > @@ -117,6 +135,16 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > >                       compatible = "acme,multimedia-memory";
> > >                       reg = <0x77000000 0x4000000>;
> > >               };
> > > +
> > > +             wifi_coherent_mem_region: wifi_coherent_mem_region {
> > > +                     compatible = "shared-dma-pool";
> > > +                     reg = <0x50000000 0x400000>;
> > > +             };
> > > +
> > > +             wifi_device_swiotlb_region: wifi_device_swiotlb_region {
> > > +                     compatible = "device-swiotlb-pool";
> > > +                     reg = <0x50400000 0x4000000>;
> > > +             };
> > >       };
> > >
> > >       /* ... */
> > > @@ -135,4 +163,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > >               memory-region = <&multimedia_reserved>;
> > >               /* ... */
> > >       };
> > > +
> > > +     pcie_wifi: pcie_wifi@0,0 {
> > > +             memory-region = <&wifi_coherent_mem_region>,
> > > +                      <&wifi_device_swiotlb_region>;
> > > +             restricted-dma = <0>, <1>;
> > > +             /* ... */
> > > +     };
> > >  };
> > > --
> > > 2.28.0.rc0.142.g3c755180ce-goog
> > >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
