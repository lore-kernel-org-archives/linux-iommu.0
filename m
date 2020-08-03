Return-Path: <SRS0=54Vi=BN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA19DC433E0
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 14:26:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AD30206D4
	for <iommu@archiver.kernel.org>; Mon,  3 Aug 2020 14:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G901bH1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD30206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3FA612049E;
	Mon,  3 Aug 2020 14:27:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gXoB7N4qOkHR; Mon,  3 Aug 2020 14:26:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 36AA620406;
	Mon,  3 Aug 2020 14:26:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28333C0050;
	Mon,  3 Aug 2020 14:26:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F1F5C004C
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 14:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 34FEE8671A
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 14:26:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jZTY-Tlp1957 for <iommu@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 14:26:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 26CB186717
 for <iommu@lists.linux-foundation.org>; Mon,  3 Aug 2020 14:26:56 +0000 (UTC)
Received: by mail-il1-f194.google.com with SMTP id 77so2777786ilc.5
 for <iommu@lists.linux-foundation.org>; Mon, 03 Aug 2020 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qBYoXUErLdg1XxwofpDGcU6L+k/lh9jilEvaXMRcAXc=;
 b=G901bH1uartSYnMZf8E4nRq9+71hJJZGAK3/aI2Rg1yPpayiz5rCEYt/3cGtWR/r6v
 asX3fM23eTN7nHbcTHCug9Y70kr7oBZi+7gsEjvZkMLZEh0wwKbP0Z7Dl7skRtGE/PT5
 2fuf5ePHkxBk1tIAiC0Um/3dzIIFYrLJlXmjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qBYoXUErLdg1XxwofpDGcU6L+k/lh9jilEvaXMRcAXc=;
 b=cVE3bf46MrT/Hagh6YGeKnWNUyZVtsDcxy5wd1kBCcm0vPG5+nUOyZNMzMMh7TvkN3
 Hq7sRwYAe5MJ6CSyw3PNDP87/7Ajpsdk2XuAWxEFR96I9Nmgcb0uXfvvWUNYfB8H+UhX
 IUy9mFdK7221zK+TAhCRwD0e7G7toJPjtRZhqNW4Sj7KsstfPt7zwiNIpfMyIFVMdHPi
 VcTsurDC0RrD1+eWafle2sJ++OL6HRxl03h++6d4Dw3cYmZ868a+NvkrrR3E/igqfTGI
 o5aWeW5dod7E/UjiFsmEpgo/HUwY9bp8pTcFYskkV9ORtjhwuz6uPVfAU7MQ6aOssTG3
 t3Ig==
X-Gm-Message-State: AOAM531BZCm0KBsQKNzrM+wTuiRelvoJbLM0F/bEiZaxvYn9uwW1Tx+/
 kKaUCY5/CHz2GkPWcWfTeW7uzZDqOk8=
X-Google-Smtp-Source: ABdhPJyGOTEdkIjzuGvtpJjy3m94Vb+lWs8646oiMEz6js83QThwlvfKZsNAZaBcb4s/o8tkrp+1bQ==
X-Received: by 2002:a92:c9cf:: with SMTP id k15mr18657985ilq.6.1596464815004; 
 Mon, 03 Aug 2020 07:26:55 -0700 (PDT)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com.
 [209.85.166.45])
 by smtp.gmail.com with ESMTPSA id b15sm5501156ilc.23.2020.08.03.07.26.53
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 07:26:53 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id q75so30522329iod.1
 for <iommu@lists.linux-foundation.org>; Mon, 03 Aug 2020 07:26:53 -0700 (PDT)
X-Received: by 2002:a05:6638:305:: with SMTP id
 w5mr21375421jap.10.1596464812761; 
 Mon, 03 Aug 2020 07:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200728050140.996974-1-tientzu@chromium.org>
 <20200728050140.996974-5-tientzu@chromium.org>
 <20200731205804.GB756942@bogus>
In-Reply-To: <20200731205804.GB756942@bogus>
From: Claire Chang <tientzu@chromium.org>
Date: Mon, 3 Aug 2020 22:26:41 +0800
X-Gmail-Original-Message-ID: <CALiNf2-BGQ+8Lm6A61oM6v+6N1zRTJYvod7LQLsCmK-ADsrMaw@mail.gmail.com>
Message-ID: <CALiNf2-BGQ+8Lm6A61oM6v+6N1zRTJYvod7LQLsCmK-ADsrMaw@mail.gmail.com>
Subject: Re: [RFC v2 4/5] dt-bindings: of: Add plumbing for restricted DMA pool
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 Saravana Kannan <saravanak@google.com>, frowand.list@gmail.com,
 suzuki.poulose@arm.com, Greg KH <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, Nicolas Boichat <drinkcat@chromium.org>,
 dan.j.williams@intel.com, treding@nvidia.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Sat, Aug 1, 2020 at 4:58 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jul 28, 2020 at 01:01:39PM +0800, Claire Chang wrote:
> > Introduce the new compatible string, device-swiotlb-pool, for restricted
> > DMA. One can specify the address and length of the device swiotlb memory
> > region by device-swiotlb-pool in the device tree.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >  .../reserved-memory/reserved-memory.txt       | 35 +++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > index 4dd20de6977f..78850896e1d0 100644
> > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > @@ -51,6 +51,24 @@ compatible (optional) - standard definition
> >            used as a shared pool of DMA buffers for a set of devices. It can
> >            be used by an operating system to instantiate the necessary pool
> >            management subsystem if necessary.
> > +        - device-swiotlb-pool: This indicates a region of memory meant to be
>
> swiotlb is a Linux thing. The binding should be independent.
Got it. Thanks for pointing this out.

>
> > +          used as a pool of device swiotlb buffers for a given device. When
> > +          using this, the no-map and reusable properties must not be set, so the
> > +          operating system can create a virtual mapping that will be used for
> > +          synchronization. Also, there must be a restricted-dma property in the
> > +          device node to specify the indexes of reserved-memory nodes. One can
> > +          specify two reserved-memory nodes in the device tree. One with
> > +          shared-dma-pool to handle the coherent DMA buffer allocation, and
> > +          another one with device-swiotlb-pool for regular DMA to/from system
> > +          memory, which would be subject to bouncing. The main purpose for
> > +          restricted DMA is to mitigate the lack of DMA access control on
> > +          systems without an IOMMU, which could result in the DMA accessing the
> > +          system memory at unexpected times and/or unexpected addresses,
> > +          possibly leading to data leakage or corruption. The feature on its own
> > +          provides a basic level of protection against the DMA overwriting buffer
> > +          contents at unexpected times. However, to protect against general data
> > +          leakage and system memory corruption, the system needs to provide a
> > +          way to restrict the DMA to a predefined memory region.
>
> I'm pretty sure we already support per device carveouts and I don't
> understand how this is different.
We use this to bounce streaming DMA in and out of a specially allocated region.
I'll try to merge this with the existing one (i.e., shared-dma-pool)
to see if that
makes things clearer.

>
> What is the last sentence supposed to imply? You need an IOMMU?
The main purpose is to mitigate the lack of DMA access control on
systems without an IOMMU.
For example, we plan to use this plus a MPU for our PCIe WiFi which is
not behind an IOMMU.

>
> >          - vendor specific string in the form <vendor>,[<device>-]<usage>
> >  no-map (optional) - empty property
> >      - Indicates the operating system must not create a virtual mapping
> > @@ -117,6 +135,16 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> >                       compatible = "acme,multimedia-memory";
> >                       reg = <0x77000000 0x4000000>;
> >               };
> > +
> > +             wifi_coherent_mem_region: wifi_coherent_mem_region {
> > +                     compatible = "shared-dma-pool";
> > +                     reg = <0x50000000 0x400000>;
> > +             };
> > +
> > +             wifi_device_swiotlb_region: wifi_device_swiotlb_region {
> > +                     compatible = "device-swiotlb-pool";
> > +                     reg = <0x50400000 0x4000000>;
> > +             };
> >       };
> >
> >       /* ... */
> > @@ -135,4 +163,11 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> >               memory-region = <&multimedia_reserved>;
> >               /* ... */
> >       };
> > +
> > +     pcie_wifi: pcie_wifi@0,0 {
> > +             memory-region = <&wifi_coherent_mem_region>,
> > +                      <&wifi_device_swiotlb_region>;
> > +             restricted-dma = <0>, <1>;
> > +             /* ... */
> > +     };
> >  };
> > --
> > 2.28.0.rc0.142.g3c755180ce-goog
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
