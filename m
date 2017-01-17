From: Tomasz Nowicki <tnowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v8 14/18] irqdomain: irq_domain_check_msi_remap
Date: Tue, 17 Jan 2017 15:06:16 +0100
Message-ID: <5eb6945b-9d4c-9521-1d5d-10eba633fd59@caviumnetworks.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
	<1484127714-3263-15-git-send-email-eric.auger@redhat.com>
	<8db94e75-7939-c6da-2101-cfa73827c16c@semihalf.com>
	<f5aacc54-ca8e-cb09-461a-6105346b18b9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f5aacc54-ca8e-cb09-461a-6105346b18b9-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17.01.2017 14:53, Auger Eric wrote:
> Hi Tomasz,
>
> On 17/01/2017 14:40, Tomasz Nowicki wrote:
>> On 11.01.2017 10:41, Eric Auger wrote:
>>> This new function checks whether all MSI irq domains
>>> implement IRQ remapping. This is useful to understand
>>> whether VFIO passthrough is safe with respect to interrupts.
>>>
>>> On ARM typically an MSI controller can sit downstream
>>> to the IOMMU without preventing VFIO passthrough.
>>> As such any assigned device can write into the MSI doorbell.
>>> In case the MSI controller implements IRQ remapping, assigned
>>> devices will not be able to trigger interrupts towards the
>>> host. On the contrary, the assignment must be emphasized as
>>> unsafe with respect to interrupts.
>>>
>>> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>> Reviewed-by: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
>>>
>>> ---
>>> v7 -> v8:
>>> - remove goto in irq_domain_check_msi_remap
>>> - Added Marc's R-b
>>>
>>> v5 -> v6:
>>> - use irq_domain_hierarchical_is_msi_remap()
>>> - comment rewording
>>>
>>> v4 -> v5:
>>> - Handle DOMAIN_BUS_FSL_MC_MSI domains
>>> - Check parents
>>> ---
>>>  include/linux/irqdomain.h |  1 +
>>>  kernel/irq/irqdomain.c    | 22 ++++++++++++++++++++++
>>>  2 files changed, 23 insertions(+)
>>>
>>> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
>>> index bc2f571..188eced 100644
>>> --- a/include/linux/irqdomain.h
>>> +++ b/include/linux/irqdomain.h
>>> @@ -222,6 +222,7 @@ struct irq_domain *irq_domain_add_legacy(struct
>>> device_node *of_node,
>>>                       void *host_data);
>>>  extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec
>>> *fwspec,
>>>                             enum irq_domain_bus_token bus_token);
>>> +extern bool irq_domain_check_msi_remap(void);
>>>  extern void irq_set_default_host(struct irq_domain *host);
>>>  extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
>>>                    irq_hw_number_t hwirq, int node,
>>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>>> index 876e131..d889751 100644
>>> --- a/kernel/irq/irqdomain.c
>>> +++ b/kernel/irq/irqdomain.c
>>> @@ -278,6 +278,28 @@ struct irq_domain
>>> *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
>>>  EXPORT_SYMBOL_GPL(irq_find_matching_fwspec);
>>>
>>>  /**
>>> + * irq_domain_check_msi_remap - Check whether all MSI
>>> + * irq domains implement IRQ remapping
>>> + */
>>> +bool irq_domain_check_msi_remap(void)
>>> +{
>>> +    struct irq_domain *h;
>>> +    bool ret = true;
>>> +
>>> +    mutex_lock(&irq_domain_mutex);
>>> +    list_for_each_entry(h, &irq_domain_list, link) {
>>> +        if (irq_domain_is_msi(h) &&
>>> +            !irq_domain_hierarchical_is_msi_remap(h)) {
>>> +            ret = false;
>>> +            break;
>>> +        }
>>> +    }
>>> +    mutex_unlock(&irq_domain_mutex);
>>> +    return ret;
>>> +}
>>
>> Above function returns true, even though there is no MSI irq domains. Is
>> it intentional ?
> From the VFIO integration point of view this is what we want. If there
> is no MSI controller in the system, we have no vulnerability with
> respect to IRQ assignment and we consider the system as safe. If
> requested I can add a comment?
>

I see. Yes, a comment would be helpful then :) Thanks!

Tomasz
