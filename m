From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Tue, 11 Aug 2015 17:39:47 +0200
Message-ID: <20150811153947.GF14980@8bytes.org>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
	<1438597279-2937-6-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 03, 2015 at 06:21:18PM +0800, Yong Wu wrote:
> +/*
> + * There is only one iommu domain called the m4u domain that
> + * all Multimedia modules share.
> + */
> +static struct mtk_iommu_domain	*m4udom;

What is the reason you only implement one domain? Can't the IOMMU
isolate different devices from each other?


> +static struct iommu_domain *mtk_iommu_domain_alloc(unsigned type)
> +{
> +	struct mtk_iommu_domain *priv;
> +
> +	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
> +		return NULL;
> +
> +	if (m4udom)/* The m4u domain exist. */
> +		return &m4udom->domain;

This is not going to work. If you always return the same domain the
iommu core might re-initialize domain state (and overwrite changed
state). At the moment this is only the domain-type which will change
every time this function is called, but there might be more.

> +static int mtk_iommu_add_device(struct device *dev)
> +{
> +	struct iommu_group *group;
> +	int ret;
> +
> +	if (!dev->archdata.iommu) /* Not a iommu client device */
> +		return -ENODEV;
> +
> +	group = iommu_group_get(dev);
> +	if (!group) {
> +		group = iommu_group_alloc();
> +		if (IS_ERR(group)) {
> +			dev_err(dev, "Failed to allocate IOMMU group\n");
> +			return PTR_ERR(group);
> +		}
> +	}
> +
> +	ret = iommu_group_add_device(group, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add IOMMU group\n");
> +		goto err_group_put;
> +	}
> +
> +	ret = iommu_attach_group(&m4udom->domain, group);
> +	if (ret)
> +		dev_err(dev, "Failed to attach IOMMU group\n");
> +
> +err_group_put:
> +	iommu_group_put(group);
> +	return ret;
> +}

Putting every device into its own group indicates that the IOMMU can
isolate between single devices on the bus, which makes it even more
questionable that you only allow one domain for the whole driver.


	Joerg
