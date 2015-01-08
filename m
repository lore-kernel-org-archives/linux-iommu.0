From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 0/4] PCI: get DMA configuration from parent device
Date: Thu, 8 Jan 2015 15:54:16 +0000
Message-ID: <20150108155416.GM11583@arm.com>
References: <1420656594-8908-1-git-send-email-m-karicheri2@ti.com>
 <4057859.4ynbgz66iN@wuerfel>
 <54ADBB89.8070503@ti.com>
 <1934001.D0JfDRp1gF@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1934001.D0JfDRp1gF@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 08, 2015 at 08:56:39AM +0000, Arnd Bergmann wrote:
> On Wednesday 07 January 2015 18:04:41 Murali Karicheri wrote:
> > On 01/07/2015 04:18 PM, Arnd Bergmann wrote:
> > > On Wednesday 07 January 2015 13:49:50 Murali Karicheri wrote:
> > >> PCI devices on Keystone doesn't have correct dma_pfn_offset set. This patch
> > >> add capability to set the dma configuration such as dma-mask, dma_pfn_offset,
> > >> and dma ops etc using the information from DT. The prior RFCs and discussions
> > >> are available at [1] and [2] below.
> > >>
> > >> [2] : https://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg790244.html
> > >> [1] : http://www.gossamer-threads.com/lists/linux/kernel/2024591
> > >
> > > Looks all good to me in this version, I'm just unsure about one thing:
> > >
> > >>                 - Limit the of_iommu_configure to non pci devices
> > >
> > > My last recommendation was to pass the b/d/f number into
> > > of_pci_dma_configure to handle this correctly. What was your
> > > reason for not doing it in the end?
> > Arnd,
> > 
> > I had responded to this already on the list and reproduced below your 
> > remark and my response below from that thread.
> 
> Ah right, sorry for missing a reply on that.
> 
> > ---------------cut-------------------------------------------------------
> >  > Actually regarding the bit I wrote above, it might be helpful to pass
> >  > the PCI_DEVID() into both of_iommu_configure and of_dma_configure.
> >  >
> >  > While this may or may not be sufficient, I think there is no question
> >  > about it being needed for the ARM SMMU with PCI, so we may as well add
> >  > it at the point when you touch the same lines already. In the platform
> >  > bus case, just pass zero here.
> > 
> > PCI_DEVID() is defined as
> > 
> > #define PCI_DEVID(bus, devfn)  ((((u16)(bus)) << 8) | (devfn))
> > 
> > So PCI_DEVID of 0 is a valid PCI DEVID.
> 
> I think that is ok: the idea would be that we always just list the
> first ID of the range and then let the iommu driver add the offset
> in the appropriate way.
> 
> > How about checking if the device is PCI in of_iommu_configure() using 
> > dev_is_pci(dev) macro and return immediately for PCI? Need to include 
> > pci.h in this file though.
> > 
> > Some of the iommu drivers already include this.
> 
> I guess you are right, but the driver can even handle the PCI
> device correctly without the extra parameter:
> 
> 	devid = 0;
> 	if (dev_is_pci(dev)) {
> 		struct pci_dev *pdev = to_pci_dev(dev);
> 		devid = PCI_DEVID(pdev->bus->number, pdev->devfn);
> 	}
> 
> 	streamid += devid;
> 
> Other IOMMUs won't even care about the devid, so they will just work.

I started looking at this in more depth for the ARM SMMU at the end of last
year and the PCI case ends up being remarkably similar to the DT case.

Although I initially thought we just needed the devid, actually we need to
walk the PCI topology to find the dma alias for the device. The current
code for doing that (iommu_group_get_for_pci_dev) only reports the resulting
IOMMu group, which can actually correspond to *multiple* DMA aliases due
to ACS restrictions.

I knocked up a couple of patches for dealing with this in the ARM SMMU
driver, but I'd really like that to be part of core code if possible :)

https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=iommu/pgtbl&id=41dc7b9e0ff1a4d79d1dd76619056fc0cfa8b84f
https://git.kernel.org/cgit/linux/kernel/git/will/linux.git/commit/?h=iommu/pgtbl&id=5503996103138b41520d5eae90dda62abb65f04f

So, I think of_pci_dma_configure should determine the set of aliases for the
group. What isn't clear to me for the DT *or* the PCI cases is what we
actually do with the group at the dma-mapping level...

Will
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
