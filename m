From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH kernel v4 4/6] iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu
	driver initialization
Date: Tue, 11 Jul 2017 11:39:27 +0100
Message-ID: <2391df16-2095-315b-e091-3e3eb69bb668@arm.com>
References: <20170630052436.15212-1-aik@ozlabs.ru>
	<20170630052436.15212-5-aik@ozlabs.ru>
	<CAErSpo4pAZfDx5p_S9Z8jR_ctH=ZrkgG6aNaNmPaN2H77dgEgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAErSpo4pAZfDx5p_S9Z8jR_ctH=ZrkgG6aNaNmPaN2H77dgEgQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Cc: Yongji Xie <elohimes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 10/07/17 20:23, Bjorn Helgaas via iommu wrote:
> [+cc Joerg, iommu]
> 
> On Fri, Jun 30, 2017 at 12:24 AM, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org> wrote:
>> From: Yongji Xie <elohimes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Some iommu drivers would be initialized after PCI device
>> enumeration. So PCI_BUS_FLAGS_MSI_REMAP would not be set
>> when probing PCI devices although IOMMU enables capability
>> of IRQ remapping. This patch tests this capability and
>> set the flag when iommu driver is initialized.
>>
>> Signed-off-by: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
>> Signed-off-by: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
>> ---
>>  drivers/iommu/iommu.c | 8 ++++++++
>>  drivers/pci/probe.c   | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index cf7ca7e70777..0b5881ddca09 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -1063,6 +1063,14 @@ static int add_iommu_group(struct device *dev, void *data)
>>         const struct iommu_ops *ops = cb->ops;
>>         int ret;
>>
>> +       /*
>> +        * Set PCI_BUS_FLAGS_MSI_REMAP for all PCI buses when IOMMU
>> +        * have capability of IRQ remapping.
>> +        */
>> +       if (dev_is_pci(dev) && ops->capable &&
>> +                       ops->capable(IOMMU_CAP_INTR_REMAP))
>> +               to_pci_dev(dev)->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
> 
> This isn't my area, but this addition is really ugly.  It doesn't look
> anything like the rest of the code in add_iommu_group(), so it just
> feels like a wart.

I have no idea what the context is here, but this flag looks wrong
generally. IRQ remapping is a property of the irqchip and has nothing to
do with PCI, so pretending it's a property of PCI buses looks like a
massive hack around... something.

Also, iommu_capable() is a fundamentally broken and unworkable interface
anyway. The existing IRQ remapping code really wants updating to
advertise IRQ_DOMAIN_FLAG_MSI_REMAP on the relevant MSI domains so that
IOMMU_CAP_INTR_REMAP can go away for good. That way, all consumers who
actually care about whether IRQ remapping is implemented (see e.g. VFIO)
can use irq_domain_check_msi_remap() or check specific devices in a sane
and scalable manner.

Robin.

>>         if (!ops->add_device)
>>                 return 0;
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index f2393b7d7ebf..14aac9df3d17 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/acpi.h>
>>  #include <linux/irqdomain.h>
>>  #include <linux/pm_runtime.h>
>> +#include <linux/iommu.h>
> 
> This obviously belongs in another patch, as the compile error showed.
> 
>>  #include "pci.h"
>>
>>  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
>> --
>> 2.11.0
>>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
