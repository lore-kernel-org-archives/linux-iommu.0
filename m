From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 4/7] irqchip/gic-v3-its: Don't map the MSI page in
 its_irq_compose_msi_msg()
Date: Wed, 1 May 2019 12:37:52 +0100
Message-ID: <7235739f-4485-6b6b-e995-7c8bdfab9b28@arm.com>
References: <20190429144428.29254-1-julien.grall@arm.com>
 <20190429144428.29254-5-julien.grall@arm.com>
 <17855fd3-7f7b-a962-e2bd-c9a0c2dbf765@redhat.com>
 <59ff2eda-74d4-6925-6ed0-8d40e8a892fa@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59ff2eda-74d4-6925-6ed0-8d40e8a892fa@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Grall <julien.grall@arm.com>, Auger Eric <eric.auger@redhat.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: jason@lakedaemon.net, douliyangs@gmail.com, robin.murphy@arm.com, miquel.raynal@bootlin.com, tglx@linutronix.de, logang@deltatee.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 01/05/2019 12:14, Julien Grall wrote:
> On 30/04/2019 13:34, Auger Eric wrote:
>> Hi Julien,
> 
> Hi Eric,
> 
> Thank you for the review!
> 
>>
>> On 4/29/19 4:44 PM, Julien Grall wrote:
>>> its_irq_compose_msi_msg() may be called from non-preemptible context.
>>> However, on RT, iommu_dma_map_msi_msg requires to be called from a
>>> preemptible context.
>>>
>>> A recent change split iommu_dma_map_msi_msg() in two new functions:
>>> one that should be called in preemptible context, the other does
>>> not have any requirement.
>>>
>>> The GICv3 ITS driver is reworked to avoid executing preemptible code in
>>> non-preemptible context. This can be achieved by preparing the MSI
>>> maping when allocating the MSI interrupt.
>> mapping
>>>
>>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>>
>>> ---
>>>      Changes in v2:
>>>          - Rework the commit message to use imperative mood
>>> ---
>>>   drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>> index 7577755bdcf4..12ddbcfe1b1e 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -1179,7 +1179,7 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
>>>   	msg->address_hi		= upper_32_bits(addr);
>>>   	msg->data		= its_get_event_id(d);
>>>   
>>> -	iommu_dma_map_msi_msg(d->irq, msg);
>>> +	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
>>>   }
>>>   
>>>   static int its_irq_set_irqchip_state(struct irq_data *d,
>>> @@ -2566,6 +2566,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>>   {
>>>   	msi_alloc_info_t *info = args;
>>>   	struct its_device *its_dev = info->scratchpad[0].ptr;
>>> +	struct its_node *its = its_dev->its;
>>>   	irq_hw_number_t hwirq;
>>>   	int err;
>>>   	int i;
>>> @@ -2574,6 +2575,8 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>>   	if (err)
>>>   		return err;
>>>   
>>> +	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
>> Test err as in gicv2m driver?
> 
> Hmmm yes. Marc, do you want me to respin the patch?

Sure, feel free to if you can. But what I really need is an Ack from
Jorg on the first few patches.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
