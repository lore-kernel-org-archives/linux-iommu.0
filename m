From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 4/6] iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu
 driver initialization
Date: Wed, 12 Jul 2017 12:47:08 +1000
Message-ID: <b581efd8-0411-5649-1515-c6639d65059f@ozlabs.ru>
References: <20170630052436.15212-1-aik@ozlabs.ru>
 <20170630052436.15212-5-aik@ozlabs.ru>
 <CAErSpo4pAZfDx5p_S9Z8jR_ctH=ZrkgG6aNaNmPaN2H77dgEgQ@mail.gmail.com>
 <2391df16-2095-315b-e091-3e3eb69bb668@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <2391df16-2095-315b-e091-3e3eb69bb668@arm.com>
Content-Language: en-AU
Sender: kvm-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Yongji Xie <elohimes@gmail.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: iommu@lists.linux-foundation.org

On 11/07/17 20:39, Robin Murphy wrote:
> On 10/07/17 20:23, Bjorn Helgaas via iommu wrote:
>> [+cc Joerg, iommu]
>>
>> On Fri, Jun 30, 2017 at 12:24 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>> From: Yongji Xie <elohimes@gmail.com>
>>>
>>> Some iommu drivers would be initialized after PCI device
>>> enumeration. So PCI_BUS_FLAGS_MSI_REMAP would not be set
>>> when probing PCI devices although IOMMU enables capability
>>> of IRQ remapping. This patch tests this capability and
>>> set the flag when iommu driver is initialized.
>>>
>>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  drivers/iommu/iommu.c | 8 ++++++++
>>>  drivers/pci/probe.c   | 1 +
>>>  2 files changed, 9 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index cf7ca7e70777..0b5881ddca09 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -1063,6 +1063,14 @@ static int add_iommu_group(struct device *dev, void *data)
>>>         const struct iommu_ops *ops = cb->ops;
>>>         int ret;
>>>
>>> +       /*
>>> +        * Set PCI_BUS_FLAGS_MSI_REMAP for all PCI buses when IOMMU
>>> +        * have capability of IRQ remapping.
>>> +        */
>>> +       if (dev_is_pci(dev) && ops->capable &&
>>> +                       ops->capable(IOMMU_CAP_INTR_REMAP))
>>> +               to_pci_dev(dev)->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
>>
>> This isn't my area, but this addition is really ugly.  It doesn't look
>> anything like the rest of the code in add_iommu_group(), so it just
>> feels like a wart.
> 
> I have no idea what the context is here, but this flag looks wrong
> generally. IRQ remapping is a property of the irqchip and has nothing to
> do with PCI, so pretending it's a property of PCI buses looks like a
> massive hack around... something.

The context here - should we allow mapping of MSIX BAR to a guest or not.
Now it is disabled as the guest can write there anything and make device
send MSIX messages to random addresses. However if a PCI bridge can somehow
filter these writes, then it is safe.

So it is not really remapping what we care about in this patchset, it is
filtering/censoring.

And the reason to allow MSIX mapping is that it may be adjacent to
frequently used MMIO and also reside within same 64K page which happens to
be the default page size on PPC64.

So even though remapping/filtering is not a property of any PCI bus but it
is a part on an IOMMU which is usually (always?) combined with the PCI host
bridge adapter so the PCI bus flag makes sense. How else would we pass that
flag from IOMMU to the actual device we want to mmap to the userspace?


> Also, iommu_capable() is a fundamentally broken and unworkable interface
> anyway. The existing IRQ remapping code really wants updating to
> advertise IRQ_DOMAIN_FLAG_MSI_REMAP on the relevant MSI domains so that
> IOMMU_CAP_INTR_REMAP can go away for good.

This IRQ_DOMAIN_FLAG_MSI_REMAP is used only on ARM, is there a plan/desire
to use it in other places instead of capable(IOMMU_CAP_INTR_REMAP)?

> That way, all consumers who
> actually care about whether IRQ remapping is implemented (see e.g. VFIO)
> can use irq_domain_check_msi_remap() or check specific devices in a sane
> and scalable manner.

What specific devices are you talking about here? Actual PCI controllers do
not have control over MSIX remapping/filtering...




> 
> Robin.
> 
>>>         if (!ops->add_device)
>>>                 return 0;
>>>
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index f2393b7d7ebf..14aac9df3d17 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -17,6 +17,7 @@
>>>  #include <linux/acpi.h>
>>>  #include <linux/irqdomain.h>
>>>  #include <linux/pm_runtime.h>
>>> +#include <linux/iommu.h>
>>
>> This obviously belongs in another patch, as the compile error showed.
>>
>>>  #include "pci.h"
>>>
>>>  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
>>> --
>>> 2.11.0
>>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>
> 


-- 
Alexey
