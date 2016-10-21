From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC,v1,2/2] vfio/iommu-type1: set only stage 2 translation
Date: Fri, 21 Oct 2016 08:27:03 -0600
Message-ID: <20161021082703.4890c419@t450s.home>
References: <1477024764-79882-1-git-send-email-songwenjun@huawei.com>
	<1477024764-79882-2-git-send-email-songwenjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1477024764-79882-2-git-send-email-songwenjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rick Song <songwenjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 21 Oct 2016 12:39:24 +0800
Rick Song <songwenjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:

> Normally, VFIO should use only stage 2 translation of
> iommu, to create the address mapping. If nesting translation
> is disabled from VFIO core, enable iommu domain only stage 2
> attribute, otherwise, enable iommu domain nesting attribute.
> 
> Signed-off-by: Rick Song <songwenjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 2ba1942..c0265fe 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -741,7 +741,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	struct vfio_group *group, *g;
>  	struct vfio_domain *domain, *d;
>  	struct bus_type *bus = NULL;
> -	int ret;
> +	int attr, ret;
>  
>  	mutex_lock(&iommu->lock);
>  
> @@ -775,13 +775,22 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		goto out_free;
>  	}
>  
> +	/*
> +	 * Set iommu nesting domain attribute if nesting translation
> +	 * is enabled from iommu vfio, otherwise set iommu only stage
> +	 * 2 domain attribute.
> +	 */
> +	attr = 1;
>  	if (iommu->nesting) {
> -		int attr = 1;
> -
>  		ret = iommu_domain_set_attr(domain->domain, DOMAIN_ATTR_NESTING,
>  					    &attr);
>  		if (ret)
>  			goto out_domain;
> +	} else {
> +		ret = iommu_domain_set_attr(domain->domain, DOMAIN_ATTR_S2,
> +					    &attr);
> +		if (ret)
> +			goto out_domain;
>  	}

This attribute is not relevant to the majority of current users, why
would we assume that we need to call it for all non-nesting cases?  Why
do we need to set the attribute at all, what benefit does it provide?
If this is the normal case for an IOMMU API domain, why is there an
option for it at all?  Maybe this should be the default and S1
(whatever that means) should be the alternate option.  Thanks,

Alex

>  
>  	ret = iommu_attach_group(domain->domain, iommu_group);
