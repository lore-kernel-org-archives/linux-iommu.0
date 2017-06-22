From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 3/9] iommu: Introduce iommu do invalidate API function
Date: Thu, 22 Jun 2017 16:52:28 -0600
Message-ID: <20170622165228.7ee7889e@w520.home>
References: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1497478983-77580-4-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1497478983-77580-4-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 14 Jun 2017 15:22:57 -0700
Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> When a SVM capable device is assigned to a guest, the first level page
> tables are owned by the guest and the guest PASID table pointer is
> linked to the device context entry of the physical IOMMU.
> 
> Host IOMMU driver has no knowledge of caching structure updates unless
> the guest invalidation activities are passed down to the host. The
> primary usage is derived from emulated IOMMU in the guest, where QEMU
> can trap invalidation activities before pass them down the
> host/physical IOMMU. There are IOMMU architectural specific actions
> need to be taken which requires the generic APIs introduced in this
> patch to have opaque data in the tlb_invalidate_info argument.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/iommu.c      | 13 +++++++++++++
>  include/linux/iommu.h      | 11 +++++++++++
>  include/uapi/linux/iommu.h |  4 ++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 494309b..c786370 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1347,6 +1347,19 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_unbind_pasid_table);
>  
> +int iommu_do_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info)
> +{
> +	int ret = 0;
> +
> +	if (unlikely(domain->ops->do_invalidate == NULL))
> +		return -ENODEV;
> +
> +	ret = domain->ops->do_invalidate(domain, dev, inv_info);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_do_invalidate);


s/do_invalidate/invalidate/?  'do_invalidate' seems like something
'invalidate' might call, not the exported interface.  Invalidate what?
Is that entirely buried in the opaque data?  It seems like there are
plenty of things to be invalidated that could be common.


> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 7122add..2cdbaa3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -232,6 +232,8 @@ struct iommu_ops {
>  				struct pasid_table_info *pasidt_binfo);
>  	int (*unbind_pasid_table)(struct iommu_domain *domain,
>  				struct device *dev);
> +	int (*do_invalidate)(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info);
>  
>  	unsigned long pgsize_bitmap;
>  };
> @@ -293,6 +295,9 @@ extern int iommu_bind_pasid_table(struct iommu_domain *domain,
>  		struct device *dev, struct pasid_table_info *pasidt_binfo);
>  extern int iommu_unbind_pasid_table(struct iommu_domain *domain,
>  				struct device *dev);
> +extern int iommu_do_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info);
> +
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
>  		     phys_addr_t paddr, size_t size, int prot);
> @@ -660,6 +665,12 @@ int iommu_unbind_pasid_table(struct iommu_domain *domain, struct device *dev)
>  	return -EINVAL;
>  }
>  
> +static inline int iommu_do_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct tlb_invalidate_info *inv_info)
> +{
> +	return -EINVAL;
> +}
> +
>  #endif /* CONFIG_IOMMU_API */
>  
>  #endif /* __LINUX_IOMMU_H */
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 5ef0e7c..fcee18f 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -29,5 +29,9 @@ struct pasid_table_info {
>  	__u8	opaque[];
>  };
>  
> +struct tlb_invalidate_info {
> +	__u32	model;
> +	__u8	opaque[];

Why did we specify a length (and then not use it anyway) of opaque data
field in pasid_table_info but not here?

> +};
>  
>  #endif /* _UAPI_IOMMU_H */
