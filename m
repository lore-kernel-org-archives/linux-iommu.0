Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A8AC433FE
	for <iommu@archiver.kernel.org>; Thu, 24 Mar 2022 11:30:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C857A60E54;
	Thu, 24 Mar 2022 11:30:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6I7Qu-fPsGBO; Thu, 24 Mar 2022 11:30:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A3D0960E2C;
	Thu, 24 Mar 2022 11:30:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 707DAC0012;
	Thu, 24 Mar 2022 11:30:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0986BC000B
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 11:30:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA5274103D
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 11:30:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qdgJkEfip22O for <iommu@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 11:30:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id BF55A400A6
 for <iommu@lists.linux-foundation.org>; Thu, 24 Mar 2022 11:30:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B74C511FB;
 Thu, 24 Mar 2022 04:30:45 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D247D3F73D;
 Thu, 24 Mar 2022 04:30:42 -0700 (PDT)
Message-ID: <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
Date: Thu, 24 Mar 2022 11:30:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account in
 resource mapping
Content-Language: en-GB
To: Serge Semin <Sergey.Semin@baikalelectronics.ru>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Vinod Koul <vkoul@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Vladimir Murzin <vladimir.murzin@arm.com>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 iommu@lists.linux-foundation.org,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 dmaengine@vger.kernel.org
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

On 2022-03-24 01:48, Serge Semin wrote:
> A basic device-specific linear memory mapping was introduced back in
> commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
> preserved in the device.dma_pfn_offset field, which was initialized for
> instance by means of the "dma-ranges" DT property. Afterwards the
> functionality was extended to support more than one device-specific region
> defined in the device.dma_range_map list of maps. But all of these
> improvements concerned a single pointer, page or sg DMA-mapping methods,
> while the system resource mapping function turned to miss the
> corresponding modification. Thus the dma_direct_map_resource() method now
> just casts the CPU physical address to the device DMA address with no
> dma-ranges-based mapping taking into account, which is obviously wrong.
> Let's fix it by using the phys_to_dma_direct() method to get the
> device-specific bus address from the passed memory resource for the case
> of the directly mapped DMA.

It may not have been well-documented at the time, but this was largely 
intentional. The assumption based on known systems was that where 
dma_pfn_offset existed, it would *not* apply to peer MMIO addresses.

For instance, DTs for TI Keystone 2 platforms only describe an offset 
for RAM:

	dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;

but a DMA controller might also want to access something in the MMIO 
range 0x0-0x7fffffff, of which it still has an identical non-offset 
view. If a driver was previously using dma_map_resource() for that, it 
would now start getting DMA_MAPPING_ERROR because the dma_range_map 
exists but doesn't describe the MMIO region. I agree that in hindsight 
it's not an ideal situation, but it's how things have ended up, so at 
this point I'm wary of making potentially-breaking changes.

May I ask what exactly your setup looks like, if you have a DMA 
controller with an offset view of its "own" MMIO space?

Thanks,
Robin.

> Fixes: 25f1e1887088 ("dma: Take into account dma_pfn_offset")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>   kernel/dma/direct.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 50f48e9e4598..9ce8192b29ab 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -497,7 +497,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs)
>   {
> -	dma_addr_t dma_addr = paddr;
> +	dma_addr_t dma_addr = phys_to_dma_direct(dev, paddr);
>   
>   	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
>   		dev_err_once(dev,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
