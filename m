Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F8C433DF
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 15:37:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 003A620782
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 15:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KvGAEAd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 003A620782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE12A886A3;
	Tue, 25 Aug 2020 15:37:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gn0AvrGuqwsN; Tue, 25 Aug 2020 15:37:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17B6B886AF;
	Tue, 25 Aug 2020 15:37:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1780C07FF;
	Tue, 25 Aug 2020 15:37:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7805AC0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 15:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 72C9186BA9
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 15:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tUuOaZZEvwba for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 15:37:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1D3DA86BA6
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 15:37:36 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id y3so13162027wrl.4
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 08:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QiWW06IWe+VHrM4kR/F2lfc40IYQlHNu4dO/e0F06jo=;
 b=KvGAEAd0OvyVMeh2NKOfrKkXjBDpUD9XSlK35v/laWG9LWTCv0zAtvEF/u9wI7i6Yc
 1l4Hd/9Pv2MZ4ub7JnqRhmtPFlFg8/ApuIQ3s6HNiJlEN+F8gnXQ6nb1RfhTKwqzM1Uu
 fEGEr4KUFMVRnTUJqd4n6xw/SydHgMl/IeFaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QiWW06IWe+VHrM4kR/F2lfc40IYQlHNu4dO/e0F06jo=;
 b=onp/Fl5iLCHawQLwrZ3M7gwRvypb1nOTDjS8lRU2RmXikibeOFCJRLQilsrAuIay8E
 n+EQEquLwFgGakA3BC8/wO6xq6PYICrbp1GEg0daHEo7GhWDrHZFRcU4sB+nbkUo0htb
 bRQAyiexSeTQwJSeBu50r/yEgDCqnIYZM+eb/8x7TsBdYftdo2TtkVlR5mYLWAgYb1pY
 SuWO21jSKAEoIZCbdMOoLT/fKL1w3Wy6nAUWfsYFjfYbSRP+QUu+1RKf/FGWoon9f3cY
 MNczkqyf4sj2MlAtTI1RkybUyCi9ttJRB3a7q6bQDIxceUHNjPJq5flzeyBddDiKWvZE
 t9WQ==
X-Gm-Message-State: AOAM531W7vynrp06gjC+4whyxY6gZnrrtnydeGBEcWk81etp3SVs7t5q
 hqXw/XEcgCuFTj/N9erZBtVSCbI+QVzQS7SAssM5yw==
X-Google-Smtp-Source: ABdhPJzkA/FEnRbvsbderhdII4r81LGYlNH/sKgYxDlux/BAP67c6Z42PfH4SooQdTRw5rz6G6M1mL/iLjbQ9lymr+k=
X-Received: by 2002:adf:bb54:: with SMTP id x20mr10426414wrg.413.1598369855067; 
 Tue, 25 Aug 2020 08:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-8-james.quinlan@broadcom.com>
 <20200825094506.GR1891694@smile.fi.intel.com>
In-Reply-To: <20200825094506.GR1891694@smile.fi.intel.com>
Date: Tue, 25 Aug 2020 11:37:23 -0400
Message-ID: <CA+-6iNzV5_M0g8tQEmscb_nq4s5PcS69tb9e2m8Pm1O1ifpuow@mail.gmail.com>
Subject: Re: [PATCH v11 07/11] device-mapping: Introduce DMA range map,
 supplanting dma_pfn_offset
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, Chen-Yu Tsai <wens@csie.org>,
 Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Yong Deng <yong.deng@magewell.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Felipe Balbi <balbi@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
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
From: Jim Quinlan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Andy,


On Tue, Aug 25, 2020 at 5:54 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 24, 2020 at 03:30:20PM -0400, Jim Quinlan wrote:
> > The new field 'dma_range_map' in struct device is used to facilitate the
> > use of single or multiple offsets between mapping regions of cpu addrs and
> > dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
> > capable of holding a single uniform offset and had no region bounds
> > checking.
> >
> > The function of_dma_get_range() has been modified so that it takes a single
> > argument -- the device node -- and returns a map, NULL, or an error code.
> > The map is an array that holds the information regarding the DMA regions.
> > Each range entry contains the address offset, the cpu_start address, the
> > dma_start address, and the size of the region.
> >
> > of_dma_configure() is the typical manner to set range offsets but there are
> > a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
> > driver code.  These cases now invoke the function
> > dma_attach_offset_range(dev, cpu_addr, dma_addr, size).
>
> ...
>
> > +     /*
> > +      * Record all info in the generic DMA ranges array for struct device.
> > +      */
> > +     *map = r;
> > +     for_each_of_range(&parser, &range) {
> > +             pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
> > +                      range.bus_addr, range.cpu_addr, range.size);
> > +             r->cpu_start = range.cpu_addr;
> > +             r->dma_start = range.bus_addr;
> > +             r->size = range.size;
>
> > +             r->offset = (u64)range.cpu_addr - (u64)range.bus_addr;
>
> What's the point in explicit castings to the same type?
No point.  If I have to send out another version I will fix this.

>
> > +             r++;
> > +     }
>
> ...
>
> > +             phys_addr_t     paddr;
> > +             dma_addr_t      dma_addr;
> > +             struct device   dev_bogus;
>
> >               unittest(paddr == expect_paddr,
> > -                      "of_dma_get_range wrong phys addr (%llx) on node %pOF", paddr, np);
> > +                      "of_dma_get_range: wrong phys addr %llx (expecting %llx) on node %pOF\n",
> > +                      (u64)paddr, expect_paddr, np);
>
> %llx -> %pap
This was intentional -- I'm aware of %pap and %pad.  The problem is
that %pa[pd]  print out a zero-filled 16 character number regardless
of what the number is.  For example, 1 is "0x0000000000000001",
whereas using %llx yields "1".

>
> >               unittest(dma_addr == expect_dma_addr,
> > -                      "of_dma_get_range wrong DMA addr (%llx) on node %pOF", dma_addr, np);
> > +                      "of_dma_get_range: wrong DMA addr %llx (expecting %llx) on node %pOF\n",
> > +                      (u64)dma_addr, expect_dma_addr, np);
>
> %llx -> %pad
>
> ...
>
> > +     if (mem->use_dev_dma_pfn_offset) {
> > +             u64 base_addr = PFN_PHYS((u64)mem->pfn_base);
>
> Do we need explicit casting here?
I don't think it is needed.  However, the "(u64)" is useless though
since the macro recasts it to a phys_addr_t.

If there is another version of this submission I will change this.
>
> > +
> > +             return base_addr - dma_offset_from_phys_addr(dev, base_addr);
> > +     }
>
> ...
>
> > +int dma_set_offset_range(struct device *dev, phys_addr_t cpu_start,
> > +                      dma_addr_t dma_start, u64 size)
> > +{
> > +     struct bus_dma_region *map;
> > +     u64 offset = (u64)cpu_start - (u64)dma_start;
> > +
> > +     if (dev->dma_range_map) {
> > +             dev_err(dev, "attempt to add DMA range to existing map\n");
> > +             return -EINVAL;
> > +     }
>
> Wouldn't be better to do an assignment of offset here?
IIRC this was what Christoph requested.  It has actually gone back and
forth over the versions of this submission.
>
> > +     if (!offset)
> > +             return 0;
> > +
> > +     map = kcalloc(2, sizeof(*map), GFP_KERNEL);
> > +     if (!map)
> > +             return -ENOMEM;
> > +     map[0].cpu_start = cpu_start;
> > +     map[0].dma_start = dma_start;
> > +     map[0].offset = offset;
> > +     map[0].size = size;
> > +     dev->dma_range_map = map;
> > +
> > +     return 0;
> > +}
>
> --
> With Best Regards,
> Andy Shevchenko
Thanks again,
Jim
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
