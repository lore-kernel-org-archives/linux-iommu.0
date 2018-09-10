From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 17/40] iommu/arm-smmu-v3: Link domains and devices
Date: Mon, 10 Sep 2018 17:16:25 +0200
Message-ID: <b4154adb-313c-133b-6c5d-6e789bd754c7@redhat.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-18-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180511190641.23008-18-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: xieyisheng1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, liubo95-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

On 05/11/2018 09:06 PM, Jean-Philippe Brucker wrote:
> When removing a mapping from a domain, we need to send an invalidation to
> all devices that might have stored it in their Address Translation Cache
> (ATC). In addition when updating the context descriptor of a live domain,
> we'll need to send invalidations for all devices attached to it.
> 
> Maintain a list of devices in each domain, protected by a spinlock. It is
> updated every time we attach or detach devices to and from domains.
> 
> It needs to be a spinlock because we'll invalidate ATC entries from
> within hardirq-safe contexts, but it may be possible to relax the read
> side with RCU later.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 1d647104bccc..c892f012fb43 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -595,6 +595,11 @@ struct arm_smmu_device {
>  struct arm_smmu_master_data {
>  	struct arm_smmu_device		*smmu;
>  	struct arm_smmu_strtab_ent	ste;
> +
> +	struct arm_smmu_domain		*domain;
> +	struct list_head		list; /* domain->devices */
> +
> +	struct device			*dev;
This field addition and associated assignment in arm_smmu_attach_dev()
is not really documented in the commit message.

>  };
>  
>  /* SMMU private data for an IOMMU domain */
> @@ -618,6 +623,9 @@ struct arm_smmu_domain {
>  	};
>  
>  	struct iommu_domain		domain;
> +
> +	struct list_head		devices;
> +	spinlock_t			devices_lock;
>  };
>  
>  struct arm_smmu_option_prop {
> @@ -1470,6 +1478,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  	}
>  
>  	mutex_init(&smmu_domain->init_mutex);
> +	INIT_LIST_HEAD(&smmu_domain->devices);
> +	spin_lock_init(&smmu_domain->devices_lock);
> +
>  	return &smmu_domain->domain;
>  }
>  
> @@ -1685,7 +1696,17 @@ static void arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
>  
>  static void arm_smmu_detach_dev(struct device *dev)
>  {
> +	unsigned long flags;
>  	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
> +	struct arm_smmu_domain *smmu_domain = master->domain;
> +
> +	if (smmu_domain) {
> +		spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +		list_del(&master->list);
> +		spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> +
> +		master->domain = NULL;
> +	}
>  
>  	master->ste.assigned = false;
>  	arm_smmu_install_ste_for_dev(dev->iommu_fwspec);
> @@ -1694,6 +1715,7 @@ static void arm_smmu_detach_dev(struct device *dev)
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	int ret = 0;
> +	unsigned long flags;
>  	struct arm_smmu_device *smmu;
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_master_data *master;
> @@ -1729,6 +1751,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	}
>  
>  	ste->assigned = true;
> +	master->domain = smmu_domain;
> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	list_add(&master->list, &smmu_domain->devices);
it is not totally obvious to me why master->domain = smmu_domain isn't
within the lock either for consistency. Same when deleting the node.

Thanks

Eric
> +	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_BYPASS) {
>  		ste->s1_cfg = NULL;
> @@ -1847,6 +1874,7 @@ static int arm_smmu_add_device(struct device *dev)
>  			return -ENOMEM;
>  
>  		master->smmu = smmu;
> +		master->dev = dev;
>  		fwspec->iommu_priv = master;
>  	}
>  
> 
