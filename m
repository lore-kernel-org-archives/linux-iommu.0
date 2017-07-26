From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH kernel v4 4/6] iommu: Set PCI_BUS_FLAGS_MSI_REMAP on
	iommu driver initialization
Date: Wed, 26 Jul 2017 11:50:53 +0200
Message-ID: <20170726095053.GG15833@8bytes.org>
References: <20170630052436.15212-1-aik@ozlabs.ru>
	<20170630052436.15212-5-aik@ozlabs.ru>
	<CAErSpo4pAZfDx5p_S9Z8jR_ctH=ZrkgG6aNaNmPaN2H77dgEgQ@mail.gmail.com>
	<b444851a-3240-f98f-04b9-0223649ea856@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b444851a-3240-f98f-04b9-0223649ea856-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Cc: Jike Song <jike.song-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Yongji Xie <elohimes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Yongji Xie <xyjxie-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jul 19, 2017 at 08:02:04PM +1000, Alexey Kardashevskiy wrote:
> On 11/07/17 05:23, Bjorn Helgaas wrote:
> >> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index cf7ca7e70777..0b5881ddca09 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -1063,6 +1063,14 @@ static int add_iommu_group(struct device *dev, void *data)
> >>         const struct iommu_ops *ops = cb->ops;
> >>         int ret;
> >>
> >> +       /*
> >> +        * Set PCI_BUS_FLAGS_MSI_REMAP for all PCI buses when IOMMU
> >> +        * have capability of IRQ remapping.
> >> +        */
> >> +       if (dev_is_pci(dev) && ops->capable &&
> >> +                       ops->capable(IOMMU_CAP_INTR_REMAP))
> >> +               to_pci_dev(dev)->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;

We avoid bus-specific hacks in generic iommu code. This has to be done
in bus-specific iommu-group setup code.

> 1. PCI_BUS_FLAGS_MSI_REMAP on a PCI bus - MSIX isolation is not really a
> PCI bus property and it is "like a wart".

This one is at least debatable. It could be a property of the bus.

> 2. Introduce "flags" in iommu_group and define IOMMU_GROUP_MSIX_ISOLATED
> and set it when an IOMMU group is created; VFIO-PCI has ways to get to the
> group and read the flag.

That's the best option I see here.

> 3. Create IOMMU_DOMAIN_UNMANAGED IOMMU domains for PPC64/powernv IOMMU
> groups and only define capable() hook to report IOMMU_CAP_INTR_REMAP;
> others already use these IOMMU domains. VFIO-PCI's mmap() hook could then
> check the capability via iommu_capable(bus). The problems is as Robin said:
> "iommu_capable() is a fundamentally broken and unworkable interface
> anyway"; however it is still not clear to me why it is unworkable in this
> particular case of isolation checking.

That one is wrong, IRQ remapping is not a property of a domain. A domain
is an abstraction for a device address space. Attaching IRQ information
there is just wrong.



	Joerg
