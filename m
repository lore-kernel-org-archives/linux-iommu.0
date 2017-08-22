From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v1] iommu/ipmmu-vmsa: Set context_id to non-existent value
	if allocation failed
Date: Wed, 23 Aug 2017 00:25:10 +0300
Message-ID: <3230921.pODNlFebuG@avalon>
References: <1503319241-2912-1-git-send-email-olekstysh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1503319241-2912-1-git-send-email-olekstysh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Oleksandr,

Thank you for the patch.

On Monday, 21 August 2017 15:40:41 EEST Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
> 
> In ipmmu_domain_init_context() we are trying to allocate context and
> if allocation fails we will call free_io_pgtable_ops(),
> but "domain->context_id" hasn't been initialized yet (likely it is 0
> because of kzalloc). Having the following call stack:
> free_io_pgtable_ops() -> io_pgtable_tlb_flush_all() ->
> ipmmu_tlb_flush_all() -> ipmmu_tlb_invalidate()
> we will get a mistaken cache flush for a context pointed by
> uninitialized "domain->context_id".
> 
> So, set context_id to non-existent value (IPMMU_CTX_MAX) before calling
> free_io_pgtable_ops() and check it for a valid value (< IPMMU_CTX_MAX)
> before calling ipmmu_tlb_invalidate().
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko-uRwfk40T5oI@public.gmane.org>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 2a38aa1..5b226c0 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -303,6 +303,9 @@ static void ipmmu_tlb_flush_all(void *cookie)
>  {
>  	struct ipmmu_vmsa_domain *domain = cookie;
> 
> +	if (domain->context_id >= IPMMU_CTX_MAX)
> +		return;
> +
>  	ipmmu_tlb_invalidate(domain);
>  }
> 
> @@ -380,6 +383,7 @@ static int ipmmu_domain_init_context(struct
> ipmmu_vmsa_domain *domain) */
>  	ret = ipmmu_domain_allocate_context(domain->mmu, domain);
>  	if (ret == IPMMU_CTX_MAX) {
> +		domain->context_id = IPMMU_CTX_MAX;

Wouldn't it make more sense to allocate the pgtable ops after initializing the 
context (moving the ipmmu_domain_allocate_context() call to the very end of 
the function) ? That way we would be less dependent on changes to pgtable ops 
init/cleanup code that could require the context to be set up.

>  		free_io_pgtable_ops(domain->iop);
>  		return -EBUSY;
>  	}


-- 
Regards,

Laurent Pinchart
