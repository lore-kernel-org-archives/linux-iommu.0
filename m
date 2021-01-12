Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD4C433DB
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 07:56:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29C4522E00
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 07:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C4522E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF7A886A2E;
	Tue, 12 Jan 2021 07:56:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1K9p2dwphik; Tue, 12 Jan 2021 07:56:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 091718619F;
	Tue, 12 Jan 2021 07:56:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03335C088B;
	Tue, 12 Jan 2021 07:56:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37856C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 07:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 24E4485F7F
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 07:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZZBTl1cuJEJ for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 07:56:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2E1878481F
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 07:56:12 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id c22so885364pgg.13
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 23:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M6gti34JNoWz5z3B8Kij1up+0ymqSqmekx/99+4faKU=;
 b=X6l/XLromsTlU6NHa0DWJ/v5avCPE+tbWy6cx1R1IpoHKfbhgU6MF+gZNi4A3oZMQA
 aDXLX9RnsLGW3PS+TKQP3dv3P0XkS3dWXlHp8BVT2WpAIYitmTledVhp8sQu29+3epTn
 3vsNGErl3t1pJGKPEpwPU9LYUv1Ianz/yayzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M6gti34JNoWz5z3B8Kij1up+0ymqSqmekx/99+4faKU=;
 b=gw1wq25UvXTwJO3GzegCgjKY6VbEkGBGByWc+h+cnVeK5j1u21uW5MeFzsD7HUiIaV
 0T2QhPxVRfejxJZ6cRNqW2L9Cf5YeLe1V1NuLgfXT8seKNIufM6g9Jc+n4aOC2N3hZSn
 g8korZDex+REm4yA7DGO+WVzOe5Zuy1YlI3Y93gkmtQvetk/DJxD8jR7sn/7BBDczGNT
 uisE6StdYkBI7z3e4GsZnMOUdrzbB9nSxSlZ3H7fX2PknasQnLNGLr3KM+hKDoOt+f6u
 56d+LRf8lvbJlNI3WS/1ZT8tViXUlN6VtKtab6TeyHkYxORdNyIVx92sNcP5it0Zw3Af
 fwvA==
X-Gm-Message-State: AOAM532nhbsOnCZgWxD8T3cjNqhFnM77TLKPmgOY8hM+GLVK5ZGCyz8+
 rsI6jxfylplCY4MzvAyyldby5NWC5KOK+bN1
X-Google-Smtp-Source: ABdhPJy6Xp4Sd/zlNFFppNa1LdZbYX74RuBb2WKH9lpPvETTEtZMjChckN2pFcEUD8QJvn+dcMA2rg==
X-Received: by 2002:a6b:7d42:: with SMTP id d2mr2367101ioq.176.1610437709504; 
 Mon, 11 Jan 2021 23:48:29 -0800 (PST)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com.
 [209.85.166.50])
 by smtp.gmail.com with ESMTPSA id t16sm1943076ilb.50.2021.01.11.23.48.28
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 23:48:28 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id u26so2145660iof.3
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 23:48:28 -0800 (PST)
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr2402150ioq.34.1610437707606; 
 Mon, 11 Jan 2021 23:48:27 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <d7043239-12cf-3636-4726-2e3b90917dc6@gmail.com>
 <CALiNf28sU1VtGB7LeTXExkMwQiCeg8N5arqyEjw0CPZP72R4dg@mail.gmail.com>
 <78871151-947d-b085-db03-0d0bd0b55632@gmail.com>
In-Reply-To: <78871151-947d-b085-db03-0d0bd0b55632@gmail.com>
From: Claire Chang <tientzu@chromium.org>
Date: Tue, 12 Jan 2021 15:48:16 +0800
X-Gmail-Original-Message-ID: <CALiNf29_PmLJTVLksSHp3NFAaL52idqehSMOtatJ=jaM2Muq1g@mail.gmail.com>
Message-ID: <CALiNf29_PmLJTVLksSHp3NFAaL52idqehSMOtatJ=jaM2Muq1g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] Restricted DMA
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
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
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

On Fri, Jan 8, 2021 at 1:59 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 1/7/21 9:42 AM, Claire Chang wrote:
>
> >> Can you explain how ATF gets involved and to what extent it does help,
> >> besides enforcing a secure region from the ARM CPU's perpsective? Does
> >> the PCIe root complex not have an IOMMU but can somehow be denied access
> >> to a region that is marked NS=0 in the ARM CPU's MMU? If so, that is
> >> still some sort of basic protection that the HW enforces, right?
> >
> > We need the ATF support for memory MPU (memory protection unit).
> > Restricted DMA (with reserved-memory in dts) makes sure the predefined memory
> > region is for PCIe DMA only, but we still need MPU to locks down PCIe access to
> > that specific regions.
>
> OK so you do have a protection unit of some sort to enforce which region
> in DRAM the PCIE bridge is allowed to access, that makes sense,
> otherwise the restricted DMA region would only be a hint but nothing you
> can really enforce. This is almost entirely analogous to our systems then.

Here is the example of setting the MPU:
https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132

>
> There may be some value in standardizing on an ARM SMCCC call then since
> you already support two different SoC vendors.
>
> >
> >>
> >> On Broadcom STB SoCs we have had something similar for a while however
> >> and while we don't have an IOMMU for the PCIe bridge, we do have a a
> >> basic protection mechanism whereby we can configure a region in DRAM to
> >> be PCIe read/write and CPU read/write which then gets used as the PCIe
> >> inbound region for the PCIe EP. By default the PCIe bridge is not
> >> allowed access to DRAM so we must call into a security agent to allow
> >> the PCIe bridge to access the designated DRAM region.
> >>
> >> We have done this using a private CMA area region assigned via Device
> >> Tree, assigned with a and requiring the PCIe EP driver to use
> >> dma_alloc_from_contiguous() in order to allocate from this device
> >> private CMA area. The only drawback with that approach is that it
> >> requires knowing how much memory you need up front for buffers and DMA
> >> descriptors that the PCIe EP will need to process. The problem is that
> >> it requires driver modifications and that does not scale over the number
> >> of PCIe EP drivers, some we absolutely do not control, but there is no
> >> need to bounce buffer. Your approach scales better across PCIe EP
> >> drivers however it does require bounce buffering which could be a
> >> performance hit.
> >
> > Only the streaming DMA (map/unmap) needs bounce buffering.
>
> True, and typically only on transmit since you don't really control
> where the sk_buff are allocated from, right? On RX since you need to
> hand buffer addresses to the WLAN chip prior to DMA, you can allocate
> them from a pool that already falls within the restricted DMA region, right?
>

Right, but applying bounce buffering to RX will make it more secure.
The device won't be able to modify the content after unmap. Just like what
iommu_unmap does.

> > I also added alloc/free support in this series
> > (https://lore.kernel.org/patchwork/patch/1360995/), so dma_direct_alloc() will
> > try to allocate memory from the predefined memory region.
> >
> > As for the performance hit, it should be similar to the default swiotlb.
> > Here are my experiment results. Both SoCs lack IOMMU for PCIe.
> >
> > PCIe wifi vht80 throughput -
> >
> >   MTK SoC                  tcp_tx     tcp_rx    udp_tx   udp_rx
> >   w/o Restricted DMA  244.1     134.66   312.56   350.79
> >   w/ Restricted DMA    246.95   136.59   363.21   351.99
> >
> >   Rockchip SoC           tcp_tx     tcp_rx    udp_tx   udp_rx
> >   w/o Restricted DMA  237.87   133.86   288.28   361.88
> >   w/ Restricted DMA    256.01   130.95   292.28   353.19
>
> How come you get better throughput with restricted DMA? Is it because
> doing DMA to/from a contiguous region allows for better grouping of
> transactions from the DRAM controller's perspective somehow?

I'm not sure, but actually, enabling the default swiotlb for wifi also helps the
throughput a little bit for me.

>
> >
> > The CPU usage doesn't increase too much either.
> > Although I didn't measure the CPU usage very precisely, it's ~3% with a single
> > big core (Cortex-A72) and ~5% with a single small core (Cortex-A53).
> >
> > Thanks!
> >
> >>
> >> Thanks!
> >> --
> >> Florian
>
>
> --
> Florian
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
