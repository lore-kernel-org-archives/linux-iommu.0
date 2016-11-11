From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v6 04/07] iommu/ipmmu-vmsa: Break out domain allocation
	code
Date: Fri, 11 Nov 2016 03:02:26 +0200
Message-ID: <4121631.0oUPCTEmnf@avalon>
References: <20161019233533.10506.16810.sendpatchset@little-apple>
	<20161019233613.10506.60821.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161019233613.10506.60821.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Magnus,

Thank you for the patch.

On Thursday 20 Oct 2016 08:36:13 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Break out the domain allocation code into a separate function.
> This is preparation for future code sharing.
> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> Reviewed-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This looks good to me,

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

(assuming my review of the next patches in the series won't make me conclude 
that this patch isn't needed :-))

> ---
> 
>  Changes since V5:
>  - None
> 
>  Changes since V4:
>  - None
> 
>  Changes since V3:
>  - None
> 
>  Changes since V2:
>  - Included this new patch as-is from the following series:
>    [PATCH 00/04] iommu/ipmmu-vmsa: IPMMU CONFIG_IOMMU_DMA update
> 
>  drivers/iommu/ipmmu-vmsa.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> --- 0008/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2016-09-20 21:56:59.220607110 +0900
> @@ -507,13 +507,10 @@ static irqreturn_t ipmmu_irq(int irq, vo
>   * IOMMU Operations
>   */
> 
> -static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
> +static struct iommu_domain *__ipmmu_domain_alloc(unsigned type)
>  {
>  	struct ipmmu_vmsa_domain *domain;
> 
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> -		return NULL;
> -
>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>  	if (!domain)
>  		return NULL;
> @@ -523,6 +520,14 @@ static struct iommu_domain *ipmmu_domain
>  	return &domain->io_domain;
>  }
> 
> +static struct iommu_domain *ipmmu_domain_alloc(unsigned type)
> +{
> +	if (type != IOMMU_DOMAIN_UNMANAGED)
> +		return NULL;
> +
> +	return __ipmmu_domain_alloc(type);
> +}
> +
>  static void ipmmu_domain_free(struct iommu_domain *io_domain)
>  {
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);

-- 
Regards,

Laurent Pinchart
