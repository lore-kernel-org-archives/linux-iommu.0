Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B684C433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 08:35:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F436207DA
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 08:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F436207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C0D0A22D0D;
	Fri, 21 Aug 2020 08:35:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gxEfukVcDADZ; Fri, 21 Aug 2020 08:35:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4D94320448;
	Fri, 21 Aug 2020 08:35:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E3BFC07FF;
	Fri, 21 Aug 2020 08:35:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 516AFC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 08:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 35D338853D
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 08:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rFm9IBAjj8cg for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:35:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 684BC8065F
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 08:35:30 +0000 (UTC)
IronPort-SDR: sT/em1bXOvVsb+sTJ8B4JQGQdf1oVP/Rxj5xtB1VlfweU9hXCLl/euE0Ow/9XmUEuQyJ0IJrVu
 W3ZFfyPxZmJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="240310875"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="240310875"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 01:35:29 -0700
IronPort-SDR: sFEKwv6y/kLUfJd0c/oiHtZBJBdoOxUSjHH+8M4J6WHXjAjmPnpfKPCWAHeow4nT3yt/VMUMRr
 IMpAxfbWC23A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="327705580"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 01:35:17 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1k920K-00AHyO-Ln; Fri, 21 Aug 2020 11:02:28 +0300
Date: Fri, 21 Aug 2020 11:02:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH RESEND v10 07/11] device-mapping: Introduce DMA range
 map, supplanting dma_pfn_offset
Message-ID: <20200821080228.GF1891694@smile.fi.intel.com>
References: <20200817215326.30912-1-james.quinlan@broadcom.com>
 <20200817215326.30912-8-james.quinlan@broadcom.com>
 <20200818081225.GA1891694@smile.fi.intel.com>
 <CA+-6iNwCy1FUKSgjhFnb2L+fYZbcPNjwP0TgLQ-HA_5aqB-tdg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+-6iNwCy1FUKSgjhFnb2L+fYZbcPNjwP0TgLQ-HA_5aqB-tdg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Aug 20, 2020 at 09:37:12AM -0400, Jim Quinlan wrote:
> On Tue, Aug 18, 2020 at 4:14 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Aug 17, 2020 at 05:53:09PM -0400, Jim Quinlan wrote:

...

> > > +static inline u64 dma_offset_from_dma_addr(struct device *dev, dma_addr_t dma_addr)
> > > +{
> > > +     const struct bus_dma_region *m = dev->dma_range_map;
> > > +
> > > +     if (!m)
> > > +             return 0;
> > > +     for (; m->size; m++)
> > > +             if (dma_addr >= m->dma_start && dma_addr - m->dma_start < m->size)
> > > +                     return m->offset;
> > > +     return 0;
> > > +}
> > > +
> > > +static inline u64 dma_offset_from_phys_addr(struct device *dev, phys_addr_t paddr)
> > > +{
> > > +     const struct bus_dma_region *m = dev->dma_range_map;
> > > +
> > > +     if (!m)
> > > +             return 0;
> > > +     for (; m->size; m++)
> > > +             if (paddr >= m->cpu_start && paddr - m->cpu_start < m->size)
> > > +                     return m->offset;
> > > +     return 0;
> > > +}
> >
> > Perhaps for these the form with one return 0 is easier to read
> >
> >         if (m) {
> >                 for (; m->size; m++)
> >                         if (paddr >= m->cpu_start && paddr - m->cpu_start < m->size)
> >                                 return m->offset;
> >         }
> >         return 0;
> >
> > ?
> I see what you are saying but I don't think there is enough difference
> between the two to justify changing it.

The difference is that you have return 0 / non-0 cases one each. I think it's
slightly easier to read and understand, but it's up to you.

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
