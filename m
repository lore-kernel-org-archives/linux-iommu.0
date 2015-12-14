From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 4/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Mon, 14 Dec 2015 15:16:57 +0100
Message-ID: <20151214141656.GG18805@8bytes.org>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
	<1449568153-15643-5-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1449568153-15643-5-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Dec 08, 2015 at 05:49:12PM +0800, Yong Wu wrote:
> +static int mtk_iommu_attach_device(struct iommu_domain *domain,
> +				   struct device *dev)
> +{
> +	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> +	struct mtk_iommu_client_priv *priv = dev->archdata.iommu;
> +	struct mtk_iommu_data *data;
> +	int ret;
> +
> +	if (!priv)
> +		return -ENODEV;
> +
> +	data = dev_get_drvdata(priv->m4udev);
> +	if (!data) {
> +		/*
> +		 * The DMA core will run earlier than this probe, and it will
> +		 * create a default iommu domain for each a iommu device.
> +		 * But here there is only one domain called the m4u domain
> +		 * which all the multimedia HW share.
> +		 * The default domain isn't needed here.
> +		 */

The iommu core creates one domain per iommu-group. In your case this
means one default domain per iommu in the system.

> +		iommu_domain_free(domain);

This function is not supposed to free the domain passed to it.

> +static int mtk_iommu_add_device(struct device *dev)
> +{
> +	struct iommu_group *group;
> +
> +	if (!dev->archdata.iommu) /* Not a iommu client device */
> +		return -ENODEV;
> +
> +	group = iommu_group_get_for_dev(dev);
> +	if (IS_ERR(group))
> +		return PTR_ERR(group);
> +
> +	iommu_group_put(group);
> +	return 0;
> +}

[...]

> +static struct iommu_group *mtk_iommu_device_group(struct device *dev)
> +{
> +	struct mtk_iommu_data *data;
> +	struct mtk_iommu_client_priv *priv;
> +
> +	priv = dev->archdata.iommu;
> +	if (!priv)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* All the client devices are in the same m4u iommu-group */
> +	data = dev_get_drvdata(priv->m4udev);
> +	if (!data->m4u_group) {
> +		data->m4u_group = iommu_group_alloc();
> +		if (IS_ERR(data->m4u_group))
> +			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
> +	}
> +	return data->m4u_group;
> +}

This looks much better than before, thanks.
