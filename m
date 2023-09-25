Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1F718E01
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 11:15:52 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67847DA7;
	Mon, 25 Sep 2023 04:16:29 -0700 (PDT)
Received: from [10.57.0.188] (unknown [10.57.0.188])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E2BC3F59C;
	Mon, 25 Sep 2023 04:15:50 -0700 (PDT)
Message-ID: <92cd8f47-054c-938a-0dcb-778ed42805ed@arm.com>
Date: Mon, 25 Sep 2023 12:15:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Content-Language: en-GB
To: Kelly Devilliv <kelly.devilliv@outlook.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TY2PR0101MB313681440D640B215C5DF5E784FCA@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <TY2PR0101MB313681440D640B215C5DF5E784FCA@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-09-25 04:59, Kelly Devilliv wrote:
> Dear all,
> 
> I am working on an ARM-V8 server with two gpu cards on it. Recently, I need to test pcie peer to peer communication between the two gpu cards, but the throughput is only 4GB/s.
> 
> After I explored the gpu's kernel mode driver, I found it was using the dma_map_resource() API to map the peer device's MMIO space. The arm iommu driver then will hardcode a 'IOMMU_MMIO' prot in the later dma map:
> 
>         static dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>                                  size_t size, enum dma_data_direction dir, unsigned long attrs)
>          {
>                  return __iommu_dma_map(dev, phys, size,
>                                          dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
>                                          dma_get_mask(dev));
>          }
> 
> And that will finally set the 'ARM_LPAE_PTE_MEMATTR_DEV' attribute in PTE, which may have a negative impact on the performance of the pcie peer to peer transactions.
> 
>          /*
>           * Note that this logic is structured to accommodate Mali LPAE
>           * having stage-1-like attributes but stage-2-like permissions.
>           */
>          if (data->iop.fmt == ARM_64_LPAE_S2 ||
>              data->iop.fmt == ARM_32_LPAE_S2) {
>                  if (prot & IOMMU_MMIO)
>                          pte |= ARM_LPAE_PTE_MEMATTR_DEV;
>                  else if (prot & IOMMU_CACHE)
>                          pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
>                  else
>                          pte |= ARM_LPAE_PTE_MEMATTR_NC;
>          } else {
>                  if (prot & IOMMU_MMIO)
>                          pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
>                                  << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>                  else if (prot & IOMMU_CACHE)
>                          pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>                                  << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>          }
> 
> I tried to remove the 'IOMMU_MMIO' prot in the dma_map_resource() API and re-compile the linux kernel, the throughput then can be up to 28GB/s.
> 
> Is there an elegant way to solve this issue without modifying the linux kernel? e.g., a substitution of dma_map_resource() API?

Not really. Other use-cases for dma_map_resource() include DMA offload 
engines accessing FIFO registers, where allowing reordering, 
write-gathering, etc. would be a terrible idea. Thus it needs to assume 
a "safe" MMIO memory type, which on Arm means Device-nGnRE.

However, the "proper" PCI peer-to-peer support under CONFIG_PCI_P2PDMA 
ended up moving away from the dma_map_resource() approach anyway, and 
allows this kind of device memory to be treated more like regular memory 
(via ZONE_DEVICE) rather than arbitrary MMIO resources, so your best bet 
would be to get the GPU driver converted over to using that.

Thanks,
Robin.

> 
> Thank you!
> 
> Platform info:
> Linux kernel version: 5.10
> PCIE GEN4 x16
> 
> Sincerely,
> Kelly
> 
