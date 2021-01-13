Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE5FC433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 02:30:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5082310F
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 02:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5082310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 04FB620443;
	Wed, 13 Jan 2021 02:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EwjuNbKY2sxE; Wed, 13 Jan 2021 02:30:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 40DDD20436;
	Wed, 13 Jan 2021 02:30:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 235F3C0893;
	Wed, 13 Jan 2021 02:30:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA338C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 02:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 867AB20443
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 02:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8sYxx+UiIXvE for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 02:30:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by silver.osuosl.org (Postfix) with ESMTPS id 3071A20436
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 02:30:15 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id dk8so272972edb.1
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 18:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Pt5UETlRzxEfmCNnvTax6McqJSupC0kHJNd5M5Tk3YM=;
 b=TsRjhDJkIvx/eu/8Dfs4u/eA7XHGiCILe+X3MR73vyisdMsXXh5PtmdLED/GVKRM+1
 LWflHDw8pdNICFvV071XU8B6r5bQq/1VBUv+Ec3de3hTbcADu8hsQUglrP6RJcjXqNAA
 ojQ8dIj4rncwInw25v4xZFWxyiQ12aaKWhq88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Pt5UETlRzxEfmCNnvTax6McqJSupC0kHJNd5M5Tk3YM=;
 b=jJipUGHnusODkxAavY270qFOKEIO/MMz5lLnp6IFTmqvcrXW6kW6hVVQorxDrplph0
 Z6GmX42oIzRFe6Bjj2qOoADbYX2clRGwzjGBq1+VJ+L0VmP/mLUB4im+TwypHAJp+fnY
 WR3dVMs1baPz7APydkhiMrUN62n0aoEI4lxBlMOVU1zhrX2/fupzBryf177FydOh5pwQ
 3/OQSS6t8ZWWHzVL0/Og2xWspy3CqovCWrk7l6uQu0mOU4y02HZv31nKvIVSIjDINzJT
 Sz/S4laTyi4wO2palUEG7z0dgmJHrKAKpUE1dYi1ijmP+V/OFAtM7B28wIiYJ1D2u2cs
 O3TQ==
X-Gm-Message-State: AOAM533j7I5RbHAWXsNB8crYacUVDuW0GX5pbs1RqIQEW9Ku3eOL9nIl
 /HyrEIMPKDEwlFniNQWNSu+Jag5mSsA9SA==
X-Google-Smtp-Source: ABdhPJxCwdwEf0dH6oT5XqW7152+Qv6uwsF8b4PvtIOCGFvr6pLz2uYFd4BAluDBl80G5UZORR4yjA==
X-Received: by 2002:a05:6402:1c8b:: with SMTP id
 cy11mr4332edb.256.1610505013132; 
 Tue, 12 Jan 2021 18:30:13 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com.
 [209.85.221.45])
 by smtp.gmail.com with ESMTPSA id hr31sm122201ejc.125.2021.01.12.18.30.11
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jan 2021 18:30:11 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id r3so488764wrt.2
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 18:30:11 -0800 (PST)
X-Received: by 2002:adf:9b91:: with SMTP id d17mr94123wrc.32.1610505010644;
 Tue, 12 Jan 2021 18:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <d7043239-12cf-3636-4726-2e3b90917dc6@gmail.com>
 <CALiNf28sU1VtGB7LeTXExkMwQiCeg8N5arqyEjw0CPZP72R4dg@mail.gmail.com>
 <78871151-947d-b085-db03-0d0bd0b55632@gmail.com>
 <CALiNf29_PmLJTVLksSHp3NFAaL52idqehSMOtatJ=jaM2Muq1g@mail.gmail.com>
 <23a09b9a-70fc-a7a8-f3ea-b0bfa60507f0@gmail.com>
In-Reply-To: <23a09b9a-70fc-a7a8-f3ea-b0bfa60507f0@gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 13 Jan 2021 11:29:58 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DX=AdaYSYQbxgnrYYojkM5q7EE_Qs-BYPOiNjcQWbN1A@mail.gmail.com>
Message-ID: <CAAFQd5DX=AdaYSYQbxgnrYYojkM5q7EE_Qs-BYPOiNjcQWbN1A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Restricted DMA
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 xypron.glpk@gmx.de, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, Will Deacon <will@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, Claire Chang <tientzu@chromium.org>,
 boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, mpe@ellerman.id.au,
 Robin Murphy <robin.murphy@arm.com>
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

Hi Florian,

On Wed, Jan 13, 2021 at 3:01 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/11/21 11:48 PM, Claire Chang wrote:
> > On Fri, Jan 8, 2021 at 1:59 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> On 1/7/21 9:42 AM, Claire Chang wrote:
> >>
> >>>> Can you explain how ATF gets involved and to what extent it does help,
> >>>> besides enforcing a secure region from the ARM CPU's perpsective? Does
> >>>> the PCIe root complex not have an IOMMU but can somehow be denied access
> >>>> to a region that is marked NS=0 in the ARM CPU's MMU? If so, that is
> >>>> still some sort of basic protection that the HW enforces, right?
> >>>
> >>> We need the ATF support for memory MPU (memory protection unit).
> >>> Restricted DMA (with reserved-memory in dts) makes sure the predefined memory
> >>> region is for PCIe DMA only, but we still need MPU to locks down PCIe access to
> >>> that specific regions.
> >>
> >> OK so you do have a protection unit of some sort to enforce which region
> >> in DRAM the PCIE bridge is allowed to access, that makes sense,
> >> otherwise the restricted DMA region would only be a hint but nothing you
> >> can really enforce. This is almost entirely analogous to our systems then.
> >
> > Here is the example of setting the MPU:
> > https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
> >
> >>
> >> There may be some value in standardizing on an ARM SMCCC call then since
> >> you already support two different SoC vendors.
> >>
> >>>
> >>>>
> >>>> On Broadcom STB SoCs we have had something similar for a while however
> >>>> and while we don't have an IOMMU for the PCIe bridge, we do have a a
> >>>> basic protection mechanism whereby we can configure a region in DRAM to
> >>>> be PCIe read/write and CPU read/write which then gets used as the PCIe
> >>>> inbound region for the PCIe EP. By default the PCIe bridge is not
> >>>> allowed access to DRAM so we must call into a security agent to allow
> >>>> the PCIe bridge to access the designated DRAM region.
> >>>>
> >>>> We have done this using a private CMA area region assigned via Device
> >>>> Tree, assigned with a and requiring the PCIe EP driver to use
> >>>> dma_alloc_from_contiguous() in order to allocate from this device
> >>>> private CMA area. The only drawback with that approach is that it
> >>>> requires knowing how much memory you need up front for buffers and DMA
> >>>> descriptors that the PCIe EP will need to process. The problem is that
> >>>> it requires driver modifications and that does not scale over the number
> >>>> of PCIe EP drivers, some we absolutely do not control, but there is no
> >>>> need to bounce buffer. Your approach scales better across PCIe EP
> >>>> drivers however it does require bounce buffering which could be a
> >>>> performance hit.
> >>>
> >>> Only the streaming DMA (map/unmap) needs bounce buffering.
> >>
> >> True, and typically only on transmit since you don't really control
> >> where the sk_buff are allocated from, right? On RX since you need to
> >> hand buffer addresses to the WLAN chip prior to DMA, you can allocate
> >> them from a pool that already falls within the restricted DMA region, right?
> >>
> >
> > Right, but applying bounce buffering to RX will make it more secure.
> > The device won't be able to modify the content after unmap. Just like what
> > iommu_unmap does.
>
> Sure, however the goals of using bounce buffering equally applies to RX
> and TX in that this is the only layer sitting between a stack (block,
> networking, USB, etc.) and the underlying device driver that scales well
> in order to massage a dma_addr_t to be within a particular physical range.
>
> There is however room for improvement if the drivers are willing to
> change their buffer allocation strategy. When you receive Wi-Fi frames
> you need to allocate buffers for the Wi-Fi device to DMA into, and that
> happens ahead of the DMA transfers by the Wi-Fi device. At buffer
> allocation time you could very well allocate these frames from the
> restricted DMA region without having to bounce buffer them since the
> host CPU is in control over where and when to DMA into.
>

That is, however, still a trade-off between saving that one copy and
protection from the DMA tampering with the packet contents when the
kernel is reading them. Notice how the copy effectively makes a
snapshot of the contents, guaranteeing that the kernel has a
consistent view of the packet, which is not true if the DMA could
modify the buffer contents in the middle of CPU accesses.

Best regards,
Tomasz

> The issue is that each network driver may implement its own buffer
> allocation strategy, some may simply call netdev_alloc_skb() which gives
> zero control over where the buffer comes from unless you play tricks
> with NUMA node allocations and somehow declare that your restricted DMA
> region is a different NUMA node. If the driver allocates pages and then
> attaches a SKB to that page using build_skb(), then you have much more
> control over where that page comes from, and this is where using a
> device private CMA are helps, because you can just do
> dma_alloc_from_contiguous() and that will ensure that the pages are
> coming from your specific CMA area.
>
> Few questions on the implementation:
>
> - is there any warning or error being printed if the restricted DMA
> region is outside of a device's DMA addressable range?
>
> - are there are any helpful statistics that could be shown to indicate
> that the restricted DMA region was sized too small, e.g.: that
> allocation of a DMA buffer failed because we ran out of space in the
> swiotlb pool?
>
> >
> >>> I also added alloc/free support in this series
> >>> (https://lore.kernel.org/patchwork/patch/1360995/), so dma_direct_alloc() will
> >>> try to allocate memory from the predefined memory region.
> >>>
> >>> As for the performance hit, it should be similar to the default swiotlb.
> >>> Here are my experiment results. Both SoCs lack IOMMU for PCIe.
> >>>
> >>> PCIe wifi vht80 throughput -
> >>>
> >>>   MTK SoC                  tcp_tx     tcp_rx    udp_tx   udp_rx
> >>>   w/o Restricted DMA  244.1     134.66   312.56   350.79
> >>>   w/ Restricted DMA    246.95   136.59   363.21   351.99
> >>>
> >>>   Rockchip SoC           tcp_tx     tcp_rx    udp_tx   udp_rx
> >>>   w/o Restricted DMA  237.87   133.86   288.28   361.88
> >>>   w/ Restricted DMA    256.01   130.95   292.28   353.19
> >>
> >> How come you get better throughput with restricted DMA? Is it because
> >> doing DMA to/from a contiguous region allows for better grouping of
> >> transactions from the DRAM controller's perspective somehow?
> >
> > I'm not sure, but actually, enabling the default swiotlb for wifi also helps the
> > throughput a little bit for me.
>
> OK, it would be interesting if you could get to the bottom of why
> performance does increase with swiotlb.
> --
> Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
