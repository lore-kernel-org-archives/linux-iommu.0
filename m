From: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices on
	fsl-mc bus
Date: Wed, 16 May 2018 08:48:57 +0000
Message-ID: <HE1PR0401MB24253CF729DDCF3F883AC256E6920@HE1PR0401MB2425.eurprd04.prod.outlook.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
	<1524824826-29473-6-git-send-email-nipun.gupta@nxp.com>
	<5AF9916E.8000504@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5AF9916E.8000504-3arQi8VN3Tc@public.gmane.org>
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
To: Laurentiu Tudor <laurentiu.tudor-3arQi8VN3Tc@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "catalin.marinas-5wv7dgnIgG8@public.gmane.org" <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Laurentiu Tudor
> Sent: Monday, May 14, 2018 7:10 PM
> To: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> will.deacon-5wv7dgnIgG8@public.gmane.org; mark.rutland-5wv7dgnIgG8@public.gmane.org; catalin.marinas-5wv7dgnIgG8@public.gmane.org
> Cc: hch-jcswGhMUV9g@public.gmane.org; gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org;
> robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org;
> frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; linux-
> pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Bharat Bhushan <bharat.bhushan-3arQi8VN3Tc@public.gmane.org>;
> stuyoder-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [PATCH 5/6 v3] bus: fsl-mc: supoprt dma configure for devices
> on fsl-mc bus
> 
> Hi Nipun,
> 
> On 04/27/2018 01:27 PM, Nipun Gupta wrote:
> > Signed-off-by: Nipun Gupta <nipun.gupta-3arQi8VN3Tc@public.gmane.org>
> > ---
> >   drivers/bus/fsl-mc/fsl-mc-bus.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-
> bus.c
> > index 5d8266c..624828b 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev,
> struct kobj_uevent_env *env)
> >   	return 0;
> >   }
> >
> > +static int fsl_mc_dma_configure(struct device *dev)
> > +{
> > +	struct device *dma_dev = dev;
> > +
> > +	while (dev_is_fsl_mc(dma_dev))
> > +		dma_dev = dma_dev->parent;
> > +
> > +	return of_dma_configure(dev, dma_dev->of_node, 0);
> > +}
> > +
> >   static ssize_t modalias_show(struct device *dev, struct device_attribute
> *attr,
> >   			     char *buf)
> >   {
> > @@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
> >   	.name = "fsl-mc",
> >   	.match = fsl_mc_bus_match,
> >   	.uevent = fsl_mc_bus_uevent,
> > +	.dma_configure  = fsl_mc_dma_configure,
> >   	.dev_groups = fsl_mc_dev_groups,
> >   };
> >   EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
> > @@ -616,6 +627,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc
> *obj_desc,
> >   		mc_dev->icid = parent_mc_dev->icid;
> >   		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
> >   		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
> > +		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
> 
> This change seems a bit unrelated to the patch subject. I wonder if it
> makes sense to split it it in a distinct patch.

Okay. I will spin a v5 after splitting this patch and adding changelog (Greg's comment), fixing typo (Bjorn's comment).

Regards,
Nipun

> 
> ---
> Best Regards, Laurentiu
