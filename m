Return-Path: <SRS0=S+y3=AR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B86C433DF
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:40:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79EAD206F5
	for <iommu@archiver.kernel.org>; Mon,  6 Jul 2020 13:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N7LoSn2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79EAD206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 54540876D2;
	Mon,  6 Jul 2020 13:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L09ue-X48iAN; Mon,  6 Jul 2020 13:40:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B5626876C3;
	Mon,  6 Jul 2020 13:40:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94638C0893;
	Mon,  6 Jul 2020 13:40:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99003C016F
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 91CF288CA8
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t4xJsm1F+fAn for <iommu@lists.linux-foundation.org>;
 Mon,  6 Jul 2020 13:40:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E733688C81
 for <iommu@lists.linux-foundation.org>; Mon,  6 Jul 2020 13:40:53 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id g75so39393592wme.5
 for <iommu@lists.linux-foundation.org>; Mon, 06 Jul 2020 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eYvPzaHZaaIgS61ZLjNpzen4uwKKezR2/OOrkoRIMZ0=;
 b=N7LoSn2vo9f3rQ4C2sGL7jY5i3u8il6SSYurszDcNXG4RDiQXye4oDe1w49wUKWGYU
 6YR9e3/7mWBT1uSXTqg4XPCPLbecgJ9K1U+X0Y65YB3vsKNWZaer91W4nyZCnw9XANrU
 W4Go14plLioc6jwPxUMtBUxX76ky2Nqwf5ejw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eYvPzaHZaaIgS61ZLjNpzen4uwKKezR2/OOrkoRIMZ0=;
 b=bWC3l4tSnQtJL6lxLdE0Yh7Jtm2UUJCm1owe7uHtnRAtOGM1yFgRLuofAnALm0o+ju
 XMNx0HCGjmerbDHxE1V+GbHujlD85fjck2G3+23WZkMdCsqUdz6YRkR02RN9xBAzZm+b
 624IOc2YZU885BqMx1MbwFNK8/KgIGTR2xIzJ30OeOgDs5FCXQRASQh1muOEq8u5fdgl
 HhMy3ckGC1hav7vY9HvuMOjMOKtXVRAhrCbj8iX6iVNh3Z/Q6BogYe/tidYlDq6+1CzV
 avtUM3L4abQ/mhG4o2DIqP3rWagtbxC6XzCs7mW1wAVbplAQ5iM+nDpiTNVX5AC48ccd
 W4Cg==
X-Gm-Message-State: AOAM532dpWF6D9Q5aTPLmA06c6DVsIcUsE23f9bkz8H+rYEdMNLHteYV
 VObc54ulNMXw6b7MicoAJ8/KSPVvYvcLwWZrBvkAJw==
X-Google-Smtp-Source: ABdhPJzJbQzeNPTuNOMHMff7aCJzGErvjO7pRBT5QzydRbyBwpY7TNg0ejysnilGn10ahFrXSo1oMtnUeWRwgRrZDag=
X-Received: by 2002:a7b:c185:: with SMTP id y5mr51495722wmi.85.1594042852077; 
 Mon, 06 Jul 2020 06:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200701212155.37830-1-james.quinlan@broadcom.com>
 <20200701212155.37830-9-james.quinlan@broadcom.com>
 <20200702084251.GF3703480@smile.fi.intel.com>
In-Reply-To: <20200702084251.GF3703480@smile.fi.intel.com>
Date: Mon, 6 Jul 2020 09:40:40 -0400
Message-ID: <CA+-6iNwu-jHTb7VFpmkYoyipWK9rtTEOq2dW7K=nYXpUrOTwCQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Julien Grall <julien.grall@arm.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>,
 Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>,
 Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Yong Deng <yong.deng@magewell.com>, Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 open list <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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

Sorry for the delay in response.  I will do what you suggest in your
email.  I do have one response to one of your comments below.

On Thu, Jul 2, 2020 at 4:43 AM Andy Shevchenko
<andriy.shevchenko@linux.intePHYSl.com> wrote:
>
> On Wed, Jul 01, 2020 at 05:21:38PM -0400, Jim Quinlan wrote:
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
> > +     if (dev && dev->dma_range_map)
> > +             pfn -= (unsigned long)PFN_DOWN(dma_offset_from_phys_addr(dev, PFN_PHYS(pfn)));
>
> Instead of casting use PHYS_PFN() and it will be consistent with latter in the same line.
>
> > +     if (dev && dev->dma_range_map)
> > +             pfn += (unsigned long)PFN_DOWN(dma_offset_from_dma_addr(dev, addr));
>
> Ditto.
>
> ...
>
> > +             dev_err(dev, "set dma_offset%08llx%s\n", KEYSTONE_HIGH_PHYS_START
> > +                     - KEYSTONE_LOW_PHYS_START, ret ? " failed" : "");
>
> Please, avoid such indentation.
> Better split it to the three lines, argument per line (expect dev which will go
> on the first one).
>
> This applies to all similar places.
>
> ...
>
> >       unsigned long pfn = (dma_handle >> PAGE_SHIFT);
>
> PHYS_PFN() / PFN_DOWN() ?
>
> > +     if (!WARN_ON(!dev) && dev->dma_range_map)
> > +             pfn += (unsigned long)PFN_DOWN(dma_offset_from_dma_addr(dev, dma_handle));
>
> PHYS_PFN() ?
>
> ...
>
> > +     r = kcalloc(num_ranges + 1, sizeof(struct bus_dma_region), GFP_KERNEL);
>
> sizeof(*r) ?
>
> > +     if (!r)
> > +             return ERR_PTR(-ENOMEM);
>
> ...
>
> > +     ret = IS_ERR(map) ? PTR_ERR(map) : 0;
>
> PTR_ERR_OR_ZERO()
>
> ...
>
> > +             /* We want the offset map to be device-managed, so alloc & copy */
> > +             dev->dma_range_map = devm_kcalloc(dev, num_ranges + 1, sizeof(*r),
> > +                                               GFP_KERNEL);
>
> The question is how many times per device lifetime this can be called?
Someone else questioned this.  There are two cases that come to mind:
our overnight test which load/unloads the RC driver over and over, and
a customer that does an unbind/bind  of the RC driver when their EP is
hung and wants to restart.  Both cases are atypical and are weak
arguments to justify the second copy.  I will drop the copy.

Thanks,
Jim Quinlan
Broadcom STB
>
> ...
>
>
> > +             if (!dev->dma_range_map)
> > +                     return -ENOMEM;
> > +             memcpy((void *)dev->dma_range_map, map, sizeof(*r) * num_ranges + 1);
>
> If it's continuous, perhaps kmemdup() ?
>
> ...
>
> > +     rc = IS_ERR(map) ? PTR_ERR(map) : 0;
>
> PTR_ERR_OR_ZERO()
>
> ...
>
> > +                     = dma_offset_from_phys_addr(dev, PFN_PHYS(mem->pfn_base));
> > +
> > +             return (dma_addr_t)PFN_PHYS(mem->pfn_base) - dma_offset;
>
> Looking at this more, I think you need to introduce in the same header (pfn.h)
> something like:
>
>         #define PFN_DMA_ADDR()
>         #define DMA_ADDR_PFN()
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
