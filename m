From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 4/6] memory: mediatek: Add SMI driver
Date: Sat, 31 Oct 2015 16:32:30 +0800
Message-ID: <1446280350.13050.90.camel@mhfsdcap03>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
	 <1444357388-30257-5-git-send-email-yong.wu@mediatek.com>
	 <562F7B12.7030201@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <562F7B12.7030201-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-10-27 at 13:24 +0000, Robin Murphy wrote:
> On 09/10/15 03:23, Yong Wu wrote:
> [...]
> > +static int mtk_smi_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct mtk_smi_data *smidata;
> > +	int ret;
> > +
> > +	if (!dev->pm_domain)
> > +		return -EPROBE_DEFER;
> > +
> > +	smidata = devm_kzalloc(dev, sizeof(*smidata), GFP_KERNEL);
> > +	if (!smidata)
> > +		return -ENOMEM;
> > +
> > +	smidata->clk_apb = devm_clk_get(dev, "apb");
> > +	if (IS_ERR(smidata->clk_apb))
> > +		return PTR_ERR(smidata->clk_apb);
> > +
> > +	smidata->clk_smi = devm_clk_get(dev, "smi");
> > +	if (IS_ERR(smidata->clk_smi))
> > +		return PTR_ERR(smidata->clk_smi);
> > +
> > +	pm_runtime_enable(dev);
> > +	dev_set_drvdata(dev, smidata);
> > +	return ret;
> 
> ret is used uninitialised here, but you might as well just "return 0;" 
> and get rid of the variable entirely.

Thanks. I will change to "return 0" directly.

> 
> > +}
> 
> Robin.
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
