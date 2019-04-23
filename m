From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an
 IOMMU cookie
Date: Tue, 23 Apr 2019 12:46:42 +0100
Message-ID: <48d14d10-0484-a7dd-cd84-a933158906ff@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
 <20190418172611.21561-2-julien.grall@arm.com>
 <7e77331c-4adf-5bb4-0c23-4d01a6ac5ab4@arm.com>
 <1bcdb72f-2116-756b-b74d-a48f89870782@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1bcdb72f-2116-756b-b74d-a48f89870782@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Grall <julien.grall@arm.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 23/04/2019 11:51, Julien Grall wrote:
> On 4/23/19 11:23 AM, Marc Zyngier wrote:
>> Hi Julien,
> 
> Hi Marc,
> 
>> On 18/04/2019 18:26, Julien Grall wrote:
>>> When an MSI doorbell is located downstream of an IOMMU, it is required
>>> to swizzle the physical address with an appropriately-mapped IOVA for any
>>> device attached to one of our DMA ops domain.
>>>
>>> At the moment, the allocation of the mapping may be done when composing
>>> the message. However, the composing may be done in non-preemtible
>>> context while the allocation requires to be called from preemptible
>>> context.
>>>
>>> A follow-up patch will split the current logic in two functions
>>> requiring to keep an IOMMU cookie per MSI.
>>>
>>> This patch introduces a new field in msi_desc to store an IOMMU cookie
>>> when CONFIG_IOMMU_DMA is selected.
>>>
>>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>> ---
>>>   include/linux/msi.h | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>>> index 7e9b81c3b50d..d7907feef1bb 100644
>>> --- a/include/linux/msi.h
>>> +++ b/include/linux/msi.h
>>> @@ -77,6 +77,9 @@ struct msi_desc {
>>>   	struct device			*dev;
>>>   	struct msi_msg			msg;
>>>   	struct irq_affinity_desc	*affinity;
>>> +#ifdef CONFIG_IOMMU_DMA
>>> +	const void			*iommu_cookie;
>>> +#endif
>>>   
>>>   	union {
>>>   		/* PCI MSI/X specific data */
>>>
>>
>> Given that this is the only member in this structure that is dependent
>> on a config option, you could also add a couple of accessors that would
>> do nothing when IOMMU_DMA is not selected (and use that in the DMA code).
> 
> I haven't seen any use of the helpers so far because the DMA code is 
> also protected by IOMMU_DMA.
> 
> I can add the helpers in the next version if you see any use outside of 
> the DMA code.

There may not be any user user yet, but I'd surely like to see the
accessors. This isn't very different from the stub functions you add in
patch #2.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
