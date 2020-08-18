Return-Path: <SRS0=kAxJ=B4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41713C433E1
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 08:14:56 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108D02075E
	for <iommu@archiver.kernel.org>; Tue, 18 Aug 2020 08:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108D02075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BEEB38620B;
	Tue, 18 Aug 2020 08:14:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3RQzawSmXBD; Tue, 18 Aug 2020 08:14:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B3416861A0;
	Tue, 18 Aug 2020 08:14:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B473C088B;
	Tue, 18 Aug 2020 08:14:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B4CEC0051
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 08:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 38BD7861A0
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 08:14:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s1CQKZgogJaU for <iommu@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 08:14:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 25D0D85D5C
 for <iommu@lists.linux-foundation.org>; Tue, 18 Aug 2020 08:14:52 +0000 (UTC)
IronPort-SDR: yOAqBGKfc5SSKfc/33HUhF9zE2gHNFqRdy0Sa8CfL+73J2yfR2oPvoM/BXzipXrLhrqtUT9tsH
 YTBts9h3rLMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154833686"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; d="scan'208";a="154833686"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2020 01:14:51 -0700
IronPort-SDR: dB+c55XC1WBWGCLhQBHPI/euik22wV/4UDZn1cU4j8QmPIipA3o1tbORCrLMTQGmlVLc3gCOT3
 0Cr/14sf3SbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; d="scan'208";a="326661740"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 01:14:39 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1k7wjJ-009bPd-AQ; Tue, 18 Aug 2020 11:12:25 +0300
Date: Tue, 18 Aug 2020 11:12:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH RESEND v10 07/11] device-mapping: Introduce DMA range
 map, supplanting dma_pfn_offset
Message-ID: <20200818081225.GA1891694@smile.fi.intel.com>
References: <20200817215326.30912-1-james.quinlan@broadcom.com>
 <20200817215326.30912-8-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200817215326.30912-8-james.quinlan@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
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
 bcm-kernel-feedback-list@broadcom.com, Alan Stern <stern@rowland.harvard.edu>,
 Len Brown <lenb@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
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

On Mon, Aug 17, 2020 at 05:53:09PM -0400, Jim Quinlan wrote:
> The new field 'dma_range_map' in struct device is used to facilitate the
> use of single or multiple offsets between mapping regions of cpu addrs and
> dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
> capable of holding a single uniform offset and had no region bounds
> checking.
> 
> The function of_dma_get_range() has been modified so that it takes a single
> argument -- the device node -- and returns a map, NULL, or an error code.
> The map is an array that holds the information regarding the DMA regions.
> Each range entry contains the address offset, the cpu_start address, the
> dma_start address, and the size of the region.
> 
> of_dma_configure() is the typical manner to set range offsets but there are
> a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
> driver code.  These cases now invoke the function
> dma_attach_offset_range(dev, cpu_addr, dma_addr, size).

...

> +	if (dev) {
> +		phys_addr_t paddr = PFN_PHYS(pfn);
> +

> +		pfn -= (dma_offset_from_phys_addr(dev, paddr) >> PAGE_SHIFT);

PFN_DOWN() ?

> +	}

...

> +		pfn += (dma_offset_from_dma_addr(dev, addr) >> PAGE_SHIFT);

Ditto.


...

> +static inline u64 dma_offset_from_dma_addr(struct device *dev, dma_addr_t dma_addr)
> +{
> +	const struct bus_dma_region *m = dev->dma_range_map;
> +
> +	if (!m)
> +		return 0;
> +	for (; m->size; m++)
> +		if (dma_addr >= m->dma_start && dma_addr - m->dma_start < m->size)
> +			return m->offset;
> +	return 0;
> +}
> +
> +static inline u64 dma_offset_from_phys_addr(struct device *dev, phys_addr_t paddr)
> +{
> +	const struct bus_dma_region *m = dev->dma_range_map;
> +
> +	if (!m)
> +		return 0;
> +	for (; m->size; m++)
> +		if (paddr >= m->cpu_start && paddr - m->cpu_start < m->size)
> +			return m->offset;
> +	return 0;
> +}

Perhaps for these the form with one return 0 is easier to read

	if (m) {
		for (; m->size; m++)
			if (paddr >= m->cpu_start && paddr - m->cpu_start < m->size)
				return m->offset;
	}
	return 0;

?

...

> +	if (mem->use_dev_dma_pfn_offset) {
> +		u64 base_addr = (u64)mem->pfn_base << PAGE_SHIFT;

PFN_PHYS() ?

> +
> +		return base_addr - dma_offset_from_phys_addr(dev, base_addr);
> +	}

...

> + * It returns -ENOMEM if out of memory, 0 otherwise.

This doesn't describe cases dev->dma_range_map != NULL and offset == 0.

> +int dma_set_offset_range(struct device *dev, phys_addr_t cpu_start,
> +			 dma_addr_t dma_start, u64 size)
> +{
> +	struct bus_dma_region *map;
> +	u64 offset = (u64)cpu_start - (u64)dma_start;
> +
> +	if (!offset)
> +		return 0;
> +
> +	if (dev->dma_range_map) {
> +		dev_err(dev, "attempt to add DMA range to existing map\n");
> +		return -EINVAL;
> +	}
> +
> +	map = kcalloc(2, sizeof(*map), GFP_KERNEL);
> +	if (!map)
> +		return -ENOMEM;
> +	map[0].cpu_start = cpu_start;
> +	map[0].dma_start = dma_start;
> +	map[0].offset = offset;
> +	map[0].size = size;
> +	dev->dma_range_map = map;
> +
> +	return 0;
> +}

...

> +void *dma_copy_dma_range_map(const struct bus_dma_region *map)
> +{
> +	int num_ranges;
> +	struct bus_dma_region *new_map;
> +	const struct bus_dma_region *r = map;
> +
> +	for (num_ranges = 0; r->size; num_ranges++)
> +		r++;

> +	new_map = kcalloc(num_ranges + 1, sizeof(*map), GFP_KERNEL);
> +	if (new_map)
> +		memcpy(new_map, map, sizeof(*map) * num_ranges);

Looks like krealloc() on the first glance...

> +
> +	return new_map;
> +}

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
