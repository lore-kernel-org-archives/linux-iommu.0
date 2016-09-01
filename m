From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 11/19] iommu/arm-smmu: Refactor mmu-masters handling
Date: Thu, 1 Sep 2016 19:47:23 +0100
Message-ID: <20160901184723.GV6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<00301aa60323bb94588d078f2962feea0cb45c72.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <00301aa60323bb94588d078f2962feea0cb45c72.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 23, 2016 at 08:05:22PM +0100, Robin Murphy wrote:
> To be able to support the generic bindings and handle of_xlate() calls,
> we need to be able to associate SMMUs and stream IDs directly with
> devices *before* allocating IOMMU groups. Furthermore, to support real
> default domains with multi-device groups we also have to handle domain
> attach on a per-device basis, as the "whole group at a time" assumption
> fails to properly handle subsequent devices added to a group after the
> first has already triggered default domain creation and attachment.
> 
> To that end, use the now-vacant dev->archdata.iommu field for easy
> config and SMMU instance lookup, and unify config management by chopping
> down the platform-device-specific tree and probing the "mmu-masters"
> property on-demand instead. This may add a bit of one-off overhead to
> initially adding a new device, but we're about to deprecate that binding
> in favour of the inherently-more-efficient generic ones anyway.
> 
> For the sake of simplicity, this patch does temporarily regress the case
> of aliasing PCI devices by losing the duplicate stream ID detection that
> the previous per-group config had. Stay tuned, because we'll be back to
> fix that in a better and more general way momentarily...
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 382 +++++++++++++----------------------------------
>  1 file changed, 107 insertions(+), 275 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 22c093030322..9066fd1399d4 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -317,18 +317,13 @@ struct arm_smmu_smr {
>  };
>  
>  struct arm_smmu_master_cfg {
> +	struct arm_smmu_device		*smmu;
>  	int				num_streamids;
>  	u16				streamids[MAX_MASTER_STREAMIDS];
>  	s16				smendx[MAX_MASTER_STREAMIDS];
>  };
>  #define INVALID_SMENDX			-1
>  
> -struct arm_smmu_master {
> -	struct device_node		*of_node;
> -	struct rb_node			node;
> -	struct arm_smmu_master_cfg	cfg;
> -};
> -
>  struct arm_smmu_device {
>  	struct device			*dev;
>  
> @@ -376,7 +371,6 @@ struct arm_smmu_device {
>  	unsigned int			*irqs;
>  
>  	struct list_head		list;
> -	struct rb_root			masters;
>  
>  	u32				cavium_id_base; /* Specific to Cavium */
>  };
> @@ -415,12 +409,6 @@ struct arm_smmu_domain {
>  	struct iommu_domain		domain;
>  };
>  
> -struct arm_smmu_phandle_args {
> -	struct device_node *np;
> -	int args_count;
> -	uint32_t args[MAX_MASTER_STREAMIDS];
> -};
> -
>  static DEFINE_SPINLOCK(arm_smmu_devices_lock);
>  static LIST_HEAD(arm_smmu_devices);
>  
> @@ -462,132 +450,89 @@ static struct device_node *dev_get_dev_node(struct device *dev)
>  
>  		while (!pci_is_root_bus(bus))
>  			bus = bus->parent;
> -		return bus->bridge->parent->of_node;
> +		return of_node_get(bus->bridge->parent->of_node);
>  	}
>  
> -	return dev->of_node;
> +	return of_node_get(dev->of_node);
>  }
>  
> -static struct arm_smmu_master *find_smmu_master(struct arm_smmu_device *smmu,
> -						struct device_node *dev_node)
> +static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias, void *data)
>  {
> -	struct rb_node *node = smmu->masters.rb_node;
> -
> -	while (node) {
> -		struct arm_smmu_master *master;
> -
> -		master = container_of(node, struct arm_smmu_master, node);
> -
> -		if (dev_node < master->of_node)
> -			node = node->rb_left;
> -		else if (dev_node > master->of_node)
> -			node = node->rb_right;
> -		else
> -			return master;
> -	}
> -
> -	return NULL;
> +	*((__be32 *)data) = cpu_to_be32(alias);
> +	return 0; /* Continue walking */
>  }
>  
> -static struct arm_smmu_master_cfg *
> -find_smmu_master_cfg(struct device *dev)
> +static int __find_legacy_master_phandle(struct device *dev, void *data)
>  {
> -	struct arm_smmu_master_cfg *cfg = NULL;
> -	struct iommu_group *group = iommu_group_get(dev);
> +	struct of_phandle_iterator *it = *(void **)data;
> +	struct device_node *np = it->node;
> +	int err;
>  
> -	if (group) {
> -		cfg = iommu_group_get_iommudata(group);
> -		iommu_group_put(group);
> -	}
> -
> -	return cfg;
> -}
> -
> -static int insert_smmu_master(struct arm_smmu_device *smmu,
> -			      struct arm_smmu_master *master)
> -{
> -	struct rb_node **new, *parent;
> -
> -	new = &smmu->masters.rb_node;
> -	parent = NULL;
> -	while (*new) {
> -		struct arm_smmu_master *this
> -			= container_of(*new, struct arm_smmu_master, node);
> -
> -		parent = *new;
> -		if (master->of_node < this->of_node)
> -			new = &((*new)->rb_left);
> -		else if (master->of_node > this->of_node)
> -			new = &((*new)->rb_right);
> -		else
> -			return -EEXIST;
> -	}
> -
> -	rb_link_node(&master->node, parent, new);
> -	rb_insert_color(&master->node, &smmu->masters);
> -	return 0;
> -}
> -
> -static int register_smmu_master(struct arm_smmu_device *smmu,
> -				struct device *dev,
> -				struct arm_smmu_phandle_args *masterspec)
> -{
> -	int i;
> -	struct arm_smmu_master *master;
> -
> -	master = find_smmu_master(smmu, masterspec->np);
> -	if (master) {
> -		dev_err(dev,
> -			"rejecting multiple registrations for master device %s\n",
> -			masterspec->np->name);
> -		return -EBUSY;
> -	}
> -
> -	if (masterspec->args_count > MAX_MASTER_STREAMIDS) {
> -		dev_err(dev,
> -			"reached maximum number (%d) of stream IDs for master device %s\n",
> -			MAX_MASTER_STREAMIDS, masterspec->np->name);
> -		return -ENOSPC;
> -	}
> -
> -	master = devm_kzalloc(dev, sizeof(*master), GFP_KERNEL);
> -	if (!master)
> -		return -ENOMEM;
> -
> -	master->of_node			= masterspec->np;
> -	master->cfg.num_streamids	= masterspec->args_count;
> -
> -	for (i = 0; i < master->cfg.num_streamids; ++i) {
> -		u16 streamid = masterspec->args[i];
> -
> -		if (!(smmu->features & ARM_SMMU_FEAT_STREAM_MATCH) &&
> -		     (streamid >= smmu->num_mapping_groups)) {
> -			dev_err(dev,
> -				"stream ID for master device %s greater than maximum allowed (%d)\n",
> -				masterspec->np->name, smmu->num_mapping_groups);
> -			return -ERANGE;
> +	of_for_each_phandle(it, err, dev->of_node, "mmu-masters",
> +			    "#stream-id-cells", 0)
> +		if (it->node == np) {
> +			*(void **)data = dev;
> +			return 1;
>  		}
> -		master->cfg.streamids[i] = streamid;
> -		master->cfg.smendx[i] = INVALID_SMENDX;
> -	}
> -	return insert_smmu_master(smmu, master);
> +	it->node = np;
> +	return err;
>  }
>  
> -static struct arm_smmu_device *find_smmu_for_device(struct device *dev)
> +static int arm_smmu_register_legacy_master(struct device *dev)
>  {
>  	struct arm_smmu_device *smmu;
> -	struct arm_smmu_master *master = NULL;
> -	struct device_node *dev_node = dev_get_dev_node(dev);
> +	struct arm_smmu_master_cfg *cfg;
> +	struct device_node *np;
> +	struct of_phandle_iterator it;
> +	void *data = &it;
> +	__be32 pci_sid;
> +	int err;
>  
> +	np = dev_get_dev_node(dev);
> +	if (!np || !of_find_property(np, "#stream-id-cells", NULL)) {
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +
> +	it.node = np;
>  	spin_lock(&arm_smmu_devices_lock);
>  	list_for_each_entry(smmu, &arm_smmu_devices, list) {
> -		master = find_smmu_master(smmu, dev_node);
> -		if (master)
> +		err = __find_legacy_master_phandle(smmu->dev, &data);
> +		if (err)
>  			break;
>  	}
>  	spin_unlock(&arm_smmu_devices_lock);
> +	of_node_put(np);
> +	if (err == 0)
> +		return -ENODEV;
> +	if (err < 0)
> +		return err;
>  
> -	return master ? smmu : NULL;
> +	if (it.cur_count > MAX_MASTER_STREAMIDS) {
> +		dev_err(smmu->dev,
> +			"reached maximum number (%d) of stream IDs for master device %s\n",
> +			MAX_MASTER_STREAMIDS, dev_name(dev));
> +		return -ENOSPC;
> +	}
> +	if (dev_is_pci(dev)) {
> +		/* "mmu-masters" assumes Stream ID == Requester ID */
> +		pci_for_each_dma_alias(to_pci_dev(dev), __arm_smmu_get_pci_sid,
> +				       &pci_sid);
> +		it.cur = &pci_sid;
> +		it.cur_count = 1;
> +	}
> +
> +	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return -ENOMEM;
> +
> +	cfg->smmu = smmu;
> +	dev->archdata.iommu = cfg;
> +
> +	while (it.cur_count--)
> +		cfg->streamids[cfg->num_streamids++] = be32_to_cpup(it.cur++);

I pronounce this construct, the "Murphy Device"! At least it didn't survive
until the end of the series :p

Will
