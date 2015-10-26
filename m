From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v5 5/6] iommu/mediatek: Add mt8173 IOMMU driver
Date: Mon, 26 Oct 2015 13:23:41 +0800
Message-ID: <1445837021.24436.8.camel@mhfsdcap03>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
	<1444357388-30257-6-git-send-email-yong.wu@mediatek.com>
	<20151014125309.GO27420@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151014125309.GO27420-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2015-10-14 at 14:53 +0200, Joerg Roedel wrote:
> On Fri, Oct 09, 2015 at 10:23:07AM +0800, Yong Wu wrote:
> > +	/*
> > +	 * There is a domain for each a iommu device in normal case.
> > +	 * But MTK only has one iommu domain called the m4u domain which all
> > +	 * the multimedia HW share. Here we reserve one as the m4u domain and
> > +	 * free the others.
> > +	 *
> > +	 * And the attach_device that from __iommu_setup_dma_ops
> > +	 * will be called earlier than probe.
> > +	 */
> 
> Okay, with this being the case, you need to put all devices behind one
> IOMMU into the same iommu-group, because the IOMMU can't really isolate
> the devices from each other.
> 
> > +static int mtk_iommu_add_device(struct device *dev)
> > +{
> > +	struct iommu_group *group;
> > +	struct mtk_iommu_client_priv *priv;
> > +	struct mtk_iommu_domain *m4udom;
> > +	struct iommu_domain *domain;
> > +	int ret;
> > +
> > +	if (!dev->archdata.iommu) /* Not a iommu client device */
> > +		return -ENODEV;
> > +
> > +	group = iommu_group_get(dev);
> > +	if (!group) {
> > +		group = iommu_group_alloc();
> > +		if (IS_ERR(group)) {
> > +			dev_err(dev, "Failed to allocate IOMMU group\n");
> > +			return PTR_ERR(group);
> > +		}
> > +	}
> > +
> > +	ret = iommu_group_add_device(group, dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add IOMMU group\n");
> > +		goto err_group_put;
> > +	}
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +	if (!domain) {
> > +		/*
> > +		 * Get the m4u iommu domain from the m4u device.
> > +		 * Attach all the client devices into the m4u domain.
> > +		 */
> > +		priv = dev->archdata.iommu;
> > +		m4udom = dev_get_drvdata(priv->m4udev);
> > +		ret = iommu_attach_group(&m4udom->domain, group);
> > +		if (ret)
> > +			dev_err(dev, "Failed to attach IOMMU group\n");
> > +	}
> > +
> > +err_group_put:
> > +	iommu_group_put(group);
> > +	return ret;
> > +}
> 
> Here it looks like you are allocating one group for each device. As I
> said, all devices need to be in one group.
> 
> 	Joerg
> 

Thanks for this suggestion. I have put all the iommu client devices into
the same iommu group, the code looks like below.
And I will send this in the next version after the Short descriptor is
reviewed.


static int mtk_iommu_add_device(struct device *dev)
{
	struct iommu_group *group;
	struct mtk_iommu_client_priv *priv;
	struct mtk_iommu_domain *m4udom;
	struct iommu_domain *domain;
	int ret;

	priv = dev->archdata.iommu;
	if (!priv) /* Not a iommu client device */
		return -ENODEV;
	m4udom = dev_get_drvdata(priv->m4udev);

	group = iommu_group_get(dev);
	if (!group) {
		/*
		 * All the iommu client devices are in the m4u domain,
		 * they all are in the same m4u iommu-group too here.
		 */
		if (!m4udom->m4u_group) {
			group = iommu_group_alloc();
			if (IS_ERR(group)) {
				dev_err(dev, "Failed to allocate IOMMU group\n");
				return PTR_ERR(group);
			}
			m4udom->m4u_group = group;
		} else {
			group = m4udom->m4u_group;
		}
	}

	ret = iommu_group_add_device(group, dev);
	if (ret) {
		dev_err(dev, "Failed to add IOMMU group\n");
		goto err_group_put;
	}

	domain = iommu_get_domain_for_dev(dev);
	if (!domain)
		ret = iommu_attach_group(&m4udom->domain, group);

err_group_put:
	iommu_group_put(group);
	return ret;
}
