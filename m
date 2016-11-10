From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 04/16] drivers: iommu: make of_iommu_set/get_ops() DT
	agnostic
Date: Thu, 10 Nov 2016 11:05:29 +0000
Message-ID: <20161110110529.GB20209@red-moon>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com>
	<20161109141948.19244-5-lorenzo.pieralisi@arm.com>
	<c3136fae-144c-5949-3933-671b783671c8@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c3136fae-144c-5949-3933-671b783671c8-5wv7dgnIgG8@public.gmane.org>
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
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Dennis Chen <dennis.chen-5wv7dgnIgG8@public.gmane.org>, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Prem Mallappa <prem.mallappa-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 09, 2016 at 02:40:08PM +0000, Robin Murphy wrote:

[...]

> > +void fwnode_iommu_set_ops(struct fwnode_handle *fwnode,
> > +			  const struct iommu_ops *ops)
> > +{
> > +	struct iommu_fwentry *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
> > +
> > +	if (WARN_ON(!iommu))
> > +		return;
> > +
> > +	if (is_of_node(fwnode))
> 
> Nit: this check is actually redundant, since to_of_node() already does
> the right thing and of_node_get() is NULL-safe - iommu_fwspec_init()
> already works that way. On the other hand, though, it is perhaps more
> intuitive to see it explicitly, and since to_of_node() is inline it
> ought to result in the same object code (I've not checked, though).

I can easily fold this change in the final code and I think we
should keep this consistent so I am happy to change my code and
make the is_of_node() check implicit.

> Either way:
> 
> Reviewed-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Thank you !
Lorenzo

> > +		of_node_get(to_of_node(fwnode));
> > +
> > +	INIT_LIST_HEAD(&iommu->list);
> > +	iommu->fwnode = fwnode;
> > +	iommu->ops = ops;
> > +	spin_lock(&iommu_fwentry_lock);
> > +	list_add_tail(&iommu->list, &iommu_fwentry_list);
> > +	spin_unlock(&iommu_fwentry_lock);
> > +}
> > +
> > +const struct iommu_ops *fwnode_iommu_get_ops(struct fwnode_handle *fwnode)
> > +{
> > +	struct iommu_fwentry *node;
> > +	const struct iommu_ops *ops = NULL;
> > +
> > +	spin_lock(&iommu_fwentry_lock);
> > +	list_for_each_entry(node, &iommu_fwentry_list, list)
> > +		if (node->fwnode == fwnode) {
> > +			ops = node->ops;
> > +			break;
> > +		}
> > +	spin_unlock(&iommu_fwentry_lock);
> > +	return ops;
> > +}
> > +
> >  int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
> >  		      const struct iommu_ops *ops)
> >  {
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 5b82862..0f57ddc 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -96,45 +96,6 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
> >  }
> >  EXPORT_SYMBOL_GPL(of_get_dma_window);
> >  
> > -struct of_iommu_node {
> > -	struct list_head list;
> > -	struct device_node *np;
> > -	const struct iommu_ops *ops;
> > -};
> > -static LIST_HEAD(of_iommu_list);
> > -static DEFINE_SPINLOCK(of_iommu_lock);
> > -
> > -void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops)
> > -{
> > -	struct of_iommu_node *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
> > -
> > -	if (WARN_ON(!iommu))
> > -		return;
> > -
> > -	of_node_get(np);
> > -	INIT_LIST_HEAD(&iommu->list);
> > -	iommu->np = np;
> > -	iommu->ops = ops;
> > -	spin_lock(&of_iommu_lock);
> > -	list_add_tail(&iommu->list, &of_iommu_list);
> > -	spin_unlock(&of_iommu_lock);
> > -}
> > -
> > -const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> > -{
> > -	struct of_iommu_node *node;
> > -	const struct iommu_ops *ops = NULL;
> > -
> > -	spin_lock(&of_iommu_lock);
> > -	list_for_each_entry(node, &of_iommu_list, list)
> > -		if (node->np == np) {
> > -			ops = node->ops;
> > -			break;
> > -		}
> > -	spin_unlock(&of_iommu_lock);
> > -	return ops;
> > -}
> > -
> >  static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> >  {
> >  	struct of_phandle_args *iommu_spec = data;
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 436dc21..15d5478 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -351,6 +351,9 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
> >  		      const struct iommu_ops *ops);
> >  void iommu_fwspec_free(struct device *dev);
> >  int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
> > +void fwnode_iommu_set_ops(struct fwnode_handle *fwnode,
> > +			  const struct iommu_ops *ops);
> > +const struct iommu_ops *fwnode_iommu_get_ops(struct fwnode_handle *fwnode);
> >  
> >  #else /* CONFIG_IOMMU_API */
> >  
> > @@ -580,6 +583,17 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
> >  	return -ENODEV;
> >  }
> >  
> > +static inline void fwnode_iommu_set_ops(struct fwnode_handle *fwnode,
> > +					const struct iommu_ops *ops)
> > +{
> > +}
> > +
> > +static inline
> > +const struct iommu_ops *fwnode_iommu_get_ops(struct fwnode_handle *fwnode)
> > +{
> > +	return NULL;
> > +}
> > +
> >  #endif /* CONFIG_IOMMU_API */
> >  
> >  #endif /* __LINUX_IOMMU_H */
> > diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> > index e80b9c7..7681007 100644
> > --- a/include/linux/of_iommu.h
> > +++ b/include/linux/of_iommu.h
> > @@ -31,8 +31,16 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
> >  
> >  #endif	/* CONFIG_OF_IOMMU */
> >  
> > -void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
> > -const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
> > +static inline void of_iommu_set_ops(struct device_node *np,
> > +				    const struct iommu_ops *ops)
> > +{
> > +	fwnode_iommu_set_ops(&np->fwnode, ops);
> > +}
> > +
> > +static inline const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> > +{
> > +	return fwnode_iommu_get_ops(&np->fwnode);
> > +}
> >  
> >  extern struct of_device_id __iommu_of_table;
> >  
> > 
> 
