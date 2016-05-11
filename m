From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v9 5/7] vfio/type1: also check IRQ remapping capability at
	msi domain
Date: Wed, 11 May 2016 10:31:28 +0100
Message-ID: <5732FBF0.4040105@arm.com>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
	<1462362858-2925-6-git-send-email-eric.auger@linaro.org>
	<20160509164942.5af8b30d@t450s.home> <57320803.8070506@linaro.org>
	<57321952.2020206@arm.com> <5732EF96.4070001@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5732EF96.4070001-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, eric.auger-qxv4g6HH51o@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11/05/16 09:38, Eric Auger wrote:
> Hi Robin, Alex,
> On 05/10/2016 07:24 PM, Robin Murphy wrote:
>> Hi Eric,
>>
>> On 10/05/16 17:10, Eric Auger wrote:
>>> Hi Alex,
>>> On 05/10/2016 12:49 AM, Alex Williamson wrote:
>>>> On Wed,  4 May 2016 11:54:16 +0000
>>>> Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>>
>>>>> On x86 IRQ remapping is abstracted by the IOMMU. On ARM this is
>>>>> abstracted
>>>>> by the msi controller. vfio_safe_irq_domain allows to check whether
>>>>> interrupts are "safe" for a given device. They are if the device does
>>>>> not use MSI
>>>>
>>>> Are we sure we're not opening a security hole here?  An MSI is simply a
>>>> DMA write, so really whether or not a device uses MSI is irrelevant.
>>>> If it can generate a DMA to the MSI doorbell then we need to be
>>>> protected and I think we pretty much need to assume that devices are
>>>> DMA capable.  Do the MSI domain checks cover this?
>>> Let me try to rephrase: we check the device is not attached to an MSI
>>> controller (I think this is the semantic of dev_get_msi_domain(dev)).
>>>
>>> If it is not, we don't have to care about MSI isolation: there will be
>>> no IOMMU binding between the device and any MSI doorbell. If it is we
>>> check the msi domain is backed by an MSI controller able to perform MSI
>>> isolation.
>>>
>>> So effectively "usage of MSIs" is improper - since it is decided after
>>> the group attachment anyway  - and the commit message should rather
>>> state "if the device is linked to an MSI controller" (dt msi-parent
>>> notion I think).
>>
>> Hmm, I think Alex has a point here - on a GICv2m I can happily fire
>> arbitrary MSIs from _a shell_ (using /dev/mem), and the CPUs definitely
>> aren't in an MSI domain, so I don't think it's valid to assume that a
>> device using only wired interrupts, therefore with no connection to any
>> MSI controller, isn't still capable of maliciously spewing DMA all over
>> any and every doorbell region in the system.
>
> Sorry but I still don't get the point. For the device to reach the
> doorbell there must be an IOMMU mapping.

Only when the doorbell is _downstream_ of IOMMU translation.

> - if the device is not attached to an MSI domain, there won't be any
> doorbell iommu mapping built by this series, so no risk, right?
>
> The device will be allowed to reach only memory iommu mapped by
> userspace with VFIO DMA MAP standard API. Of course if the userspace can
> mmap all the host PA that's a more general issue, right?
>
> - If the device is attached to an MSI domain (msi-parent link), 2 cases:
> 1) the MSI controller advertises MSI isolation (ITS cases), no risk
> 2) the MSI controller does not advertise MSI isolation (GICv2m), there
> is a security hole.
>     a) by default we reject the device attachment
>     b) if the userspace overrides the safe interrupt option he accepts
> the security hole
>
> What am I missing?

The x86-with-interrupt-remapping-disabled case. Currently, without 
unsafe_interrupts, everything is rejected - with this patch, we'll still 
reject anything with an MSI domain, but e.g. legacy PCI devices using 
INTx would be free to scribble all over the un-translated interrupt 
region willy-nilly. That's the subtle, but significant, change in behaviour.

Robin.

> Best Regards
>
> Eric
>>
>> Robin.
>>
>>> Does it sound better?
>>>
>>> Regards
>>>
>>> Eric
>>>>
>>>>> or if the device uses MSI and the msi-parent controller
>>>>> supports IRQ remapping.
>>>>>
>>>>> Then we check at group level if all devices have safe interrupts: if
>>>>> not,
>>>>> we only allow the group to be attached if allow_unsafe_interrupts is
>>>>> set.
>>>>>
>>>>> At this point ARM sMMU still advertises IOMMU_CAP_INTR_REMAP. This is
>>>>> changed in next patch.
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>>
>>>>> ---
>>>>> v3 -> v4:
>>>>> - rename vfio_msi_parent_irq_remapping_capable into
>>>>> vfio_safe_irq_domain
>>>>>     and irq_remapping into safe_irq_domains
>>>>>
>>>>> v2 -> v3:
>>>>> - protect vfio_msi_parent_irq_remapping_capable with
>>>>>     CONFIG_GENERIC_MSI_IRQ_DOMAIN
>>>>> ---
>>>>>    drivers/vfio/vfio_iommu_type1.c | 44
>>>>> +++++++++++++++++++++++++++++++++++++++--
>>>>>    1 file changed, 42 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c
>>>>> b/drivers/vfio/vfio_iommu_type1.c
>>>>> index 4d3a6f1..2fc8197 100644
>>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>>> @@ -37,6 +37,8 @@
>>>>>    #include <linux/vfio.h>
>>>>>    #include <linux/workqueue.h>
>>>>>    #include <linux/msi-iommu.h>
>>>>> +#include <linux/irqdomain.h>
>>>>> +#include <linux/msi.h>
>>>>>
>>>>>    #define DRIVER_VERSION  "0.2"
>>>>>    #define DRIVER_AUTHOR   "Alex Williamson
>>>>> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>"
>>>>> @@ -777,6 +779,33 @@ static int vfio_bus_type(struct device *dev,
>>>>> void *data)
>>>>>        return 0;
>>>>>    }
>>>>>
>>>>> +/**
>>>>> + * vfio_safe_irq_domain: returns whether the irq domain
>>>>> + * the device is attached to is safe with respect to MSI isolation.
>>>>> + * If the irq domain is not an MSI domain, we return it is safe.
>>>>> + *
>>>>> + * @dev: device handle
>>>>> + * @data: unused
>>>>> + * returns 0 if the irq domain is safe, -1 if not.
>>>>> + */
>>>>> +static int vfio_safe_irq_domain(struct device *dev, void *data)
>>>>> +{
>>>>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>>>>> +    struct irq_domain *domain;
>>>>> +    struct msi_domain_info *info;
>>>>> +
>>>>> +    domain = dev_get_msi_domain(dev);
>>>>> +    if (!domain)
>>>>> +        return 0;
>>>>> +
>>>>> +    info = msi_get_domain_info(domain);
>>>>> +
>>>>> +    if (!(info->flags & MSI_FLAG_IRQ_REMAPPING))
>>>>> +        return -1;
>>>>> +#endif
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>>    static int vfio_iommu_replay(struct vfio_iommu *iommu,
>>>>>                     struct vfio_domain *domain)
>>>>>    {
>>>>> @@ -870,7 +899,7 @@ static int vfio_iommu_type1_attach_group(void
>>>>> *iommu_data,
>>>>>        struct vfio_group *group, *g;
>>>>>        struct vfio_domain *domain, *d;
>>>>>        struct bus_type *bus = NULL;
>>>>> -    int ret;
>>>>> +    int ret, safe_irq_domains;
>>>>>
>>>>>        mutex_lock(&iommu->lock);
>>>>>
>>>>> @@ -893,6 +922,13 @@ static int vfio_iommu_type1_attach_group(void
>>>>> *iommu_data,
>>>>>
>>>>>        group->iommu_group = iommu_group;
>>>>>
>>>>> +    /*
>>>>> +     * Determine if all the devices of the group have a safe irq
>>>>> domain
>>>>> +     * with respect to MSI isolation
>>>>> +     */
>>>>> +    safe_irq_domains = !iommu_group_for_each_dev(iommu_group, &bus,
>>>>> +                       vfio_safe_irq_domain);
>>>>> +
>>>>>        /* Determine bus_type in order to allocate a domain */
>>>>>        ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
>>>>>        if (ret)
>>>>> @@ -920,8 +956,12 @@ static int vfio_iommu_type1_attach_group(void
>>>>> *iommu_data,
>>>>>        INIT_LIST_HEAD(&domain->group_list);
>>>>>        list_add(&group->next, &domain->group_list);
>>>>>
>>>>> +    /*
>>>>> +     * to advertise safe interrupts either the IOMMU or the MSI
>>>>> controllers
>>>>> +     * must support IRQ remapping/interrupt translation
>>>>> +     */
>>>>>        if (!allow_unsafe_interrupts &&
>>>>> -        !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
>>>>> +        (!iommu_capable(bus, IOMMU_CAP_INTR_REMAP) &&
>>>>> !safe_irq_domains)) {
>>>>>            pr_warn("%s: No interrupt remapping support.  Use the
>>>>> module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU
>>>>> support on this platform\n",
>>>>>                   __func__);
>>>>>            ret = -EPERM;
>>>>
>>>
>>
>
