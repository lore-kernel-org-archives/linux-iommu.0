From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix VM domain ID leak
Date: Thu, 16 Jul 2015 09:43:55 -0600
Message-ID: <1437061435.1391.580.camel@redhat.com>
References: <20150714204731.10189.28556.stgit@gimli.home>
	<20150716152030.GB10969@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150716152030.GB10969-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-07-16 at 17:20 +0200, Joerg Roedel wrote:
> On Tue, Jul 14, 2015 at 02:48:53PM -0600, Alex Williamson wrote:
> > This continues the attempt to fix commit fb170fb4c548 ("iommu/vt-d:
> > Introduce helper functions to make code symmetric for readability").
> > The previous attempt in commit 71684406905f ("iommu/vt-d: Detach
> > domain *only* from attached iommus") overlooked the fact that
> > dmar_domain.iommu_bmp gets cleared for VM domains when devices are
> > detached:
> > 
> > intel_iommu_detach_device
> >   domain_remove_one_dev_info
> >     domain_detach_iommu
> > 
> > The domain is detached from the iommu, but the iommu is still attached
> > to the domain, for whatever reason.
> 
> Gaah, this whole vm_or_si special handling is a complete and fragile
> mess.

+1

> The only reason for keeping the domain-id allocated in the iommu
> seems to be that it can be re-used later, when another device behind
> this iommu is attached to the domain. But this is hardly a justification
> for the complexity and special case handling here, so how about this
> diff instead:
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index a98a7b2..c8fc8c8 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4618,8 +4618,7 @@ static void domain_remove_one_dev_info(struct dmar_domain *domain,
>  
>  	if (found == 0) {
>  		domain_detach_iommu(domain, iommu);
> -		if (!domain_type_is_vm_or_si(domain))
> -			iommu_detach_domain(domain, iommu);
> +		iommu_detach_domain(domain, iommu);
>  	}
>  }
>  
> This removes the caching of domain-ids, and iommu_detach_domain
> correctly handles all types of domains (dma-api, vm and si). It should
> be safe, but can you please double-check?

I was tempted to do this as well, but what about
domain_remove_dev_info() where we also handle vm domains specially and
don't do a symmetric detach in both directions?  I started down that
path but quickly found the code to fragile to make those kinds of
changes.  Thanks,

Alex
