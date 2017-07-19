From: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v4 4/6] iommu: Set PCI_BUS_FLAGS_MSI_REMAP on iommu
 driver initialization
Date: Wed, 19 Jul 2017 20:02:04 +1000
Message-ID: <b444851a-3240-f98f-04b9-0223649ea856@ozlabs.ru>
References: <20170630052436.15212-1-aik@ozlabs.ru>
 <20170630052436.15212-5-aik@ozlabs.ru>
 <CAErSpo4pAZfDx5p_S9Z8jR_ctH=ZrkgG6aNaNmPaN2H77dgEgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo4pAZfDx5p_S9Z8jR_ctH=ZrkgG6aNaNmPaN2H77dgEgQ@mail.gmail.com>
Content-Language: en-AU
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yongji Xie <elohimes@gmail.com>, Eric Auger <eric.auger@redhat.com>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, Joerg Roedel <joro@8bytes.org>, "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Jike Song <jike.song@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linux-pci <linux-pci@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 11/07/17 05:23, Bjorn Helgaas wrote:
> [+cc Joerg, iommu]
> 
> On Fri, Jun 30, 2017 at 12:24 AM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>> From: Yongji Xie <elohimes@gmail.com>
>>
>> Some iommu drivers would be initialized after PCI device
>> enumeration. So PCI_BUS_FLAGS_MSI_REMAP would not be set
>> when probing PCI devices although IOMMU enables capability
>> of IRQ remapping. This patch tests this capability and
>> set the flag when iommu driver is initialized.
>>
>> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
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


It does look like a wart, however it did not cause immediate rejection
after first couple of revisions of this before I took it over...

So. Here is the problem - deliver an MSIX isolation flag from IOMMU to
VFIO-PCI driver. The options are:

1. PCI_BUS_FLAGS_MSI_REMAP on a PCI bus - MSIX isolation is not really a
PCI bus property and it is "like a wart".

2. Introduce "flags" in iommu_group and define IOMMU_GROUP_MSIX_ISOLATED
and set it when an IOMMU group is created; VFIO-PCI has ways to get to the
group and read the flag.

3. Create IOMMU_DOMAIN_UNMANAGED IOMMU domains for PPC64/powernv IOMMU
groups and only define capable() hook to report IOMMU_CAP_INTR_REMAP;
others already use these IOMMU domains. VFIO-PCI's mmap() hook could then
check the capability via iommu_capable(bus). The problems is as Robin said:
"iommu_capable() is a fundamentally broken and unworkable interface
anyway"; however it is still not clear to me why it is unworkable in this
particular case of isolation checking.

I am missing knowledge about ARM, is there a good overview of these MSIX
domains vs. IOMMU on ARM (as MSIX remapping seems not to be an IOMMU property)?


Which one to pick? Thanks.



> 
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


-- 
Alexey
