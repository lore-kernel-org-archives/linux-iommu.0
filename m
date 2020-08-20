Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48B4C433E1
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 13:37:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F93222B3F
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 13:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Swx1tEOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F93222B3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1CA7A86224;
	Thu, 20 Aug 2020 13:37:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UqjO8aQknkwe; Thu, 20 Aug 2020 13:37:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 687A7861F9;
	Thu, 20 Aug 2020 13:37:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FD38C07FF;
	Thu, 20 Aug 2020 13:37:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E6D8C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 13:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4275987BE3
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 13:37:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AHU85Q-fmWIv for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 13:37:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BF1028639B
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 13:37:26 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id d190so1620722wmd.4
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4+6ADjrPvvoJQXwHRirxRtxpPYB0wJtxuMB6HUjv7UY=;
 b=Swx1tEOMBHi4gqwd5WrKaF9EhsDucF9YFbFUCb3Nq3JX3XsxRj2vR//C1fN8QtRMD9
 u0CeslUmWwoXuhfe2Ek68crFc48Pk0dqQH7F7EKxd4M+fCOAZnRKBfegSKkpUW5N+3RQ
 kh16yovfPlW5wzYfBGmiAgHcsAu5CAFFQv+x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4+6ADjrPvvoJQXwHRirxRtxpPYB0wJtxuMB6HUjv7UY=;
 b=jWnF23iO3qa+Rnw4B+3ukvXKwtl4GVLW43LtQs+OSqVayeexvY0GrLKo6S4sDsCdVw
 CehrJnTGijvPG9bfujuS+gSZA+dD0eb6dS6GW9VtDqlUSqqjUD6iZ4GBIuZe7K98Azg0
 cWlHz+NJonHYTwNm1lQk2Gp9yHyhNmBsbw0d3O/cideyKZG7y3GHOMGjL1Fv5joQ2qWM
 oURXcfVr1IS5oaK4j2FT5b/MztNa2dtxZIGx8XZBP6kVfC5t9lZBnAqtbuBue5Ah8QqB
 GkaSK7DxN0wy7kcLNTPYGAQufJ5GudXl92mfq+nee4SJ9jG6kktihVNX4JezIo68ir2j
 2UWQ==
X-Gm-Message-State: AOAM530p3cqqDa1xzSgBZwxTHkoVnp8MtY+jhTD0/6nZIQTCPaLao9LZ
 8sL1idGTv8NHdI6+8rOFiIv5+aKXI8fPvRoZLk9JTA==
X-Google-Smtp-Source: ABdhPJxWp3xMT2A+UZz4XucmhLWruB83RBp1YSjTxyEIEeN4jQBzlPde+MRBaiWP71APheOu4D0+3NXwfGGj6VU/La4=
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr248078wmj.111.1597930645019; 
 Thu, 20 Aug 2020 06:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200817215326.30912-1-james.quinlan@broadcom.com>
 <20200817215326.30912-8-james.quinlan@broadcom.com>
 <20200818081225.GA1891694@smile.fi.intel.com>
In-Reply-To: <20200818081225.GA1891694@smile.fi.intel.com>
Date: Thu, 20 Aug 2020 09:37:12 -0400
Message-ID: <CA+-6iNwCy1FUKSgjhFnb2L+fYZbcPNjwP0TgLQ-HA_5aqB-tdg@mail.gmail.com>
Subject: Re: [PATCH RESEND v10 07/11] device-mapping: Introduce DMA range map, 
 supplanting dma_pfn_offset
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rich Felker <dalias@libc.org>,
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
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Yong Deng <yong.deng@magewell.com>,
 Santosh Shilimkar <ssantosh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
 Saravana Kannan <saravanak@google.com>,
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

Hi Anday,


On Tue, Aug 18, 2020 at 4:14 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 17, 2020 at 05:53:09PM -0400, Jim Quinlan wrote:
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
> > +     if (dev) {
> > +             phys_addr_t paddr = PFN_PHYS(pfn);
> > +
>
> > +             pfn -= (dma_offset_from_phys_addr(dev, paddr) >> PAGE_SHIFT);
>
> PFN_DOWN() ?
Yep.
>
> > +     }
>
> ...
>
> > +             pfn += (dma_offset_from_dma_addr(dev, addr) >> PAGE_SHIFT);
>
> Ditto.
Yep.
>
>
> ...
>
> > +static inline u64 dma_offset_from_dma_addr(struct device *dev, dma_addr_t dma_addr)
> > +{
> > +     const struct bus_dma_region *m = dev->dma_range_map;
> > +
> > +     if (!m)
> > +             return 0;
> > +     for (; m->size; m++)
> > +             if (dma_addr >= m->dma_start && dma_addr - m->dma_start < m->size)
> > +                     return m->offset;
> > +     return 0;
> > +}
> > +
> > +static inline u64 dma_offset_from_phys_addr(struct device *dev, phys_addr_t paddr)
> > +{
> > +     const struct bus_dma_region *m = dev->dma_range_map;
> > +
> > +     if (!m)
> > +             return 0;
> > +     for (; m->size; m++)
> > +             if (paddr >= m->cpu_start && paddr - m->cpu_start < m->size)
> > +                     return m->offset;
> > +     return 0;
> > +}
>
> Perhaps for these the form with one return 0 is easier to read
>
>         if (m) {
>                 for (; m->size; m++)
>                         if (paddr >= m->cpu_start && paddr - m->cpu_start < m->size)
>                                 return m->offset;
>         }
>         return 0;
>
> ?
I see what you are saying but I don't think there is enough difference
between the two to justify changing it.
>
> ...
>
> > +     if (mem->use_dev_dma_pfn_offset) {
> > +             u64 base_addr = (u64)mem->pfn_base << PAGE_SHIFT;
>
> PFN_PHYS() ?
Yep.

>
> > +
> > +             return base_addr - dma_offset_from_phys_addr(dev, base_addr);
> > +     }
>
> ...
>
> > + * It returns -ENOMEM if out of memory, 0 otherwise.
>
> This doesn't describe cases dev->dma_range_map != NULL and offset == 0.
Okay, I'll fix this.

>
> > +int dma_set_offset_range(struct device *dev, phys_addr_t cpu_start,
> > +                      dma_addr_t dma_start, u64 size)
> > +{
> > +     struct bus_dma_region *map;
> > +     u64 offset = (u64)cpu_start - (u64)dma_start;
> > +
> > +     if (!offset)
> > +             return 0;
> > +
> > +     if (dev->dma_range_map) {
> > +             dev_err(dev, "attempt to add DMA range to existing map\n");
> > +             return -EINVAL;
> > +     }
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
> ...
>
> > +void *dma_copy_dma_range_map(const struct bus_dma_region *map)
> > +{
> > +     int num_ranges;
> > +     struct bus_dma_region *new_map;
> > +     const struct bus_dma_region *r = map;
> > +
> > +     for (num_ranges = 0; r->size; num_ranges++)
> > +             r++;
>
> > +     new_map = kcalloc(num_ranges + 1, sizeof(*map), GFP_KERNEL);
> > +     if (new_map)
> > +             memcpy(new_map, map, sizeof(*map) * num_ranges);
>
> Looks like krealloc() on the first glance...
It's not.  We are making a distinct copy of the original, not resizing it.
>
> > +
> > +     return new_map;
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
