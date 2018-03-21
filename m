From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH v2 1/2] dma-mapping: move dma configuration to bus
	infrastructure
Date: Wed, 21 Mar 2018 16:13:38 +0000
Message-ID: <HE1PR0401MB242585F3CB211F71AF29791EE6AA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1520868292-2479-1-git-send-email-nipun.gupta@nxp.com>
	<1521615323-4752-1-git-send-email-nipun.gupta@nxp.com>
	<20180321092954.GS14085@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180321092954.GS14085-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
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
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jarkko.sakkinen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, "andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "msuchanek-l3A5Bk7waGM@public.gmane.org" <msuchanek-l3A5Bk7waGM@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dri-devel-PD4FTy7X32k@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Greg KH [mailto:gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org]
> Sent: Wednesday, March 21, 2018 15:00

<snip>

> > +int dma_configure(struct device *dev)
> > +{
> > +	if (dev->bus->dma_configure)
> > +		return dev->bus->dma_configure(dev);
> > +
> > +	return 0;
> > +}
> >  void dma_deconfigure(struct device *dev)
> 
> Empty line after this new function?  Sorry, couldn't help it :)
> 
> >  {
> >  	of_dma_deconfigure(dev);
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index f1bf7b3..d2d5891 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -1130,6 +1130,11 @@ int platform_pm_restore(struct device *dev)
> >
> >  #endif /* CONFIG_HIBERNATE_CALLBACKS */
> >

<snip>

> > +
> >  	const struct dev_pm_ops *pm;
> >
> >  	const struct iommu_ops *iommu_ops;
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index eb9eab4..c15986b 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -761,6 +761,7 @@ void *dma_mark_declared_memory_occupied(struct
> device *dev,
> >  }
> >  #endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
> >
> > +int dma_common_configure(struct device *dev);
> >  #ifdef CONFIG_HAS_DMA
> 
> Blank line after the new function declaration?
> 
> Other than those very minor things, nice job, this looks good:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>

Thank you for the review :). I will fix your comments in next version.

Regards,
Nipun
