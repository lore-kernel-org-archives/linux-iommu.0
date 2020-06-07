Return-Path: <SRS0=qLgg=7U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126CCC433E0
	for <iommu@archiver.kernel.org>; Sun,  7 Jun 2020 16:50:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEC420663
	for <iommu@archiver.kernel.org>; Sun,  7 Jun 2020 16:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEC420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8AF4E203FA;
	Sun,  7 Jun 2020 16:50:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PC2p6YF4Noeb; Sun,  7 Jun 2020 16:50:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2FAB820417;
	Sun,  7 Jun 2020 16:50:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D246C0890;
	Sun,  7 Jun 2020 16:50:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74F9FC016F
 for <iommu@lists.linux-foundation.org>; Sun,  7 Jun 2020 16:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 68FFD87AC9
 for <iommu@lists.linux-foundation.org>; Sun,  7 Jun 2020 16:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMtC0NtVTO+2 for <iommu@lists.linux-foundation.org>;
 Sun,  7 Jun 2020 16:50:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C1DCE87B3E
 for <iommu@lists.linux-foundation.org>; Sun,  7 Jun 2020 16:50:03 +0000 (UTC)
IronPort-SDR: YxvFZETMPpwzkGhmL65NS9uGT+FA1ecRACUppsiRwN2UQW1WIVAij39W5fZSadjUeTRUZLMqUN
 qNTZYSvvjQSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2020 09:50:02 -0700
IronPort-SDR: cl84BUxc7MVy0D5jbGW5p5WLumPGPyO0/ht+OgH+KjkcpV8GyLHJqPiLKSbKWdEf9/itYwkKOh
 Cc1L7twObY7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,484,1583222400"; d="scan'208";a="259620030"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga008.fm.intel.com with ESMTP; 07 Jun 2020 09:49:50 -0700
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1jhyUY-00BUGz-R6; Sun, 07 Jun 2020 19:49:50 +0300
Date: Sun, 7 Jun 2020 19:49:50 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v4 08/12] device core: Introduce multiple dma pfn offsets
Message-ID: <20200607164950.GX2428291@smile.fi.intel.com>
References: <20200605212706.7361-1-james.quinlan@broadcom.com>
 <20200605212706.7361-9-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200605212706.7361-9-james.quinlan@broadcom.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>,
 "open list:SUPERH" <linux-sh@vger.kernel.org>, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
 "open list:REMOTE PROCESSOR \(REMOTEPROC\) SUBSYSTEM"
 <linux-remoteproc@vger.kernel.org>,
 "open list:DRM DRIVERS FOR ALLWINNER A10" <dri-devel@lists.freedesktop.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Julien Grall <julien.grall@arm.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Wolfram Sang <wsa@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Frank Rowand <frowand.list@gmail.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 "open list:ACPI FOR ARM64 \(ACPI/arm64\)" <linux-acpi@vger.kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Ingo Molnar <mingo@redhat.com>,
 bcm-kernel-feedback-list@broadcom.com, Alan Stern <stern@rowland.harvard.edu>,
 Len Brown <lenb@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE"
 <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Dan Williams <dan.j.williams@intel.com>, Maxime Ripard <mripard@kernel.org>,
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
 Mark Brown <broonie@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sudeep Holla <sudeep.holla@arm.com>,
 "open list:ALLWINNER A10 CSI DRIVER" <linux-media@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jun 05, 2020 at 05:26:48PM -0400, Jim Quinlan wrote:
> The new field in struct device 'dma_pfn_offset_map' is used to facilitate
> the use of single or multiple pfn offsets between cpu addrs and dma addrs.
> It subsumes the role of dev->dma_pfn_offset -- a uniform offset.
> 
> The function of_dma_get_range() has been modified to take two additional
> arguments: the "map", which is an array that holds the information
> regarding the pfn offset regions, and map_size, which is the size in bytes
> of the map array.
> 
> of_dma_configure() is the typical manner to set pfn offsets but there are a
> number of ad hoc assignments to dev->dma_pfn_offset in the kernel driver
> code.  These cases now invoke the function
> dma_attach_uniform_pfn_offset(dev, pfn_offset).

...

> +		int ret = dma_attach_uniform_pfn_offset
> +				(dev, keystone_dma_pfn_offset);

It's strange indentation. Have you configured your editor correctly?
Seems to me as fit on one line.

> +		dev_err(dev, "set dma_pfn_offset%08lx%s\n",
> +			dev->dma_pfn_offset, ret ? " failed" : "");

...

> +	*map_size = (num_ranges + 1) * sizeof(**map);
> +	r = kzalloc(*map_size, GFP_KERNEL);

kcalloc()

> +	if (!r)
> +		return -ENOMEM;

...

> +		r->pfn_offset = PFN_DOWN(range.cpu_addr)
> +			- PFN_DOWN(range.bus_addr);

Ditto (indentation).

...


> +		unsigned long dma_pfn_offset
> +			= dma_pfn_offset_from_phys_addr(dev, paddr);

Ditto.

...

> +		unsigned long dma_pfn_offset
> +			= dma_pfn_offset_from_dma_addr(dev, dev_addr);

Ditto.

Check entire your series for a such, please!

-- 
With Best Regards,
Andy Shevchenko


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
