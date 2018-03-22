From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v2 2/2] drivers: remove force dma flag from buses
Date: Thu, 22 Mar 2018 15:13:49 +0000
Message-ID: <HE1PR0401MB2425407DADB19FCF6E016456E6A90@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
	<1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
	<1521615323-4752-2-git-send-email-nipun.gupta@nxp.com>
	<20180322081926.GC29444@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180322081926.GC29444-jcswGhMUV9g@public.gmane.org>
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
Cc: "zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "msuchanek-l3A5Bk7waGM@public.gmane.org" <msuchanek-l3A5Bk7waGM@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel@l>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch-jcswGhMUV9g@public.gmane.org]
> Sent: Thursday, March 22, 2018 13:49
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> 
> > --- a/drivers/dma/qcom/hidma_mgmt.c
> > +++ b/drivers/dma/qcom/hidma_mgmt.c
> > @@ -398,7 +398,7 @@ static int __init
> hidma_mgmt_of_populate_channels(struct device_node *np)
> >  		}
> >  		of_node_get(child);
> >  		new_pdev->dev.of_node = child;
> > -		of_dma_configure(&new_pdev->dev, child);
> > +		of_dma_configure(&new_pdev->dev, child, true);
> >  		/*
> >  		 * It is assumed that calling of_msi_configure is safe on
> >  		 * platforms with or without MSI support.
> 
> Where did we mark this bus as force_dma before?

I thought these devices to be on the platform bus as the device is of type
'struct platform_device', though I am not sure then why 'of_dma_configure()'
is called here. Is this not on platform bus?

> 
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> > index 9a4f4246..895c83e 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -353,7 +353,7 @@ int of_reserved_mem_device_init_by_idx(struct device
> *dev,
> >  		/* ensure that dma_ops is set for virtual devices
> >  		 * using reserved memory
> >  		 */
> > -		of_dma_configure(dev, np);
> > +		of_dma_configure(dev, np, true);
> 
> Did all the callers of this one really force dma?  I have a hard time
> untangling the call stacks unfortunately.

I see this API being called indirectly from NXP DPAA device driver which
is for platform bus devices. So I marked 'true' out here. There are more places
from where it is being called.

Thanks,
Nipun
