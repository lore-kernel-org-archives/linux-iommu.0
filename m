From: Ray Jui via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 0/8] io-pgtable lock removal
Date: Wed, 28 Jun 2017 10:02:35 -0700
Message-ID: <87d53115-3d80-5a3d-6632-c31986cb7018@broadcom.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
	<458ad41d-6679-eeca-3c0f-13ccb6c933b6@codeaurora.org>
	<b7830be1-9a78-e29f-a29c-4798aaa28c0a@broadcom.com>
	<cdc1799b-f142-09ed-a7e5-d7fd2e70268f@arm.com>
	<e43ba1fe-696e-fabb-a800-52fadaa2fa93@broadcom.com>
	<20170628114609.GD11053@arm.com>
Reply-To: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170628114609.GD11053-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will/Robin,

On 6/28/17 4:46 AM, Will Deacon wrote:
> Hi Ray,
> 
> Robin and I have been bashing our heads against the tlb_sync_pending flag
> this morning, and we reckon it could have something to do with your timeouts
> on MMU-500.
> 
> On Tue, Jun 27, 2017 at 09:43:19AM -0700, Ray Jui wrote:
>>>> Also, in a few occasions, I observed the following message during the
>>>> test, when multiple cores are involved:
>>>>
>>>> arm-smmu 64000000.mmu: TLB sync timed out -- SMMU may be deadlocked
> 
> The tlb_sync_pending logic was written under the assumption of a global
> page-table lock, so it assumes that it only has to care about syncing
> flushes from the current CPU/context. That's not true anymore, and the
> current code can accidentally skip syncs and (what I think is happening in
> your case) allow concurrent syncs, which will potentially lead to timeouts
> if a CPU is unlucky enough to keep missing the Ack.
> 
> Please can you try the diff below and see if it fixes things for you?
> This applies on top of my for-joerg/arm-smmu/updates branch, but note
> that I've only shown it to the compiler. Not tested at all.
> 
> Will
> 

Thanks for looking into this. I'm a bit busy at work but will certainly
find time to test the diff below. I hopefully will get to it later this
week.

Thanks,

Ray

> --->8
> 
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index 127558d83667..cd8d7aaec161 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -59,6 +59,7 @@ struct io_pgtable_ops *alloc_io_pgtable_ops(enum io_pgtable_fmt fmt,
>  	iop->cookie	= cookie;
>  	iop->cfg	= *cfg;
>  
> +	atomic_set(&iop->tlb_sync_pending, 0);
>  	return &iop->ops;
>  }
>  
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 524263a7ae6f..b64580c9d03d 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -1,5 +1,7 @@
>  #ifndef __IO_PGTABLE_H
>  #define __IO_PGTABLE_H
> +
> +#include <linux/atomic.h>
>  #include <linux/bitops.h>
>  
>  /*
> @@ -165,7 +167,7 @@ void free_io_pgtable_ops(struct io_pgtable_ops *ops);
>  struct io_pgtable {
>  	enum io_pgtable_fmt	fmt;
>  	void			*cookie;
> -	bool			tlb_sync_pending;
> +	atomic_t		tlb_sync_pending;
>  	struct io_pgtable_cfg	cfg;
>  	struct io_pgtable_ops	ops;
>  };
> @@ -175,22 +177,20 @@ struct io_pgtable {
>  static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
>  {
>  	iop->cfg.tlb->tlb_flush_all(iop->cookie);
> -	iop->tlb_sync_pending = true;
> +	atomic_set_release(&iop->tlb_sync_pending, 1);
>  }
>  
>  static inline void io_pgtable_tlb_add_flush(struct io_pgtable *iop,
>  		unsigned long iova, size_t size, size_t granule, bool leaf)
>  {
>  	iop->cfg.tlb->tlb_add_flush(iova, size, granule, leaf, iop->cookie);
> -	iop->tlb_sync_pending = true;
> +	atomic_set_release(&iop->tlb_sync_pending, 1);
>  }
>  
>  static inline void io_pgtable_tlb_sync(struct io_pgtable *iop)
>  {
> -	if (iop->tlb_sync_pending) {
> +	if (atomic_xchg_relaxed(&iop->tlb_sync_pending, 0))
>  		iop->cfg.tlb->tlb_sync(iop->cookie);
> -		iop->tlb_sync_pending = false;
> -	}
>  }
>  
>  /**
> 
