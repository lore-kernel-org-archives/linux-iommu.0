Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4CDC433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 20:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6761A40C57;
	Thu, 21 Apr 2022 20:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nS0OzIf28p8A; Thu, 21 Apr 2022 20:51:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 32985405D8;
	Thu, 21 Apr 2022 20:51:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD18BC007F;
	Thu, 21 Apr 2022 20:51:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A74FC007A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 20:51:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 76DA641812
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 20:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u8lFXv4ISvaq for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 20:51:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1E18E417CE
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 20:51:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDBE31477;
 Thu, 21 Apr 2022 13:51:41 -0700 (PDT)
Received: from [10.57.80.98] (unknown [10.57.80.98])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B30B3F5A1;
 Thu, 21 Apr 2022 13:51:38 -0700 (PDT)
Message-ID: <f238af77-be5e-43cc-6a8c-338408c1667e@arm.com>
Date: Thu, 21 Apr 2022 21:51:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account in
 resource mapping
Content-Language: en-GB
To: Serge Semin <fancer.lancer@gmail.com>, Christoph Hellwig <hch@lst.de>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
 <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
 <20220420084746.GA11606@lst.de>
 <20220420085538.imgibqcyupvvjpaj@mobilestation>
 <20220421144536.GA23289@lst.de>
 <20220421173523.ig62jtvj7qbno6q7@mobilestation>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220421173523.ig62jtvj7qbno6q7@mobilestation>
Cc: Rob Herring <robh@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
 linux-kernel@vger.kernel.org,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux-foundation.org,
 Vinod Koul <vkoul@kernel.org>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 dmaengine@vger.kernel.org, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Jingoo Han <jingoohan1@gmail.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-04-21 18:35, Serge Semin wrote:
> On Thu, Apr 21, 2022 at 04:45:36PM +0200, Christoph Hellwig wrote:
>> On Wed, Apr 20, 2022 at 11:55:38AM +0300, Serge Semin wrote:
>>> On Wed, Apr 20, 2022 at 10:47:46AM +0200, Christoph Hellwig wrote:
>>>> I can't really comment on the dma-ranges exlcusion for P2P mappings,
>>>> as that predates my involvedment, however:
>>>
>>> My example wasn't specific to the PCIe P2P transfers, but about PCIe
>>> devices reaching some platform devices over the system interconnect
>>> bus.
>>
>> So strike PCIe, but this our definition of Peer to Peer accesses.
>>
>>> What if I get to have a physical address of a platform device and want
>>> have that device being accessed by a PCIe peripheral device? The
>>> dma_map_resource() seemed very much suitable for that. But considering
>>> what you say it isn't.
>>
> 
>> dma_map_resource is the right thing for that.  But the physical address
>> of MMIO ranges in the platform device should not have struct pages
>> allocated for it, and thus the other dma_map_* APIs should not work on
>> it to start with.
> 
> The problem is that the dma_map_resource() won't work for that, but
> presumably the dma_map_sg()-like methods will (after some hacking with
> the phys address, but anyway). Consider the system diagram in my
> previous email. Here is what I would do to initialize a DMA
> transaction between a platform device and a PCIe peripheral device:
> 
> 1) struct resource *rsc = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);
> 
> 2) dma_addr_t dar = dma_map_resource(&pci_dev->dev, rsc->start, rsc->end - rsc->start + 1,
>                                        DMA_FROM_DEVICE, 0);
> 
> 3) dma_addr_t sar;
>     void *tmp = dma_alloc_coherent(&pci_dev->dev, PAGE_SIZE, &sar, GFP_KERNEL);
>     memset(tmp, 0xaa, PAGE_SIZE);
> 
> 4) PCIe device: DMA.DAR=dar, DMA.SAR=sar. RUN.
> 
> If there is no dma-ranges specified in the PCIe Host controller
> DT-node, the PCIe peripheral devices will see the rest of the system
> memory as is (no offsets and remappings). But if there is dma-ranges
> with some specific system settings it may affect the PCIe MRd/MWr TLPs
> address translation including the addresses targeted to the MMIO
> space. In that case the mapping performed on step 2) will return a
> wrong DMA-address since the corresponding dma_direct_map_resource()
> just returns the passed physical address missing the
> 'pci_dev->dma_range_map'-based mapping performed in
> translate_phys_to_dma().
> 
> Note the mapping on step 3) works correctly because it calls the
> translate_phys_to_dma() of the direct DMA interface thus taking the
> PCie dma-ranges into account.
> 
> To sum up as I see it either restricting dma_map_resource() to map
> just the intra-bus addresses was wrong or there must be some
> additional mapping infrastructure for the denoted systems. Though I
> don't see a way the dma_map_resource() could be fixed to be suitable
> for each considered cases.

FWIW the current semantics of dma_map_resource() are basically just to 
insert IOMMU awareness where dmaengine drivers were previously just 
casting phys_addr_t to dma_addr_t (or u32, or whatever else they put 
into their descriptor/register/etc.) IIRC there was a bit of a question 
whether it really belonged in the DMA API at all, since it's not really 
a "DMA" operation in the conventional sense, and convenience was the 
only real deciding argument. The relevant drivers at the time were not 
taking dma_pfn_offset into account when consuming physical addresses 
directly, so the new API didn't either.

That's just how things got to where they are today. Once again, I'm not 
saying that what we have now is necessarily right, or that your change 
is necessarily wrong, I just really want to understand specifically 
*why* you need to make it, so we can evaluate the risk of possible 
breakage either way. Theoretical "if"s aren't really enough.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
