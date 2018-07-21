From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix allocation in atomic context
Date: Sat, 21 Jul 2018 12:12:33 +0300
Message-ID: <25541397.uzn8ZjuUG8@avalon>
References: <20180720161659.29800-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180720161659.29800-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

Thank you for the patch.

On Friday, 20 July 2018 19:16:59 EEST Geert Uytterhoeven wrote:
> When attaching a device to an IOMMU group with
> CONFIG_DEBUG_ATOMIC_SLEEP=y:
> 
>     BUG: sleeping function called from invalid context at mm/slab.h:421
>     in_atomic(): 1, irqs_disabled(): 128, pid: 61, name: kworker/1:1
>     ...
>     Call trace:
>      ...
>      arm_lpae_alloc_pgtable+0x114/0x184
>      arm_64_lpae_alloc_pgtable_s1+0x2c/0x128
>      arm_32_lpae_alloc_pgtable_s1+0x40/0x6c
>      alloc_io_pgtable_ops+0x60/0x88
>      ipmmu_attach_device+0x140/0x334
> 
> ipmmu_attach_device() takes a spinlock, while arm_lpae_alloc_pgtable()
> allocates memory using GFP_KERNEL.  Originally, the ipmmu-vmsa driver
> had its own custom page table allocation implementation using
> GFP_ATOMIC, hence the spinlock was fine.
> 
> Fix this by replacing the spinlock by a mutex, like the arm-smmu driver
> does.
> 
> Fixes: f20ed39f53145e45 ("iommu/ipmmu-vmsa: Use the ARM LPAE page table
> allocator") Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 6a0e7142f41bf667..8f54f25404456035 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -73,7 +73,7 @@ struct ipmmu_vmsa_domain {
>  	struct io_pgtable_ops *iop;
> 
>  	unsigned int context_id;
> -	spinlock_t lock;			/* Protects mappings */
> +	struct mutex mutex;			/* Protects mappings */
>  };
> 
>  static struct ipmmu_vmsa_domain *to_vmsa_domain(struct iommu_domain *dom)
> @@ -599,7 +599,7 @@ static struct iommu_domain
> *__ipmmu_domain_alloc(unsigned type) if (!domain)
>  		return NULL;
> 
> -	spin_lock_init(&domain->lock);
> +	mutex_init(&domain->mutex);
> 
>  	return &domain->io_domain;
>  }
> @@ -645,7 +645,6 @@ static int ipmmu_attach_device(struct iommu_domain
> *io_domain, struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>  	struct ipmmu_vmsa_device *mmu = to_ipmmu(dev);
>  	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
> -	unsigned long flags;
>  	unsigned int i;
>  	int ret = 0;
> 
> @@ -654,7 +653,7 @@ static int ipmmu_attach_device(struct iommu_domain
> *io_domain, return -ENXIO;
>  	}
> 
> -	spin_lock_irqsave(&domain->lock, flags);
> +	mutex_lock(&domain->mutex);

As the ipmmu_attach_device() function is called from a sleepable context this 
should be fine.

Reviewed-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> 
>  	if (!domain->mmu) {
>  		/* The domain hasn't been used yet, initialize it. */
> @@ -678,7 +677,7 @@ static int ipmmu_attach_device(struct iommu_domain
> *io_domain, } else
>  		dev_info(dev, "Reusing IPMMU context %u\n", domain->context_id);
> 
> -	spin_unlock_irqrestore(&domain->lock, flags);
> +	mutex_unlock(&domain->mutex);
> 
>  	if (ret < 0)
>  		return ret;


-- 
Regards,

Laurent Pinchart
