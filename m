From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2] iommu/ipmmu-vmsa: Rereserving a free context before
	setting up a pagetable
Date: Tue, 29 Aug 2017 16:01:02 +0300
Message-ID: <9010916.sEVaizibOe@avalon>
References: <1503498702-27996-1-git-send-email-olekstysh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503498702-27996-1-git-send-email-olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Oleksandr Tyshchenko <olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Oleksandr,

Thank you for the patch.

On Wednesday, 23 August 2017 17:31:42 EEST Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
> 
> Reserving a free context is both quicker and more likely to fail
> (due to limited hardware resources) than setting up a pagetable.
> What is more the pagetable init/cleanup code could require
> the context to be set up.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
> CC: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> CC: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> CC: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
> This patch fixes a bug during rollback logic:
> In ipmmu_domain_init_context() we are trying to find an unused context
> and if operation fails we will call free_io_pgtable_ops(),
> but "domain->context_id" hasn't been initialized yet (likely it is 0
> because of kzalloc). Having the following call stack:
> free_io_pgtable_ops() -> io_pgtable_tlb_flush_all() ->
> ipmmu_tlb_flush_all() -> ipmmu_tlb_invalidate()
> we will get a mistaken cache flush for a context pointed by
> uninitialized "domain->context_id".
> 
> 
> v1 here:
> https://lists.linuxfoundation.org/pipermail/iommu/2017-August/023857.html
> ---
>  drivers/iommu/ipmmu-vmsa.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 2a38aa1..382f387 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -341,6 +341,19 @@ static int ipmmu_domain_allocate_context(struct
> ipmmu_vmsa_device *mmu, return ret;
>  }
> 
> +static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
> +				      unsigned int context_id)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mmu->lock, flags);
> +
> +	clear_bit(context_id, mmu->ctx);
> +	mmu->domains[context_id] = NULL;
> +
> +	spin_unlock_irqrestore(&mmu->lock, flags);
> +}
> +
>  static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
>  {
>  	u64 ttbr;
> @@ -370,22 +383,22 @@ static int ipmmu_domain_init_context(struct
> ipmmu_vmsa_domain *domain) */
>  	domain->cfg.iommu_dev = domain->mmu->dev;
> 
> -	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
> -					   domain);
> -	if (!domain->iop)
> -		return -EINVAL;
> -
>  	/*
>  	 * Find an unused context.
>  	 */
>  	ret = ipmmu_domain_allocate_context(domain->mmu, domain);
> -	if (ret == IPMMU_CTX_MAX) {
> -		free_io_pgtable_ops(domain->iop);
> +	if (ret == IPMMU_CTX_MAX)
>  		return -EBUSY;
> -	}
> 
>  	domain->context_id = ret;
> 
> +	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
> +					   domain);
> +	if (!domain->iop) {
> +		ipmmu_domain_free_context(domain->mmu, domain->context_id);
> +		return -EINVAL;
> +	}
> +
>  	/* TTBR0 */
>  	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
>  	ipmmu_ctx_write(domain, IMTTLBR0, ttbr);
> @@ -426,19 +439,6 @@ static int ipmmu_domain_init_context(struct
> ipmmu_vmsa_domain *domain) return 0;
>  }
> 
> -static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
> -				      unsigned int context_id)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&mmu->lock, flags);
> -
> -	clear_bit(context_id, mmu->ctx);
> -	mmu->domains[context_id] = NULL;
> -
> -	spin_unlock_irqrestore(&mmu->lock, flags);
> -}
> -
>  static void ipmmu_domain_destroy_context(struct ipmmu_vmsa_domain *domain)
>  {
>  	/*


-- 
Regards,

Laurent Pinchart
