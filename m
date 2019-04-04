From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu/arm-smmu-v3: Link domains and devices
Date: Thu, 4 Apr 2019 15:39:24 +0100
Message-ID: <20190404143924.GB27823@fuggles.cambridge.arm.com>
References: <20190320173634.21895-1-jean-philippe.brucker@arm.com>
	<20190320173634.21895-3-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190320173634.21895-3-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
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
Cc: zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Jean-Philippe,

First off, thanks for posting this: it's definitely something that I'm keen
to support, and getting bits in a piece at a time is probably a good idea.

On Wed, Mar 20, 2019 at 05:36:32PM +0000, Jean-Philippe Brucker wrote:
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
> index d3880010c6cf..66a29c113dbc 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -594,6 +594,11 @@ struct arm_smmu_device {
>  struct arm_smmu_master_data {
>  	struct arm_smmu_device		*smmu;
>  	struct arm_smmu_strtab_ent	ste;
> +
> +	struct arm_smmu_domain		*domain;
> +	struct list_head		domain_head;
> +
> +	struct device			*dev;
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
> @@ -1493,6 +1501,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  	}
>  
>  	mutex_init(&smmu_domain->init_mutex);
> +	INIT_LIST_HEAD(&smmu_domain->devices);
> +	spin_lock_init(&smmu_domain->devices_lock);

I'm wondering whether we can't take this a bit further and re-organise the
data structures to make this a little simpler overall. Something along the
lines of:

	struct arm_smmu_master_data {
		struct list_head		list; // masters in the same domain
		struct arm_smmu_device		*smmu;
		unsigned int			num_sids;
		u32				*sids; // Points into fwspec
		struct arm_smmu_domain		*domain; // NULL -> !assigned
	};

and then just add a list_head into struct arm_smmu_domain to track the
masters that have been attached (if you're feeling brave, you could put
this into the s1_cfg).

The ATC invalidation logic would then be:

  - Detaching a device: walk over the sids from the master data
  - Unmapping a range from a domain: walk over the attached masters

I think this would also allow us to remove struct arm_smmu_strtab_ent
completely.

Dunno: this is one of the those things where you really have to try it
to figure out why it doesn't work...

Will
