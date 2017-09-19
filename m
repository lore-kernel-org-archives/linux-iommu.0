From: Tomasz Nowicki <tnowicki@caviumnetworks.com>
Subject: Re: [PATCH 1/1] iommu/iova: Make rcache flush optional on IOVA
 allocation failure
Date: Tue, 19 Sep 2017 10:03:47 +0200
Message-ID: <5632227b-3d9b-0f03-db3d-2b2d7ccc8079@caviumnetworks.com>
References: <1505732214-9052-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
 <1505732214-9052-2-git-send-email-tomasz.nowicki@caviumnetworks.com>
 <250f41c9-fb37-49b7-c336-68e163f77e16@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <250f41c9-fb37-49b7-c336-68e163f77e16@arm.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>, joro@8bytes.org, will.deacon@arm.com
Cc: lorenzo.pieralisi@arm.com, Jayachandran.Nair@cavium.com, Ganapatrao.Kulkarni@cavium.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Nate Watterson <nwatters@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 18.09.2017 18:02, Robin Murphy wrote:
> Hi Tomasz,
> 
> On 18/09/17 11:56, Tomasz Nowicki wrote:
>> Since IOVA allocation failure is not unusual case we need to flush
>> CPUs' rcache in hope we will succeed in next round.
>>
>> However, it is useful to decide whether we need rcache flush step because
>> of two reasons:
>> - Not scalability. On large system with ~100 CPUs iterating and flushing
>>    rcache for each CPU becomes serious bottleneck so we may want to deffer it.
>> - free_cpu_cached_iovas() does not care about max PFN we are interested in.
>>    Thus we may flush our rcaches and still get no new IOVA like in the
>>    commonly used scenario:
>>
>>      if (dma_limit > DMA_BIT_MASK(32) && dev_is_pci(dev))
>>          iova = alloc_iova_fast(iovad, iova_len, DMA_BIT_MASK(32) >> shift);
>>
>>      if (!iova)
>>          iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift);
>>
>>     1. First alloc_iova_fast() call is limited to DMA_BIT_MASK(32) to get
>>        PCI devices a SAC address
>>     2. alloc_iova() fails due to full 32-bit space
>>     3. rcaches contain PFNs out of 32-bit space so free_cpu_cached_iovas()
>>        throws entries away for nothing and alloc_iova() fails again
>>     4. Next alloc_iova_fast() call cannot take advantage of rcache since we
>>        have just defeated caches. In this case we pick the slowest option
>>        to proceed.
>>
>> This patch reworks flushed_rcache local flag to be additional function
>> argument instead and control rcache flush step. Also, it updates all users
>> to do the flush as the last chance.
> 
> Looks like you've run into the same thing Nate found[1] - I came up with
> almost the exact same patch, only with separate alloc_iova_fast() and
> alloc_iova_fast_noretry() wrapper functions, but on reflection, just
> exposing the bool to callers is probably simpler. One nit, can you
> document it in the kerneldoc comment too? With that:
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks! I will add missing comment.

Tomasz
