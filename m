From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 06/09] iommu/ipmmu-vmsa: Write IMCTR twice
Date: Wed, 8 Mar 2017 12:34:25 +0000
Message-ID: <fa6696c3-30d0-b7a4-de0b-9cecd485d5a5@arm.com>
References: <148897088333.16106.13237004440297956899.sendpatchset@little-apple>
	<148897094380.16106.17145886836361556040.sendpatchset@little-apple>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <148897094380.16106.17145886836361556040.sendpatchset@little-apple>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 08/03/17 11:02, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> 
> Write IMCTR both in the root device and the leaf node.
> 
> Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
> ---
> 
>  Changes since V2:
>  - None
> 
>  Changes since V1:
>  - None
> 
>  drivers/iommu/ipmmu-vmsa.c |   17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> --- 0018/drivers/iommu/ipmmu-vmsa.c
> +++ work/drivers/iommu/ipmmu-vmsa.c	2017-03-08 18:30:36.870607110 +0900
> @@ -286,6 +286,16 @@ static void ipmmu_ctx_write(struct ipmmu
>  	ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
>  }
>  
> +static void ipmmu_ctx_write2(struct ipmmu_vmsa_domain *domain, unsigned int reg,
> +			     u32 data)

That's pretty cryptic. Maybe both functions could do with less ambiguous
names - something like ipmmu_ctx_write_root() vs. ipmmu_ctx_write_all(),
perhaps? (and if there's a more specific hardware term than "all" that
describes this kind of configuration, even better).

Robin.

> +{
> +	if (domain->mmu != domain->root)
> +		ipmmu_write(domain->mmu,
> +			    domain->context_id * IM_CTX_SIZE + reg, data);
> +
> +	ipmmu_write(domain->root, domain->context_id * IM_CTX_SIZE + reg, data);
> +}
> +
>  /* -----------------------------------------------------------------------------
>   * TLB and microTLB Management
>   */
> @@ -312,7 +322,7 @@ static void ipmmu_tlb_invalidate(struct
>  
>  	reg = ipmmu_ctx_read(domain, IMCTR);
>  	reg |= IMCTR_FLUSH;
> -	ipmmu_ctx_write(domain, IMCTR, reg);
> +	ipmmu_ctx_write2(domain, IMCTR, reg);
>  
>  	ipmmu_tlb_sync(domain);
>  }
> @@ -472,7 +482,8 @@ static int ipmmu_domain_init_context(str
>  	 * software management as we have no use for it. Flush the TLB as
>  	 * required when modifying the context registers.
>  	 */
> -	ipmmu_ctx_write(domain, IMCTR, IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
> +	ipmmu_ctx_write2(domain, IMCTR,
> +			 IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
>  
>  	return 0;
>  }
> @@ -498,7 +509,7 @@ static void ipmmu_domain_destroy_context
>  	 *
>  	 * TODO: Is TLB flush really needed ?
>  	 */
> -	ipmmu_ctx_write(domain, IMCTR, IMCTR_FLUSH);
> +	ipmmu_ctx_write2(domain, IMCTR, IMCTR_FLUSH);
>  	ipmmu_tlb_sync(domain);
>  	ipmmu_domain_free_context(domain->root, domain->context_id);
>  }
> 
