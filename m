From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 2/6 v2] iommu: of: make of_pci_map_rid() available for
	other devices too
Date: Wed, 18 Apr 2018 06:21:46 +0000
Message-ID: <HE1PR0401MB2425A73A3BFF84B15B764FC6E6B60@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
	<1523960514-25457-1-git-send-email-nipun.gupta@nxp.com>
	<1523960514-25457-3-git-send-email-nipun.gupta@nxp.com>
	<41b32766-e21a-e946-6c8f-440e5c87d0ee@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <41b32766-e21a-e946-6c8f-440e5c87d0ee-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy-5wv7dgnIgG8@public.gmane.org]
> Sent: Tuesday, April 17, 2018 10:23 PM
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> Cc: will.deacon-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; catalin.marinas-5wv7dgnIgG8@public.gmane.org;
> hch-jcswGhMUV9g@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bharat Bhushan
> <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>; stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Laurentiu Tudor
> <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>; Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [PATCH 2/6 v2] iommu: of: make of_pci_map_rid() available for
> other devices too
> 
> On 17/04/18 11:21, Nipun Gupta wrote:
> > iommu-map property is also used by devices with fsl-mc. This patch
> > moves the of_pci_map_rid to generic location, so that it can be used
> > by other busses too.
> >
> > Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> > ---
> >   drivers/iommu/of_iommu.c | 106
> > +++++++++++++++++++++++++++++++++++++++++++++--
> 
> Doesn't this break "msi-parent" parsing for !CONFIG_OF_IOMMU? I guess you
> don't want fsl-mc to have to depend on PCI, but this looks like a step in the
> wrong direction.

Thanks for pointing out.
Agree, this will break "msi-parent" parsing for !CONFIG_OF_IOMMU case.

> 
> I'm not entirely sure where of_map_rid() fits best, but from a quick look around
> the least-worst option might be drivers/of/of_address.c, unless Rob and Frank
> have a better idea of where generic DT-based ID translation routines could live?
> 
> >   drivers/of/irq.c         |   6 +--
> >   drivers/pci/of.c         | 101 --------------------------------------------
> >   include/linux/of_iommu.h |  11 +++++
> >   include/linux/of_pci.h   |  10 -----
> >   5 files changed, 117 insertions(+), 117 deletions(-)
> >

[...]

> >   struct of_pci_iommu_alias_info {
> >   	struct device *dev;
> >   	struct device_node *np;
> > @@ -149,9 +249,9 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16
> alias, void *data)
> >   	struct of_phandle_args iommu_spec = { .args_count = 1 };
> >   	int err;
> >
> > -	err = of_pci_map_rid(info->np, alias, "iommu-map",
> > -			     "iommu-map-mask", &iommu_spec.np,
> > -			     iommu_spec.args);
> > +	err = of_map_rid(info->np, alias, "iommu-map",
> > +			 "iommu-map-mask", &iommu_spec.np,
> > +			 iommu_spec.args);
> 
> Super-nit: Apparently I missed rewrapping this to 2 lines in d87beb749281, but if
> it's being touched again, that would be nice ;)

Sure.. I'll take care of this in the next version :)

Regards,
Nipun
