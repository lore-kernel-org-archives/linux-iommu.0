From: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 28/37] iommu/arm-smmu-v3: Maintain a SID->device structure
Date: Thu, 8 Mar 2018 17:34:31 +0000
Message-ID: <20180308183431.00005f86@huawei.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-29-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180212183352.22730-29-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 12 Feb 2018 18:33:43 +0000
Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org> wrote:

> When handling faults from the event or PRI queue, we need to find the
> struct device associated to a SID. Add a rb_tree to keep track of SIDs.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
nipick inline.


> ---
>  drivers/iommu/arm-smmu-v3.c | 105 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index c5b3a43becaf..2430b2140f8d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -615,10 +615,19 @@ struct arm_smmu_device {
>  	/* IOMMU core code handle */
>  	struct iommu_device		iommu;
>  
> +	struct rb_root			streams;
> +	struct mutex			streams_mutex;
> +
>  	/* Notifier for the fault queue */
>  	struct notifier_block		faultq_nb;
>  };
>  
> +struct arm_smmu_stream {
> +	u32				id;
> +	struct arm_smmu_master_data	*master;
> +	struct rb_node			node;
> +};
> +
>  /* SMMU private data for each master */
>  struct arm_smmu_master_data {
>  	struct arm_smmu_device		*smmu;
> @@ -626,6 +635,7 @@ struct arm_smmu_master_data {
>  
>  	struct arm_smmu_domain		*domain;
>  	struct list_head		list; /* domain->devices */
> +	struct arm_smmu_stream		*streams;
>  
>  	struct device			*dev;
>  
> @@ -1250,6 +1260,31 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  	return 0;
>  }
>  
> +static struct arm_smmu_master_data *
> +arm_smmu_find_master(struct arm_smmu_device *smmu, u32 sid)
> +{
> +	struct rb_node *node;
> +	struct arm_smmu_stream *stream;
> +	struct arm_smmu_master_data *master = NULL;
> +
> +	mutex_lock(&smmu->streams_mutex);
> +	node = smmu->streams.rb_node;
> +	while (node) {
> +		stream = rb_entry(node, struct arm_smmu_stream, node);
> +		if (stream->id < sid) {
> +			node = node->rb_right;
> +		} else if (stream->id > sid) {
> +			node = node->rb_left;
> +		} else {
> +			master = stream->master;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&smmu->streams_mutex);
> +
> +	return master;
> +}
> +
>  /* IRQ and event handlers */
>  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  {
> @@ -2146,6 +2181,71 @@ static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
>  	return sid < limit;
>  }
>  
> +static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
> +				  struct arm_smmu_master_data *master)
> +{
> +	int i;
> +	int ret = 0;
> +	struct arm_smmu_stream *new_stream, *cur_stream;
> +	struct rb_node **new_node, *parent_node = NULL;
> +	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
> +
> +	master->streams = kcalloc(fwspec->num_ids,
> +				  sizeof(struct arm_smmu_stream), GFP_KERNEL);
> +	if (!master->streams)
> +		return -ENOMEM;
> +
> +	mutex_lock(&smmu->streams_mutex);
> +	for (i = 0; i < fwspec->num_ids && !ret; i++) {
> +		new_stream = &master->streams[i];
> +		new_stream->id = fwspec->ids[i];
> +		new_stream->master = master;
> +
> +		new_node = &(smmu->streams.rb_node);
> +		while (*new_node) {
> +			cur_stream = rb_entry(*new_node, struct arm_smmu_stream,
> +					      node);
> +			parent_node = *new_node;
> +			if (cur_stream->id > new_stream->id) {
> +				new_node = &((*new_node)->rb_left);
> +			} else if (cur_stream->id < new_stream->id) {
> +				new_node = &((*new_node)->rb_right);
> +			} else {
> +				dev_warn(master->dev,
> +					 "stream %u already in tree\n",
> +					 cur_stream->id);
> +				ret = -EINVAL;
> +				break;
> +			}
> +		}
> +
> +		if (!ret) {
> +			rb_link_node(&new_stream->node, parent_node, new_node);
> +			rb_insert_color(&new_stream->node, &smmu->streams);
> +		}
> +	}
> +	mutex_unlock(&smmu->streams_mutex);
> +
> +	return ret;
> +}
> +
> +static void arm_smmu_remove_master(struct arm_smmu_device *smmu,
> +				   struct arm_smmu_master_data *master)
> +{
> +	int i;
> +	struct iommu_fwspec *fwspec = master->dev->iommu_fwspec;
> +
> +	if (!master->streams)
> +		return;
> +
> +	mutex_lock(&smmu->streams_mutex);
> +	for (i = 0; i < fwspec->num_ids; i++)
> +		rb_erase(&master->streams[i].node, &smmu->streams);
> +	mutex_unlock(&smmu->streams_mutex);
> +
> +	kfree(master->streams);
> +}
> +
>  static struct iommu_ops arm_smmu_ops;
>  
>  static int arm_smmu_add_device(struct device *dev)
> @@ -2198,6 +2298,7 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	group = iommu_group_get_for_dev(dev);
>  	if (!IS_ERR(group)) {
> +		arm_smmu_insert_master(smmu, master);
There are some error cases it would be good to take notice off when
inserting the master.  Admittedly the same is true of iommu_device_link
so I guess you are keeping with the existing code style.

Would also be nice if the later bit of rework to drop these out
of the if statement was done before this patch in the series.


>  		iommu_group_put(group);
>  		iommu_device_link(&smmu->iommu, dev);
>  	}
> @@ -2218,6 +2319,7 @@ static void arm_smmu_remove_device(struct device *dev)
>  	smmu = master->smmu;
>  	if (master && master->ste.assigned)
>  		arm_smmu_detach_dev(dev);
> +	arm_smmu_remove_master(smmu, master);
>  	iommu_group_remove_device(dev);
>  	iommu_device_unlink(&smmu->iommu, dev);
>  	kfree(master);
> @@ -2527,6 +2629,9 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
>  	int ret;
>  
>  	atomic_set(&smmu->sync_nr, 0);
> +	mutex_init(&smmu->streams_mutex);
> +	smmu->streams = RB_ROOT;
> +
>  	ret = arm_smmu_init_queues(smmu);
>  	if (ret)
>  		return ret;
