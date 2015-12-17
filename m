From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v6 4/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Thu, 17 Dec 2015 11:12:39 +0800
Message-ID: <1450321959.22854.141.camel@mhfsdcap03>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
	<1449568153-15643-5-git-send-email-yong.wu@mediatek.com>
	<20151214141656.GG18805@8bytes.org>
	<1450150132.22854.57.camel@mhfsdcap03>
	<5670098E.40601@arm.com> <1450245573.22854.108.camel@mhfsdcap03>
	<56715D8D.3050102@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <56715D8D.3050102-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2015-12-16 at 12:48 +0000, Robin Murphy wrote:
> On 16/12/15 05:59, Yong Wu wrote:
> > On Tue, 2015-12-15 at 12:37 +0000, Robin Murphy wrote:
> >> On 15/12/15 03:28, Yong Wu wrote:
> >>> On Mon, 2015-12-14 at 15:16 +0100, Joerg Roedel wrote:
> >>>> On Tue, Dec 08, 2015 at 05:49:12PM +0800, Yong Wu wrote:
[...]
> > Following your comment above, I test as below. Then the flows seems meet
> > the "best case" that the iommu core will help create default DMA domain.
> >
> > @@ -664,19 +636,41 @@ static int mtk_iommu_probe(struct platform_device
> > *pdev)
> > for (i = 0; i < larb_nr; i++) {
> > 		struct device_node *larbnode;
> > 		struct platform_device *plarbdev;
> >
> > 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
> > 		if (!larbnode)
> > 			return -EINVAL;
> >
> >                  plarbdev = of_find_device_by_node(larbnode);
> >                  of_node_put(larbnode);
> > -               if (!plarbdev)
> > -                       return -EPROBE_DEFER;
> > +               if (!plarbdev) {
> > +                       plarbdev = of_platform_device_create(larbnode,
> > NULL, platform_bus_type.dev_root);
> > +                       if (IS_ERR(pdev))
> > +                               return -EPROBE_DEFER;
> > +               }
> > }
> >
> > I only add of_platform_device_create for the SMI local arbiter devices
> > here.
> >
> > This is a big improvement for us. If this is ok, I will send a quick
> > next version for this.
> 
> In my opinion it's reasonable - we need the whole "IOMMU" to be ready, 

  Thanks.

> so if we already have to short-cut the creation of the M4U part it only 
> seems fair to do the same for the SMI part. That said, would it work to 
> just unconditionally poke the larbs in mtk_iommu_init_fn() before you 
> poke the M4U itself? It would be nice to keep all that stuff together in 
> the same place.

    mtk_iommu_init_fn don't have the larb's "struct device_node". So I
cann't create its platform_device directly.

    I have tried 2 method:
   a) add a mtk_smi_larb_init_fn in the SMI patch.

static int mtk_smi_larb_init_fn(struct device_node *np)
{
	struct platform_device *pdev;

	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);

	return IS_ERR(pdev) ? PTR_ERR(pdev) :  0;
}
IOMMU_OF_DECLARE(mtk_smi_larb, "mediatek,mt8173-smi-larb",
mtk_smi_larb_init_fn);

   This don't work. It will run after mtk_iommu_init_fn. then the larb's
platform_device also don't exist while m4u's probe.

  b) Copy the code below to mtk_iommu_init_fn.

   for (i = 0; i < larb_nr; i++) {
      xxx
      plarbdev = of_platform_device_create(larbnode,
                      NULL, platform_bus_type.dev_root);
   }

   It works. But then there are 2 same code of parsing the SMI local
arbiter(one is in mtk_iommu_init_fn, the other is in mtk_iommu_init_fn).
It looks not good. I think that the one I wrote in the previous mail is
better, It only add 3 lines, What's your opinion?

> >>>>> +static struct iommu_group *mtk_iommu_device_group(struct device *dev)
> >>>>> +{
> >>>>> +	struct mtk_iommu_data *data;
> >>>>> +	struct mtk_iommu_client_priv *priv;
> >>>>> +
> >>>>> +	priv = dev->archdata.iommu;
> >>>>> +	if (!priv)
> >>>>> +		return ERR_PTR(-ENODEV);
> >>>>> +
> >>>>> +	/* All the client devices are in the same m4u iommu-group */
> >>>>> +	data = dev_get_drvdata(priv->m4udev);
> >>>>> +	if (!data->m4u_group) {
> >>>>> +		data->m4u_group = iommu_group_alloc();
> >>>>> +		if (IS_ERR(data->m4u_group))
> >>>>> +			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
> >>>>> +	}
> >>>>> +	return data->m4u_group;
> >>>>> +}
> >>
> >> As long as this works as expected, then AFAICS you shouldn't have to
> >> have *any* special-case behaviour or tracking of domains at all.
> >
> > We only need one iommu-group, one iommu domain here.
> >
> > What's the special-case behavior, how can we track of domains.
> > Could you help give me a example?
> 
> The beauty of it is that you don't need to. If you guarantee all of an 
> IOMMU's client devices are in the same group, you know you've only got 
> one thing which can be attached to that IOMMU's domains. Therefore, you 
> can freely allow as many domains as you like to *exist*, because there 
> can never be more than one *active* at any given time - the core code 
> enforces that the group is detached from one domain before being 
> attached to another, and the driver's attach and detach calls just 
> become responsible for switching the given domain's page table in and 
> out of the actual hardware. I think it's pretty neat.

It seems that mtk-iommu can not detach/attach dynamically. the iommu
core don't support iommu_detach_device/iommu_attach_device whose
iommu-group have many devices.(Normally there is only one device in a
iommu-group). 

So currently we only iommu_attach_device while probe, it will never
attach/detach again.

All our multimedia modules are in the m4u'domain and share m4u's
pagetable, They won't change pagetable.

> 
> Robin.
