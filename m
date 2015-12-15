From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 4/5] iommu/mediatek: Add mt8173 IOMMU driver
Date: Tue, 15 Dec 2015 12:37:34 +0000
Message-ID: <5670098E.40601@arm.com>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
 <1449568153-15643-5-git-send-email-yong.wu@mediatek.com>
 <20151214141656.GG18805@8bytes.org> <1450150132.22854.57.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450150132.22854.57.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 15/12/15 03:28, Yong Wu wrote:
> On Mon, 2015-12-14 at 15:16 +0100, Joerg Roedel wrote:
>> On Tue, Dec 08, 2015 at 05:49:12PM +0800, Yong Wu wrote:
>>> +static int mtk_iommu_attach_device(struct iommu_domain *domain,
>>> +				   struct device *dev)
>>> +{
>>> +	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
>>> +	struct mtk_iommu_client_priv *priv = dev->archdata.iommu;
>>> +	struct mtk_iommu_data *data;
>>> +	int ret;
>>> +
>>> +	if (!priv)
>>> +		return -ENODEV;
>>> +
>>> +	data = dev_get_drvdata(priv->m4udev);
>>> +	if (!data) {
>>> +		/*
>>> +		 * The DMA core will run earlier than this probe, and it will
>>> +		 * create a default iommu domain for each a iommu device.
>>> +		 * But here there is only one domain called the m4u domain
>>> +		 * which all the multimedia HW share.
>>> +		 * The default domain isn't needed here.
>>> +		 */
>>
>> The iommu core creates one domain per iommu-group. In your case this
>> means one default domain per iommu in the system.
>
> Yes. The iommu core will create one domain per iommu-group.
> see the next "if" here.
>
> But the domain here is created by the current DMA64. It's from this
> function do_iommu_attach which will be called too early and will help
> create a default domain for each a iommu device.(my codebase is
> v4.4-rc1).

I still don't really understand the problem here. The M4U device is 
created early in mtk_iommu_init_fn, so it should be probed and ready to 
go long before anything else. Indeed, for your mtk_iommu_device_group() 
callback to work then everything must already be happening in the right 
order - add_device will only call iommu_group_get_for_dev() if of_xlate 
has populated dev->archdata.iommu, and of_xlate will only do that if the 
M4U was up and running before the client device started probing. 
Furthermore, if mtk_iommu_device_group() *does* work, then the IOMMU 
core will go ahead and allocate the default domain there and then, which 
the arch code should find and use later.

The potential issue I *do* see, looking more closely, is that 
iommu_group_get_for_dev() is setting group->domain but not calling the 
attach_dev callback, which looks wrong...

>
> //=====the next "if"===========
> } else if (!data->m4u_dom) {
> 	/*
> 	 * While a device is added into a iommu group, the iommu core
> 	 * will create a default domain for each a iommu group.
> 	 * This default domain is reserved as the m4u domain and is
> 	 * initiated here.
> 	 */
> 	data->m4u_dom = dom;
> 	if (domain->type == IOMMU_DOMAIN_DMA) {
> 		ret = iommu_dma_init_domain(domain, 0,
> 					    DMA_BIT_MASK(32));
> 		if (ret)
> 			goto err_uninit_dom;
> 	}
>
> 	ret = mtk_iommu_domain_finalise(data);
> 	if (ret)
> 		goto err_uninit_dom;
> }
> //======================
>
>>
>>> +		iommu_domain_free(domain);
>>
>> This function is not supposed to free the domain passed to it.
>
> As above this domain is created in the do_iommu_attach which will help
> create a default domain for each a iommu device.
> We don't need this default domain!
>
> If we don't free it here, there will be a memory leak.
>
>  From Robin's comment, He will improve the sequence of the
> __iommu_setup_dma_ops in the future.

That already happened. The final version of the arm64 code which was 
merged makes sure that the IOMMU driver always sees the callbacks in the 
desired of_xlate -> add_device -> attach_dev order. The whole point of 
the comment below is that the driver itself *doesn't* have to care about 
the awkward way in which that is currently achieved.

> /*
>   * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
>   * everything it needs to - the device is only partially created and the
>   * IOMMU driver hasn't seen it yet, so it can't have a group. Thus we
>   * need this delayed attachment dance. Once IOMMU probe ordering is
> sorted
>   * to move the arch_setup_dma_ops() call later, all the notifier bits
> below
>   * become unnecessary, and will go away.
>   */
>
> /*
>   * Best case: The device is either part of a group which was
>   * already attached to a domain in a previous call, or it's
>   * been put in a default DMA domain by the IOMMU core.
>   */

That was before Joerg made the device_group changes which enabled proper 
default domains for platform devices - with those, we should be now be 
hitting the "best case" behaviour every time. In fact I think the "fake 
default domain" workaround shouldn't be needed at all any more, so I 
will add removing it to my giant list of things to do.

>     But there is no this patch currently, so I add iommu_domain_free
> here.
>
>     "free the domain" here looks really not good. Then I delete the
> iommu_domain_free here(allow this memory leak right now), is it ok?
> (It will also works after Robin's change in the future.)
>
>>
>>> +static int mtk_iommu_add_device(struct device *dev)
>>> +{
>>> +	struct iommu_group *group;
>>> +
>>> +	if (!dev->archdata.iommu) /* Not a iommu client device */
>>> +		return -ENODEV;
>>> +
>>> +	group = iommu_group_get_for_dev(dev);
>>> +	if (IS_ERR(group))
>>> +		return PTR_ERR(group);
>>> +
>>> +	iommu_group_put(group);
>>> +	return 0;
>>> +}
>>
>> [...]
>>
>>> +static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>>> +{
>>> +	struct mtk_iommu_data *data;
>>> +	struct mtk_iommu_client_priv *priv;
>>> +
>>> +	priv = dev->archdata.iommu;
>>> +	if (!priv)
>>> +		return ERR_PTR(-ENODEV);
>>> +
>>> +	/* All the client devices are in the same m4u iommu-group */
>>> +	data = dev_get_drvdata(priv->m4udev);
>>> +	if (!data->m4u_group) {
>>> +		data->m4u_group = iommu_group_alloc();
>>> +		if (IS_ERR(data->m4u_group))
>>> +			dev_err(dev, "Failed to allocate M4U IOMMU group\n");
>>> +	}
>>> +	return data->m4u_group;
>>> +}

As long as this works as expected, then AFAICS you shouldn't have to 
have *any* special-case behaviour or tracking of domains at all.

Robin.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
