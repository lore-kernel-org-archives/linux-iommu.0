From: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 3/5] PCI: Set PCI_BUS_FLAGS_MSI_REMAP if MSI controller
	supports IRQ remapping
Date: Wed, 25 May 2016 13:48:00 +0800
Message-ID: <201605250548.u4P5hveb049131@mx0a-001b2d01.pphosted.com>
References: <1461761010-5452-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<1461761010-5452-4-git-send-email-xyjxie@linux.vnet.ibm.com>
	<20160524210434.GB16463@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160524210434.GB16463@localhost>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alistair-Y4h6yKqj69EXC2x5gXVKYQ@public.gmane.org, nikunj-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, zhong-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ruscur-3Su/lFKaw5ejKv3TNrM5DQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, warrier-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, gwshan-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2016/5/25 5:04, Bjorn Helgaas wrote:

> On Wed, Apr 27, 2016 at 08:43:28PM +0800, Yongji Xie wrote:
>> On ARM HW the capability of IRQ remapping is abstracted on
>> MSI controller side. MSI_FLAG_IRQ_REMAPPING is used to advertise
>> this [1].
>>
>> To have a universal flag to test this capability for different
>> archs on PCI side, we set PCI_BUS_FLAGS_MSI_REMAP for PCI buses
>> when MSI_FLAG_IRQ_REMAPPING is set.
>>
>> [1] http://www.spinics.net/lists/kvm/msg130256.html
>>
>> Signed-off-by: Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
>> ---
>>   drivers/pci/msi.c   |   12 ++++++++++++
>>   drivers/pci/probe.c |    3 +++
>>   include/linux/msi.h |    6 +++++-
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>> index a080f44..1661cdf 100644
>> --- a/drivers/pci/msi.c
>> +++ b/drivers/pci/msi.c
>> @@ -1134,6 +1134,18 @@ void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
>>   }
>>   EXPORT_SYMBOL_GPL(msi_desc_to_pci_sysdata);
>>   
>> +void pci_bus_check_msi_remapping(struct pci_bus *bus,
>> +				 struct irq_domain *domain)
>> +{
>> +#ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
>> +	struct msi_domain_info *info;
>> +
>> +	info = msi_get_domain_info(domain);
>> +	if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>> +		bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
>> +#endif
>> +}
> Functions named "check_foo" are a pet peeve of mine because the name
> doesn't tell us anything about what the function *does*.  In this
> case, we know it checks something about MSI remapping, but we don't
> know whether we're checking whether it's enabled, disabled, or some
> other property.
>
> I'd prefer something like:
>
>    int pci_bus_msi_isolated(struct pci_bus *bus, struct irq_domain *domain)
>    {
>      struct msi_domain_info *info;
>
>      if (!domain)
>        return 0;
>
>      info = msi_get_domain_info(domain);
>      if (info->flags & MSI_FLAG_IRQ_REMAPPING)
>        return 1;
>
>      return 0;
>    }
>
>    void pci_set_bus_msi_domain(struct pci_bus *bus)
>    {
>      ...
>      if (b == bus && pci_bus_msi_isolated(bus, d))
>        bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;

Yes. This looks more reasonable. Thank you!

Regards,
Yongji
