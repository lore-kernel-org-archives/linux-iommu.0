Return-Path: <SRS0=lzux=GQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6382C433E0
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 04:31:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5970A2312E
	for <iommu@archiver.kernel.org>; Wed, 13 Jan 2021 04:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5970A2312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ABDC687155;
	Wed, 13 Jan 2021 04:31:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pkmI3TpCspWH; Wed, 13 Jan 2021 04:31:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A103787144;
	Wed, 13 Jan 2021 04:31:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D1B2C0893;
	Wed, 13 Jan 2021 04:31:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C770C013A
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 04:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 221BC85BCC
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 04:31:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ekat9SyIgRwG for <iommu@lists.linux-foundation.org>;
 Wed, 13 Jan 2021 04:31:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 89E2185BBA
 for <iommu@lists.linux-foundation.org>; Wed, 13 Jan 2021 04:31:16 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id 6so1169587ejz.5
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 20:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qd8hOVRYaVRyWNGRjHwo8wnN48NoVMjkXuMdDYJPYxc=;
 b=cUL+OIdnJx4G27gKvv1kHgGhT/slNCHswvbi3BuicuPQK2CUGcm0qVdh+9o8kjC/EK
 SNX+36UrRAN9XTvqxA+bDb4zE1ip5M/Md1KqkddIPS827Ih0ruD0qLwi/Bm2QcxOkH5H
 8Ph19hD0ZaKeMRKRHdsA/toCspDEeybtcuDi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qd8hOVRYaVRyWNGRjHwo8wnN48NoVMjkXuMdDYJPYxc=;
 b=lUCcWOeExqVBFfpn3lU/4ha49sUfPr6ydS/fKkvGojT7AoJqEZoyiYCScwyElN/pTQ
 Yp/XbzeOMggCfl3c4hwFiUgWegtly+wToShiPXw3b3F/9sBplpctLPGzroenl0xIuXDM
 LHjLmxu5+s01YTITYfZB+37gx6J90SueJbN7Ao9eCDtaTEuAkSticq2pjshokSHvhi6/
 s99SQ6O3R+Vtip5IY8E5Ai2Z7rwdtJi1qR0+6IwlxW5IK9e5v1z3h1EoB9qXxiecSYPj
 wDYdOgJdC6RcDRBsUYunlf/RcgbJdKsxRRqZUq0V0vYZ6LAyYrzTAnhViIVGdmDtJ/6H
 e9Uw==
X-Gm-Message-State: AOAM532fketdm4jpmyuVLgYXHqhQqhLkiFZL5Iiyvvtvtkizz4OEIWHU
 1EaouX1gLtZWTv9SwP6rUTplnd7wfbErStXj
X-Google-Smtp-Source: ABdhPJyuwsrUsOHpTjTxn72Qj73RhjOdl2VcfgH8ffctcvGh/Kr0+QEcswOLdCwcd6sQaIa/ZWFV6A==
X-Received: by 2002:a17:906:b7cc:: with SMTP id
 fy12mr208283ejb.390.1610512274626; 
 Tue, 12 Jan 2021 20:31:14 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47])
 by smtp.gmail.com with ESMTPSA id j23sm201069ejs.112.2021.01.12.20.31.14
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jan 2021 20:31:14 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id m4so639476wrx.9
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 20:31:14 -0800 (PST)
X-Received: by 2002:adf:fa86:: with SMTP id h6mr380594wrr.103.1610511938864;
 Tue, 12 Jan 2021 20:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20210106034124.30560-1-tientzu@chromium.org>
 <d7043239-12cf-3636-4726-2e3b90917dc6@gmail.com>
 <CALiNf28sU1VtGB7LeTXExkMwQiCeg8N5arqyEjw0CPZP72R4dg@mail.gmail.com>
 <78871151-947d-b085-db03-0d0bd0b55632@gmail.com>
 <CALiNf29_PmLJTVLksSHp3NFAaL52idqehSMOtatJ=jaM2Muq1g@mail.gmail.com>
 <23a09b9a-70fc-a7a8-f3ea-b0bfa60507f0@gmail.com>
 <CAAFQd5DX=AdaYSYQbxgnrYYojkM5q7EE_Qs-BYPOiNjcQWbN1A@mail.gmail.com>
 <c7f7941d-b8bd-f0f3-4e40-b899a77188bf@gmail.com>
In-Reply-To: <c7f7941d-b8bd-f0f3-4e40-b899a77188bf@gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 13 Jan 2021 13:25:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AGm4U8hD4jHmw10S7MRS1-ZUSq7eGgoUifMMyfZgP2NA@mail.gmail.com>
Message-ID: <CAAFQd5AGm4U8hD4jHmw10S7MRS1-ZUSq7eGgoUifMMyfZgP2NA@mail.gmail.com>
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

On Wed, Jan 13, 2021 at 12:56 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 1/12/2021 6:29 PM, Tomasz Figa wrote:
> > Hi Florian,
> >
> > On Wed, Jan 13, 2021 at 3:01 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> On 1/11/21 11:48 PM, Claire Chang wrote:
> >>> On Fri, Jan 8, 2021 at 1:59 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>
> >>>> On 1/7/21 9:42 AM, Claire Chang wrote:
> >>>>
> >>>>>> Can you explain how ATF gets involved and to what extent it does help,
> >>>>>> besides enforcing a secure region from the ARM CPU's perpsective? Does
> >>>>>> the PCIe root complex not have an IOMMU but can somehow be denied access
> >>>>>> to a region that is marked NS=0 in the ARM CPU's MMU? If so, that is
> >>>>>> still some sort of basic protection that the HW enforces, right?
> >>>>>
> >>>>> We need the ATF support for memory MPU (memory protection unit).
> >>>>> Restricted DMA (with reserved-memory in dts) makes sure the predefined memory
> >>>>> region is for PCIe DMA only, but we still need MPU to locks down PCIe access to
> >>>>> that specific regions.
> >>>>
> >>>> OK so you do have a protection unit of some sort to enforce which region
> >>>> in DRAM the PCIE bridge is allowed to access, that makes sense,
> >>>> otherwise the restricted DMA region would only be a hint but nothing you
> >>>> can really enforce. This is almost entirely analogous to our systems then.
> >>>
> >>> Here is the example of setting the MPU:
> >>> https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
> >>>
> >>>>
> >>>> There may be some value in standardizing on an ARM SMCCC call then since
> >>>> you already support two different SoC vendors.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> On Broadcom STB SoCs we have had something similar for a while however
> >>>>>> and while we don't have an IOMMU for the PCIe bridge, we do have a a
> >>>>>> basic protection mechanism whereby we can configure a region in DRAM to
> >>>>>> be PCIe read/write and CPU read/write which then gets used as the PCIe
> >>>>>> inbound region for the PCIe EP. By default the PCIe bridge is not
> >>>>>> allowed access to DRAM so we must call into a security agent to allow
> >>>>>> the PCIe bridge to access the designated DRAM region.
> >>>>>>
> >>>>>> We have done this using a private CMA area region assigned via Device
> >>>>>> Tree, assigned with a and requiring the PCIe EP driver to use
> >>>>>> dma_alloc_from_contiguous() in order to allocate from this device
> >>>>>> private CMA area. The only drawback with that approach is that it
> >>>>>> requires knowing how much memory you need up front for buffers and DMA
> >>>>>> descriptors that the PCIe EP will need to process. The problem is that
> >>>>>> it requires driver modifications and that does not scale over the number
> >>>>>> of PCIe EP drivers, some we absolutely do not control, but there is no
> >>>>>> need to bounce buffer. Your approach scales better across PCIe EP
> >>>>>> drivers however it does require bounce buffering which could be a
> >>>>>> performance hit.
> >>>>>
> >>>>> Only the streaming DMA (map/unmap) needs bounce buffering.
> >>>>
> >>>> True, and typically only on transmit since you don't really control
> >>>> where the sk_buff are allocated from, right? On RX since you need to
> >>>> hand buffer addresses to the WLAN chip prior to DMA, you can allocate
> >>>> them from a pool that already falls within the restricted DMA region, right?
> >>>>
> >>>
> >>> Right, but applying bounce buffering to RX will make it more secure.
> >>> The device won't be able to modify the content after unmap. Just like what
> >>> iommu_unmap does.
> >>
> >> Sure, however the goals of using bounce buffering equally applies to RX
> >> and TX in that this is the only layer sitting between a stack (block,
> >> networking, USB, etc.) and the underlying device driver that scales well
> >> in order to massage a dma_addr_t to be within a particular physical range.
> >>
> >> There is however room for improvement if the drivers are willing to
> >> change their buffer allocation strategy. When you receive Wi-Fi frames
> >> you need to allocate buffers for the Wi-Fi device to DMA into, and that
> >> happens ahead of the DMA transfers by the Wi-Fi device. At buffer
> >> allocation time you could very well allocate these frames from the
> >> restricted DMA region without having to bounce buffer them since the
> >> host CPU is in control over where and when to DMA into.
> >>
> >
> > That is, however, still a trade-off between saving that one copy and
> > protection from the DMA tampering with the packet contents when the
> > kernel is reading them. Notice how the copy effectively makes a
> > snapshot of the contents, guaranteeing that the kernel has a
> > consistent view of the packet, which is not true if the DMA could
> > modify the buffer contents in the middle of CPU accesses.
>
> I would say that the window just became so much narrower for the PCIe
> end-point to overwrite contents with the copy because it would have to
> happen within the dma_unmap_{page,single} time and before the copy is
> finished to the bounce buffer.

Not only. Imagine this:

a) Without bouncing:

- RX interrupt
- Pass the packet to the network stack
- Network stack validates the packet
- DMA overwrites the packet
- Network stack goes boom, because the packet changed after validation

b) With bouncing:

- RX interrupt
- Copy the packet to a DMA-inaccessible buffer
- Network stack validates the packet
- Network stack is happy, because the packet is guaranteed to stay the
same after validation

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
