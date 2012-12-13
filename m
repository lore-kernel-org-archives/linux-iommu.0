From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu: moving initialization earlier
Date: Thu, 13 Dec 2012 08:48:55 -0700
Message-ID: <1355413735.2229.1.camel@ul30vt.home>
References: <1355365763.19932.75.camel@pasglop>
	<1355380115-4518-1-git-send-email-aik@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1355380115-4518-1-git-send-email-aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Probably a good idea to CC the iommu list and maintainer...

On Thu, 2012-12-13 at 17:28 +1100, Alexey Kardashevskiy wrote:
> The iommu_init() call initializes IOMMU internal structures and data
> required for the API to function such as iommu_group_alloc().
> It is registered as a subsys_initcall.
> 
> One of the IOMMU users is a PCI subsystem on POWER which discovers new
> IOMMU tables during the PCI scan so the most logical place to call
> iommu_group_alloc() is when a new group is just discovered. However
> PCI scan is done from subsys_initcall hook as well what makes
> using of the IOMMU API impossible.
> 
> The patch moves IOMMU subsystem initialization one step earlier.
> 
> Signed-off-by: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
> ---
>  drivers/iommu/iommu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de857bb..b0afd3d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -865,7 +865,7 @@ printk("%s %u\n", __func__, __LINE__);
>  
>  	return 0;
>  }
> -subsys_initcall(iommu_init);
> +arch_initcall(iommu_init);
>  
>  int iommu_domain_get_attr(struct iommu_domain *domain,
>  			  enum iommu_attr attr, void *data)
