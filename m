Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE59CC433DF
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 09:54:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 884672071E
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 09:54:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 884672071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 573A9864B8;
	Tue, 25 Aug 2020 09:54:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XmdFAKwCvkNn; Tue, 25 Aug 2020 09:54:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C0BE7868F4;
	Tue, 25 Aug 2020 09:54:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB499C016F;
	Tue, 25 Aug 2020 09:54:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9B9FC0051
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 09:54:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 96DC421507
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 09:54:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VCfxQBDam4kK for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 09:54:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 55E5A2046F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 09:54:25 +0000 (UTC)
IronPort-SDR: OmR0heZ2jxG7HhZOz+PW/vkiUODrxQ5RDH97sqtALlIkIHU2uqEOquO92iJ/BpWjzKTssofkJR
 Qbl3mhsiYgdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="153500768"
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; d="scan'208";a="153500768"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2020 02:54:06 -0700
IronPort-SDR: fXpejcZSxOQzAYQmsZusBmHI4H12+oJKHHrXIpgIPlgnPNsjR6YUhbnDxGUVZmoVHxv6yRdqze
 zyT2d6eDyJew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,352,1592895600"; d="scan'208";a="328813544"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by orsmga008.jf.intel.com with ESMTP; 25 Aug 2020 02:53:54 -0700
Received: from andy by smile with local (Exim 4.94)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1kAVVq-00BIMP-3K; Tue, 25 Aug 2020 12:45:06 +0300
Date: Tue, 25 Aug 2020 12:45:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v11 07/11] device-mapping: Introduce DMA range map,
 supplanting dma_pfn_offset
Message-ID: <20200825094506.GR1891694@smile.fi.intel.com>
References: <20200824193036.6033-1-james.quinlan@broadcom.com>
 <20200824193036.6033-8-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824193036.6033-8-james.quinlan@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
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
 Ingo Molnar <mingo@redhat.com>, bcm-kernel-feedback-list@broadcom.com,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Aug 24, 2020 at 03:30:20PM -0400, Jim Quinlan wrote:
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

> +	/*
> +	 * Record all info in the generic DMA ranges array for struct device.
> +	 */
> +	*map = r;
> +	for_each_of_range(&parser, &range) {
> +		pr_debug("dma_addr(%llx) cpu_addr(%llx) size(%llx)\n",
> +			 range.bus_addr, range.cpu_addr, range.size);
> +		r->cpu_start = range.cpu_addr;
> +		r->dma_start = range.bus_addr;
> +		r->size = range.size;

> +		r->offset = (u64)range.cpu_addr - (u64)range.bus_addr;

What's the point in explicit castings to the same type?

> +		r++;
> +	}

...

> +		phys_addr_t	paddr;
> +		dma_addr_t	dma_addr;
> +		struct device	dev_bogus;

>  		unittest(paddr == expect_paddr,
> -			 "of_dma_get_range wrong phys addr (%llx) on node %pOF", paddr, np);
> +			 "of_dma_get_range: wrong phys addr %llx (expecting %llx) on node %pOF\n",
> +			 (u64)paddr, expect_paddr, np);

%llx -> %pap

>  		unittest(dma_addr == expect_dma_addr,
> -			 "of_dma_get_range wrong DMA addr (%llx) on node %pOF", dma_addr, np);
> +			 "of_dma_get_range: wrong DMA addr %llx (expecting %llx) on node %pOF\n",
> +			 (u64)dma_addr, expect_dma_addr, np);

%llx -> %pad

...

> +	if (mem->use_dev_dma_pfn_offset) {
> +		u64 base_addr = PFN_PHYS((u64)mem->pfn_base);

Do we need explicit casting here?

> +
> +		return base_addr - dma_offset_from_phys_addr(dev, base_addr);
> +	}

...

> +int dma_set_offset_range(struct device *dev, phys_addr_t cpu_start,
> +			 dma_addr_t dma_start, u64 size)
> +{
> +	struct bus_dma_region *map;
> +	u64 offset = (u64)cpu_start - (u64)dma_start;
> +
> +	if (dev->dma_range_map) {
> +		dev_err(dev, "attempt to add DMA range to existing map\n");
> +		return -EINVAL;
> +	}

Wouldn't be better to do an assignment of offset here?

> +	if (!offset)
> +		return 0;
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

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
