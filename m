From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3] memory: mtk-smi: add larbid init routine
Date: Fri, 28 Jul 2017 09:15:05 +0800
Message-ID: <1501204505.29316.9.camel@mtksdaap41>
References: <1501120872-19652-1-git-send-email-honghui.zhang@mediatek.com>
	<1501120872-19652-2-git-send-email-honghui.zhang@mediatek.com>
	<f7dac4d6-4ef8-e10d-e483-088120392ab2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <f7dac4d6-4ef8-e10d-e483-088120392ab2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, xinping.qian-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2017-07-27 at 17:42 +0200, Matthias Brugger wrote:
> 
> On 07/27/2017 04:01 AM, honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > In the commit 3c8f4ad85c4b ("memory/mediatek: add support for mt2701"),
> > the larb->larbid was added but not initialized.
> > Mediatek's gen1 smi need this hardware larbid information to get the
> > register offset which controls whether enable iommu for this larb.
> > This patch add the initialize routine for larbid.
> > 
> > Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >   drivers/memory/mtk-smi.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > index 2b798bb4..fe36b3e 100644
> > --- a/drivers/memory/mtk-smi.c
> > +++ b/drivers/memory/mtk-smi.c
> > @@ -240,6 +240,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> >   	struct device *dev = &pdev->dev;
> >   	struct device_node *smi_node;
> >   	struct platform_device *smi_pdev;
> > +	int err;
> >   
> >   	if (!dev->pm_domain)
> >   		return -EPROBE_DEFER;
> > @@ -263,6 +264,14 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> >   		return PTR_ERR(larb->smi.clk_smi);
> >   	larb->smi.dev = dev;
> >   
> > +	err = of_property_read_u32(dev->of_node, "mediatek,larbid",
> > +				   &larb->larbid);
> > +	if (err && of_device_is_compatible(dev->of_node,
> > +					   "mediatek,mt2701-smi-larb")) {
> 
> Instead of checking hard-coded bindings you should be able to determine the 
> generation using the smi_pdev.
> Apart I think it would be better to check for mediatek,larbid only on 
> MTK_SIM_GEN1, or do I miss something?
> 

Hi, Matthias,
	There's a new SoC of mediatek which use MTK_SMI_GEN2 hardware, but it
has 2 iommus and 2 smi_common, and we are intend to send it's driver
soon. It need the mediatek,larbid to identify which iommu should be
binding to.

This patch use the hard-code bindings will make the future work easier.

thanks.
> Regards,
> Matthias
> 
> > +		dev_err(dev, "missing larbid property\n");
> > +		return err;
> > +	}
> > +
> >   	smi_node = of_parse_phandle(dev->of_node, "mediatek,smi", 0);
> >   	if (!smi_node)
> >   		return -EINVAL;
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
