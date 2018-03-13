From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH] dma-mapping: move dma configuration to bus	infrastructure
Date: Tue, 13 Mar 2018 15:59:58 +0000
Message-ID: <HE1PR0401MB242509FE2B60674CAF306A4AE6D20@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
	<20180313073448.GA32269@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180313073448.GA32269-jcswGhMUV9g@public.gmane.org>
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
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "msuchanek-l3A5Bk7waGM@public.gmane.org" <msuchanek-l3A5Bk7waGM@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch-jcswGhMUV9g@public.gmane.org]
> Sent: Tuesday, March 13, 2018 13:05
> > +int amba_dma_configure(struct device *dev)
> > +{
> > +	enum dev_dma_attr attr;
> > +	int ret = 0;
> > +
> > +	if (dev->of_node) {
> > +		ret = of_dma_configure(dev, dev->of_node);
> > +	} else if (has_acpi_companion(dev)) {
> > +		attr = acpi_get_dma_attr(to_acpi_device_node(dev->fwnode));
> > +		if (attr != DEV_DMA_NOT_SUPPORTED)
> > +			ret = acpi_dma_configure(dev, attr);
> > +	}
> > +
> > +	return ret;
> 
> This code sniplet is duplicated so many times that I think we should
> just have some sort of dma_common_configure() for it that the various
> busses can use.

Agree. There is no good point in duplicating the code.
So this new API will be part of 'drivers/base/dma-mapping.c' file?

> 
> > +void amba_dma_deconfigure(struct device *dev)
> > +{
> > +	of_dma_deconfigure(dev);
> > +	acpi_dma_deconfigure(dev);
> > +}
> 
> As mention in my previous reply I think we don't even need a deconfigure
> callback at this point - just remove the ACPI and OF wrappers and
> clear the dma ops.
> 
> Also in this series we should replace the force_dma flag by use of the
> proper method, e.g. give a force parameter to of_dma_configure and the
> new dma_common_configure helper that the busses that want it can set.

I am more inclined to what Robin states in other mail to keep symmetry.
i.e. to keep dma_configure() and dma_deconfigure() and call
dev->bus->dma_configure from dma_configure(). Is this okay?

Thanks,
Nipun
