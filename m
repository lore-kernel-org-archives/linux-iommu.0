From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 13/17] irqdomain: irq_domain_check_msi_remap
Date: Thu, 5 Jan 2017 11:25:28 +0000
Message-ID: <f6096747-5943-520a-2d16-de5650292ff3@arm.com>
References: <1483536746-2725-1-git-send-email-eric.auger@redhat.com>
	<1483536746-2725-14-git-send-email-eric.auger@redhat.com>
	<ecb7ddf6-074f-50e4-6402-d59ceb1edd1d@arm.com>
	<df8e7fdb-4048-3169-c758-c2a64119a321@redhat.com>
	<c9c4c159-60ea-8501-5dc2-17bbb24ddfab@arm.com>
	<92fcb464-3364-c432-29d8-1c2ce4a5f110@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <92fcb464-3364-c432-29d8-1c2ce4a5f110-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 05/01/17 10:45, Auger Eric wrote:
> Hi Marc,
> 
> On 04/01/2017 16:27, Marc Zyngier wrote:
>> On 04/01/17 14:11, Auger Eric wrote:
>>> Hi Marc,
>>>
>>> On 04/01/2017 14:46, Marc Zyngier wrote:
>>>> Hi Eric,
>>>>
>>>> On 04/01/17 13:32, Eric Auger wrote:
>>>>> This new function checks whether all platform and PCI
>>>>> MSI domains implement IRQ remapping. This is useful to
>>>>> understand whether VFIO passthrough is safe with respect
>>>>> to interrupts.
>>>>>
>>>>> On ARM typically an MSI controller can sit downstream
>>>>> to the IOMMU without preventing VFIO passthrough.
>>>>> As such any assigned device can write into the MSI doorbell.
>>>>> In case the MSI controller implements IRQ remapping, assigned
>>>>> devices will not be able to trigger interrupts towards the
>>>>> host. On the contrary, the assignment must be emphasized as
>>>>> unsafe with respect to interrupts.
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>>>
>>>>> ---
>>>>>
>>>>> v4 -> v5:
>>>>> - Handle DOMAIN_BUS_FSL_MC_MSI domains
>>>>> - Check parents
>>>>> ---
>>>>>  include/linux/irqdomain.h |  1 +
>>>>>  kernel/irq/irqdomain.c    | 41 +++++++++++++++++++++++++++++++++++++++++
>>>>>  2 files changed, 42 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>>>>> index ab017b2..281a40f 100644
>>>>> --- a/include/linux/irqdomain.h
>>>>> +++ b/include/linux/irqdomain.h
>>>>> @@ -219,6 +219,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
>>>>>  					 void *host_data);
>>>>>  extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
>>>>>  						   enum irq_domain_bus_token bus_token);
>>>>> +extern bool irq_domain_check_msi_remap(void);
>>>>>  extern void irq_set_default_host(struct irq_domain *host);
>>>>>  extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
>>>>>  				  irq_hw_number_t hwirq, int node,
>>>>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>>>>> index 8c0a0ae..700caea 100644
>>>>> --- a/kernel/irq/irqdomain.c
>>>>> +++ b/kernel/irq/irqdomain.c
>>>>> @@ -278,6 +278,47 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
>>>>>  EXPORT_SYMBOL_GPL(irq_find_matching_fwspec);
>>>>>  
>>>>>  /**
>>>>> + * irq_domain_is_msi_remap - Check if @domain or any parent
>>>>> + * has MSI remapping support
>>>>> + * @domain: domain pointer
>>>>> + */
>>>>> +static bool irq_domain_is_msi_remap(struct irq_domain *domain)
>>>>> +{
>>>>> +	struct irq_domain *h = domain;
>>>>> +
>>>>> +	for (; h; h = h->parent) {
>>>>> +		if (h->flags & IRQ_DOMAIN_FLAG_MSI_REMAP)
>>>>> +			return true;
>>>>> +	}
>>>>> +	return false;
>>>>> +}
>>>>> +
>>>>> +/**
>>>>> + * irq_domain_check_msi_remap() - Checks whether all MSI
>>>>> + * irq domains implement IRQ remapping
>>>>> + */
>>>>> +bool irq_domain_check_msi_remap(void)
>>>>> +{
>>>>> +	struct irq_domain *h;
>>>>> +	bool ret = true;
>>>>> +
>>>>> +	mutex_lock(&irq_domain_mutex);
>>>>> +	list_for_each_entry(h, &irq_domain_list, link) {
>>>>> +		if (((h->bus_token & DOMAIN_BUS_PCI_MSI) ||
>>>>> +		     (h->bus_token & DOMAIN_BUS_PLATFORM_MSI) ||
>>>>> +		     (h->bus_token & DOMAIN_BUS_FSL_MC_MSI)) &&
>>>>> +		     !irq_domain_is_msi_remap(h)) {
>>>>
>>>> (h->bus_token & DOMAIN_BUS_PCI_MSI) and co looks quite wrong. bus_token
>>>> is not a bitmap, and DOMAIN_BUS_* not a single bit value (see enum
>>>> irq_domain_bus_token). Surely this should read
>>>> (h->bus_token == DOMAIN_BUS_PCI_MSI).
>>> Oh I did not notice that. Thanks.
>>>
>>> Any other comments on the irqdomain side? Do you think the current
>>> approach consisting in looking at those bus tokens and their parents
>>> looks good?
>>
>> To be completely honest, I don't like it much, as having to enumerate
>> all the bus types can come up with could become quite a burden in the
>> long run. I'd rather be able to identify MSI capable domains by
>> construction. I came up with the following approach (fully untested):
>>
>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>> index 281a40f..7779796 100644
>> --- a/include/linux/irqdomain.h
>> +++ b/include/linux/irqdomain.h
>> @@ -183,8 +183,11 @@ enum {
>>  	/* Irq domain is an IPI domain with single virq */
>>  	IRQ_DOMAIN_FLAG_IPI_SINGLE	= (1 << 3),
>>  
>> +	/* Irq domain implements MSIs */
>> +	IRQ_DOMAIN_FLAG_MSI		= (1 << 4),
>> +
>>  	/* Irq domain is MSI remapping capable */
>> -	IRQ_DOMAIN_FLAG_MSI_REMAP	= (1 << 4),
>> +	IRQ_DOMAIN_FLAG_MSI_REMAP	= (1 << 5),
>>  
>>  	/*
>>  	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
>> @@ -450,6 +453,11 @@ static inline bool irq_domain_is_ipi_single(struct irq_domain *domain)
>>  {
>>  	return domain->flags & IRQ_DOMAIN_FLAG_IPI_SINGLE;
>>  }
>> +
>> +static inline bool irq_domain_is_msi(struct irq_domain *domain)
>> +{
>> +	return domain->flags & IRQ_DOMAIN_FLAG_MSI;
>> +}
>>  #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>>  static inline void irq_domain_activate_irq(struct irq_data *data) { }
>>  static inline void irq_domain_deactivate_irq(struct irq_data *data) { }
>> @@ -481,6 +489,11 @@ static inline bool irq_domain_is_ipi_single(struct irq_domain *domain)
>>  {
>>  	return false;
>>  }
>> +
>> +static inline bool irq_domain_is_msi(struct irq_domain *domain)
>> +{
>> +	return false;
>> +}
>>  #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
>>  
>>  #else /* CONFIG_IRQ_DOMAIN */
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index 700caea..33b6921 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -304,10 +304,7 @@ bool irq_domain_check_msi_remap(void)
>>  
>>  	mutex_lock(&irq_domain_mutex);
>>  	list_for_each_entry(h, &irq_domain_list, link) {
>> -		if (((h->bus_token & DOMAIN_BUS_PCI_MSI) ||
>> -		     (h->bus_token & DOMAIN_BUS_PLATFORM_MSI) ||
>> -		     (h->bus_token & DOMAIN_BUS_FSL_MC_MSI)) &&
>> -		     !irq_domain_is_msi_remap(h)) {
>> +		if (irq_domain_is_msi(h) && !irq_domain_is_msi_remap(h)) {
>>  			ret = false;
>>  			goto out;
>>  		}
>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>> index ee23006..b637263 100644
>> --- a/kernel/irq/msi.c
>> +++ b/kernel/irq/msi.c
>> @@ -270,7 +270,7 @@ struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
>>  	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
>>  		msi_domain_update_chip_ops(info);
>>  
>> -	return irq_domain_create_hierarchy(parent, 0, 0, fwnode,
>> +	return irq_domain_create_hierarchy(parent, IRQ_DOMAIN_FLAG_MSI, 0, fwnode,
>>  					   &msi_domain_ops, info);
>>  }
>>  
>>
>>
>> Thoughts?
> 
> Don't we need to set the IRQ_DOMAIN_FLAG_MSI flag in
> platform_msi_create_device_domain too (drivers/base/platform-msi.c)?

Well, platform_msi_create_irq_domain does call msi_create_irq_domain,
doesn't it? That's one of the benefits of the generic MSI
infrastructure: it is the only function that performs the creation of an
MSI domain for any bus type.

Or am I missing something completely obvious (which is perfectly
possible since I only had a couple of cups of the brown stuff...)?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
