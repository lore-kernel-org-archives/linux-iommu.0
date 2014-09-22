From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v3 4/7] iommu: provide helper function to configure
	an IOMMU for an of master
Date: Mon, 22 Sep 2014 18:13:52 +0100
Message-ID: <20140922171352.GF7936@arm.com>
References: <1410539695-29128-1-git-send-email-will.deacon@arm.com>
	<1410539695-29128-5-git-send-email-will.deacon@arm.com>
	<4801495.ovhjCBfpBC@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4801495.ovhjCBfpBC@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 18, 2014 at 12:13:13PM +0100, Laurent Pinchart wrote:
> Hi Will,

Hi Laurent,

> Thank you for the patch.

Sorry for the delay in replying, I was at Connect last week and the email
has backed up.

> On Friday 12 September 2014 17:34:52 Will Deacon wrote:
> > The generic IOMMU device-tree bindings can be used to add arbitrary OF
> > masters to an IOMMU with a compliant binding.
> > 
> > This patch introduces of_iommu_configure, which does exactly that. A
> > list of iommu_dma_mapping structures are created for each device, which
> > represent the set of IOMMU instances through which the device can
> > master. The list is protected by a kref count and freed when no users
> > remain. It is expected that DMA-mapping code will take a reference if it
> > wishes to make use of the IOMMU information.

[...]

> > +struct iommu_dma_mapping *of_iommu_configure(struct device *dev)
> > +{
> > +	struct of_phandle_args iommu_spec;
> > +	struct iommu_dma_mapping *mapping;
> > +	struct device_node *np;
> > +	struct iommu_data *iommu = NULL;
> > +	int idx = 0;
> > +
> > +	/*
> > +	 * We don't currently walk up the tree looking for a parent IOMMU.
> > +	 * See the `Notes:' section of
> > +	 * Documentation/devicetree/bindings/iommu/iommu.txt
> > +	 */
> > +	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
> > +					   "#iommu-cells", idx,
> > +					   &iommu_spec)) {
> > +		struct iommu_data *data;
> > +
> > +		np = iommu_spec.np;
> > +		data = of_iommu_get_data(np);
> > +
> > +		if (!data || !data->ops || !data->ops->of_xlate)
> > +			goto err_put_node;
> > +
> > +		if (!iommu) {
> > +			iommu = data;
> > +		} else if (iommu != data) {
> > +			/* We don't currently support multi-IOMMU masters */
> > +			pr_warn("Rejecting device %s with multiple IOMMU instances\n",
> > +				dev_name(dev));
> > +			goto err_put_node;
> > +		}
> > +
> > +		if (!data->ops->of_xlate(dev, &iommu_spec))
> > +			goto err_put_node;
> > +
> > +		of_node_put(np);
> > +		idx++;
> > +	}
> > +
> > +	if (!iommu)
> > +		return NULL;
> > +
> > +	mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
> > +	if (!mapping)
> > +		return NULL;
> > +
> > +	kref_init(&mapping->kref);
> > +	INIT_LIST_HEAD(&mapping->node);
> 
> I might be missing something, but that doesn't seem to match the commit 
> message. This creates a single iommu_dma_mapping per device, where is the list 
> supposed to be populated ?

Right. I currently only populate the first node in the list, and the loop
above barfs if we find multiple IOMMUs. I was hoping you'd add support for
that later on, as you mentioned the need for this so I guess you can test it
too?

> > +void of_iommu_deconfigure(struct kref *kref)
> > +{
> > +	struct iommu_dma_mapping *mapping, *curr, *next;
> > +
> > +	mapping = container_of(kref, struct iommu_dma_mapping, kref);
> > +	list_for_each_entry_safe(curr, next, &mapping->node, node) {
> > +		list_del(&curr->node);
> > +		kfree(curr);
> > +	}
> 
> Don't you need to also kfree(mapping) here ?

Yup, thanks.

> > +}
> > +
> 
> Do you expect other users of of_iommu_deconfigure() than kref_put() ? If not, 
> how about exposing an of_iommu_put(struct iommu_dma_mapping *) that would call 
> kref_put() internally, and hiding of_iommu_deconfigure() ?

That's a good idea, I'll do that.

> >  void __init of_iommu_init(void)
> >  {
> >  	struct device_node *np;
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 1e944e77d38d..e60e52d82db9 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -62,6 +62,14 @@ struct dma_map_ops {
> >  	int is_phys;
> >  };
> > 
> > +struct iommu_data;
> > +
> > +struct iommu_dma_mapping {
> > +	struct iommu_data *iommu;
> > +	struct list_head node;
> > +	struct kref kref;
> > +};
> 
> Could you please document the structure with kerneldoc ?

Ok, I'll try!

Will
