From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Fri, 11 Sep 2015 16:33:36 +0100
Message-ID: <55F2F450.5090809@arm.com>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
	<1438597279-2937-6-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438597279-2937-6-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org" <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, "frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach@p>
List-Id: iommu@lists.linux-foundation.org

On 03/08/15 11:21, Yong Wu wrote:
> This patch adds support for mediatek m4u (MultiMedia Memory Management
> Unit).
>
> Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
[...]
> +/*
> + * There is only one iommu domain called the m4u domain that
> + * all Multimedia modules share.
> + */
> +static struct mtk_iommu_domain *m4udom;

It's a shame this can't be part of the m4u device's mtk_iommu_data, but 
since the way iommu_domain_alloc works makes that impossible, I think we 
have little choice but to use the global and hope your guys never build 
a system with two of these things in ;)

[...]
> +static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
> +{
> +       struct mtk_iommu_domain *priv;
> +
> +       if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> +               return NULL;
> +
> +       if (m4udom)/* The m4u domain exist. */
> +               return &m4udom->domain;
> +
> +       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return NULL;
> +
> +       priv->domain.geometry.aperture_start = 0;
> +       priv->domain.geometry.aperture_end = DMA_BIT_MASK(32);
> +       priv->domain.geometry.force_aperture = true;

My intention is that in the IOMMU_DOMAIN_DMA case you'd call 
iommu_get_dma_cookie(&priv->domain) here as well, that way I can get rid 
of some of the dodgy workarounds in arch_setup_dma_ops which try to 
cover all possible cases (and which I'm now not 100% confident in). I'm 
just about to start trying to fix that up (expect a repost of my series 
in a week or two once -rc1 has landed).

> +
> +       m4udom = priv;
> +
> +       return &priv->domain;
> +}
[...]
> +static int mtk_iommu_add_device(struct device *dev)
> +{
> +       struct iommu_group *group;
> +       int ret;
> +
> +       if (!dev->archdata.iommu) /* Not a iommu client device */
> +               return -ENODEV;
> +
> +       group = iommu_group_get(dev);
> +       if (!group) {
> +               group = iommu_group_alloc();
> +               if (IS_ERR(group)) {
> +                       dev_err(dev, "Failed to allocate IOMMU group\n");
> +                       return PTR_ERR(group);
> +               }
> +       }
> +
 > +       ret = iommu_group_add_device(group, dev);
> +       if (ret) {
> +               dev_err(dev, "Failed to add IOMMU group\n");
> +               goto err_group_put;
> +       }

I know the rest of the code means that you can't hit it in practice, but 
if you ever did have two client devices in the same group then the 
iommu_group_get() could legitimately succeed for the second device, then 
you'd blow up creating a duplicate sysfs entry by adding the device to 
its own group again. Probably not what you want.

> +
> +       ret = iommu_attach_group(&m4udom->domain, group);
> +       if (ret)
> +               dev_err(dev, "Failed to attach IOMMU group\n");

Similarly here, if two devices did share a group then the group could 
legitimately already be attached to a domain here (by the first device), 
so attaching it again would be wrong. I think it would be nicer to check 
with iommu_get_domain_for_dev() first to see if you need to do anything 
at all (a valid domain from that implies a valid group).

> +
> +err_group_put:
> +       iommu_group_put(group);
> +       return ret;
> +}
[...]
> +static int mtk_iommu_probe(struct platform_device *pdev)
> +{
> +       struct mtk_iommu_data   *data;
> +       struct device           *dev = &pdev->dev;
> +       void __iomem            *protect;
> +       int                     ret;
> +
> +       data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       /* Protect memory. HW will access here while translation fault.*/
> +       protect = devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
> +       if (!protect)
> +               return -ENOMEM;
> +       data->protect_base = virt_to_phys(protect);
> +
> +       ret = mtk_iommu_parse_dt(pdev, data);
> +       if (ret)
> +               return ret;
> +
> +       if (!m4udom)/* There is no iommu client */
> +               return 0;

I don't quite follow this: m4udom is apparently only created by someone 
calling domain_alloc() - how can you guarantee that happens before this 
driver is probed? - but if they then go and try to attach the device to 
their new domain, it's going to end up in mtk_hw_init() poking the 
hardware of the m4u device that can't have even probed yet.

I can only imagine it currently works by sheer chance due to the 
horrible arch_setup_dma_ops delayed attachment workaround, so even if I 
can't remove that completely when I look at it next week I'm liable to 
change it in a way that breaks this badly ;)

Robin.

> +
> +       data->dev = dev;
> +       m4udom->data = data;
> +       dev_set_drvdata(dev, m4udom);
> +
> +       return 0;
> +}
