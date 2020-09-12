Return-Path: <SRS0=7x6w=CV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B889C43461
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 06:46:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE802214D8
	for <iommu@archiver.kernel.org>; Sat, 12 Sep 2020 06:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE802214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 784F720422;
	Sat, 12 Sep 2020 06:46:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lbtNs6ka9HLH; Sat, 12 Sep 2020 06:46:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E304820415;
	Sat, 12 Sep 2020 06:46:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C79F6C0859;
	Sat, 12 Sep 2020 06:46:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F9F4C0051
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 06:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0391587530
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 06:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q2JAzojUrZyf for <iommu@lists.linux-foundation.org>;
 Sat, 12 Sep 2020 06:46:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D48686F7A
 for <iommu@lists.linux-foundation.org>; Sat, 12 Sep 2020 06:46:30 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id EB2A368B02; Sat, 12 Sep 2020 08:46:24 +0200 (CEST)
Date: Sat, 12 Sep 2020 08:46:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/3] dma-mapping: introduce DMA range map, supplanting
 dma_pfn_offset
Message-ID: <20200912064624.GA19260@lst.de>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-4-hch@lst.de>
 <011dea58-3714-3343-c055-57228be2a450@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <011dea58-3714-3343-c055-57228be2a450@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org
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

On Fri, Sep 11, 2020 at 05:12:36PM +0100, Robin Murphy wrote:
> (apologies to Jim - I did look through one of the previous versions since I 
> last commented and thought it looked OK, but never actually replied as 
> such)
>
> On 2020-09-10 06:40, Christoph Hellwig wrote:
>> From: Jim Quinlan <james.quinlan@broadcom.com>
>>
>> The new field 'dma_range_map' in struct device is used to facilitate the
>> use of single or multiple offsets between mapping regions of cpu addrs and
>> dma addrs.  It subsumes the role of "dev->dma_pfn_offset" which was only
>> capable of holding a single uniform offset and had no region bounds
>> checking.
>>
>> The function of_dma_get_range() has been modified so that it takes a single
>> argument -- the device node -- and returns a map, NULL, or an error code.
>> The map is an array that holds the information regarding the DMA regions.
>> Each range entry contains the address offset, the cpu_start address, the
>> dma_start address, and the size of the region.
>>
>> of_dma_configure() is the typical manner to set range offsets but there are
>> a number of ad hoc assignments to "dev->dma_pfn_offset" in the kernel
>> driver code.  These cases now invoke the function
>> dma_attach_offset_range(dev, cpu_addr, dma_addr, size).
>
> This is now called dma_direct_set_offset(), right?

Yes.

>> +		int ret = dma_direct_set_offset(dev, KEYSTONE_HIGH_PHYS_START,
>> +						KEYSTONE_LOW_PHYS_START,
>> +						KEYSTONE_HIGH_PHYS_SIZE);
>> +		dev_err(dev, "set dma_offset%08llx%s\n",
>> +			KEYSTONE_HIGH_PHYS_START - KEYSTONE_LOW_PHYS_START,
>> +			ret ? " failed" : "");
>
> FWIW I've already been thinking of some optimisations which would have the 
> happy side-effect of removing many of these allocation failure scenarios, 
> but at this point I reckon it's more practical to just get the current 
> implementation landed and working.

Given that no one deals or can easily deal with these failures we
should probably take care of that.  IMHO we could just allocate a
single static range and point all the devices to it, what would
you think of that?

>>   @@ -811,8 +812,13 @@ static int sun4i_backend_bind(struct device *dev, 
>> struct device *master,
>>   		 * because of an old DT, we need to set the DMA offset by hand
>>   		 * on our device since the RAM mapping is at 0 for the DMA bus,
>>   		 * unlike the CPU.
>> +		 *
>> +		 * XXX(hch): this has no business in a driver and needs to move
>> +		 * to the device tree.
>
> As the context implies, this has actually grown a proper DT description of 
> the funky interconnect layout (see 564d6fd611f9 and the linked patch 
> series), and this is just an ugly fallback path to prevent regressions with 
> old DTBs that are already out there. So unless you can fire up the time 
> machine to fix those, this extra comment is really just beating a dead 
> horse :(

Well, I need to beat the dead horse to avoid having to export the
function, which will really just bread new users.  So at the minimum
we'd need to move the setup to platform code that is always built in.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
