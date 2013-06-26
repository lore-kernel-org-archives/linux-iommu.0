From: Sethi Varun-B16395 <B16395-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 3/3 v16] iommu/fsl: Freescale PAMU driver and iommu
	implementation.
Date: Wed, 26 Jun 2013 06:24:24 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D5DD70C@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1371744089-17780-1-git-send-email-Varun.Sethi@freescale.com>
	<1371744089-17780-2-git-send-email-Varun.Sethi@freescale.com>
	<1372136211.30572.377.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1372136211.30572.377.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, "benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org" <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Tuesday, June 25, 2013 10:27 AM
> To: Sethi Varun-B16395
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org; Yoder Stuart-B08248;
> Wood Scott-B07421; Timur Tabi
> Subject: Re: [PATCH 3/3 v16] iommu/fsl: Freescale PAMU driver and iommu
> implementation.
> 
> On Thu, 2013-06-20 at 21:31 +0530, Varun Sethi wrote:
> 
> > +#define REQ_ACS_FLAGS	(PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR |
> PCI_ACS_UF)
> > +
> > +static struct iommu_group *get_device_iommu_group(struct device *dev)
> > +{
> > +	struct iommu_group *group;
> > +
> > +	group = iommu_group_get(dev);
> > +	if (!group)
> > +		group = iommu_group_alloc();
> > +
> > +	return group;
> > +}
> > +
> [snip]
> > +
> 
> This really gets parent or peer, right?
> 
> > +static struct iommu_group *get_peer_pci_device_group(struct pci_dev
> > +*pdev) {
> > +	struct iommu_group *group = NULL;
> > +
> > +	/* check if this is the first device on the bus*/
> > +	if (pdev->bus_list.next == pdev->bus_list.prev) {
> 
> It's a list_head, use list functions.  The list implementation should be
> treated as opaque.
> 
> if (list_is_singular(&pdev->bus_list))
> 
> > +		struct pci_bus *bus = pdev->bus->parent;
> > +		/* Traverese the parent bus list to get
> > +		 * pdev & dev for the sibling device.
> > +		 */
> > +		while (bus) {
> > +			if (!list_empty(&bus->devices)) {
> > +				pdev = container_of(bus->devices.next,
> > +					            struct pci_dev, bus_list);
> 
> pdev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> 
> > +				group = iommu_group_get(&pdev->dev);
> > +				break;
> > +			} else
> > +				bus = bus->parent;
> 
> Is this ever reached?  Don't you always have bus->self?
> 
[Sethi Varun-B16395] Not sure I understand. Trying to get the group information from the parent bus, if there are no sibling devices on the current bus.

> > +		}
> > +	} else {
> > +		/*
> > +		 * Get the pdev & dev for the sibling device
> > +		 */
> > +		pdev = container_of(pdev->bus_list.prev,
> > +				    struct pci_dev, bus_list);
> 
> How do you know if you're at the head or tail of the list?
> 
> struct pci_dev *tmp;
> list_for_each_entry(tmp, &pdev->bus_list, bus_list) {
> 	if (tmp == pdev)
> 		continue;
> 
> 	group = iommu_group_get(&tmp->dev);
> 	break;
> }
> 
> > +		group = iommu_group_get(&pdev->dev);
> > +	}
> > +
> > +	return group;
> > +}
> > +
> > +static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
> > +{
> > +	struct iommu_group *group = NULL;
> > +	struct pci_dev *bridge, *dma_pdev = NULL;
> > +	struct pci_controller *pci_ctl;
> > +	bool pci_endpt_partioning;
> > +
> > +	pci_ctl = pci_bus_to_host(pdev->bus);
> > +	pci_endpt_partioning = check_pci_ctl_endpt_part(pci_ctl);
> > +	/* We can partition PCIe devices so assign device group to the
> device */
> > +	if (pci_endpt_partioning) {
> > +		bridge = pci_find_upstream_pcie_bridge(pdev);
> > +		if (bridge) {
> > +			if (pci_is_pcie(bridge))
> > +				dma_pdev = pci_get_domain_bus_and_slot(
> > +						pci_domain_nr(pdev->bus),
> > +						bridge->subordinate->number, 0);
> > +			if (!dma_pdev)
> > +				dma_pdev = pci_dev_get(bridge);
> > +		} else
> > +			dma_pdev = pci_dev_get(pdev);
> > +
> > +		/* Account for quirked devices */
> > +		swap_pci_ref(&dma_pdev, pci_get_dma_source(dma_pdev));
> > +
> > +		/*
> > +		 * If it's a multifunction device that does not support our
> > +		 * required ACS flags, add to the same group as function 0.
> > +		 */
> 
> See c14d2690 in Joerg's next tree, using function 0 was a poor
> assumption.
[Sethi Varun-B16395] ok.

> 
> > +		if (dma_pdev->multifunction &&
> > +		    !pci_acs_enabled(dma_pdev, REQ_ACS_FLAGS))
> > +			swap_pci_ref(&dma_pdev,
> > +				     pci_get_slot(dma_pdev->bus,
> > +						  PCI_DEVFN(PCI_SLOT(dma_pdev-
> >devfn),
> > +						  0)));
> > +
> > +		group = get_device_iommu_group(&pdev->dev);
> > +		pci_dev_put(pdev);
> 
> What was the point of all the above if we use pdev here instead of
> dma_pdev?  Wrong device and broken reference counting.
[Sethi Varun-B16395] Will fix this

  This also isn't
> testing ACS all the way up to the root complex or controller.
[Sethi Varun-B16395] In our case the IOMMU can differentiate transactions based on the LIODN. The PCIe controller can generate a unique LIODN based on the bus,device,function number. I believe this would even be true for devices connected to a PCIe bridge (and not on the root bus). So, do we still need to check for ACS up to the root node?

-Varun
