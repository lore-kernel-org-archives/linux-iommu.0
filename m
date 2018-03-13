From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] dma-mapping: move dma configuration to bus infrastructure
Date: Tue, 13 Mar 2018 04:22:53 +0000
Message-ID: <HE1PR0401MB24250A8631823FB3108EA62CE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
	<6a76df69-8c6c-52a6-0afd-fd0b8d2ff703@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6a76df69-8c6c-52a6-0afd-fd0b8d2ff703-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "msuchanek-l3A5Bk7waGM@public.gmane.org" <msuchanek-l3A5Bk7waGM@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Sinan Kaya [mailto:okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org]
> Sent: Monday, March 12, 2018 22:14
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; hch-jcswGhMUV9g@public.gmane.org;
> robin.murphy-5wv7dgnIgG8@public.gmane.org; linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org;
> m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
> Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org;
> jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org; linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> msuchanek-l3A5Bk7waGM@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH] dma-mapping: move dma configuration to bus
> infrastructure
> 
> On 3/12/2018 11:24 AM, Nipun Gupta wrote:
> > +	if (dma_dev->of_node) {
> > +		ret = of_dma_configure(dev, dma_dev->of_node);
> > +	} else if (has_acpi_companion(dma_dev)) {
> > +		attr = acpi_get_dma_attr(to_acpi_device_node(dma_dev-
> >fwnode));
> > +		if (attr != DEV_DMA_NOT_SUPPORTED)
> > +			ret = acpi_dma_configure(dev, attr);
> > +	}
> > +
> > +	pci_put_host_bridge_device(bridge);
> > +
> > +	return ret;
> > +}
> > +
> > +void pci_dma_deconfigure(struct device *dev)
> > +{
> > +	of_dma_deconfigure(dev);
> > +	acpi_dma_deconfigure(dev);
> > +}
> 
> Isn't this one or the other one but not both?
> 
> Something like:
> 
> if (dev->of_node)
> 	of_dma_deconfigure(dev);
> else
> 	acpi_dma_deconfigure(dev);
> 
> should work.

I understand your point. Seems reasonable as we should not expect
the 'of/acpi DMA deconfigure' API to not fail when they are not configured.

But, here we would also need to get dma_device (just as we get in
'pci_dma_configure') and need a check on it as for PCI there 'of_node'
is present in the dma_dev.

Ill update this in v2, and also make similar changes for platform and AMBA bus.

Thanks,
Nipun

> 
> --
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
> Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux
> Foundation Collaborative Project.
