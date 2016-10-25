From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [PATCH] drivers: iommu: constify iommu_gather_ops structures
Date: Tue, 25 Oct 2016 17:46:32 +0200 (CEST)
Message-ID: <alpine.DEB.2.10.1610251746150.3039@hadrien>
References: <1477409624-30949-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1477409624-30949-1-git-send-email-bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bhumika Goyal <bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 25 Oct 2016, Bhumika Goyal wrote:

> Check for iommu_gather_ops structures that are only stored in the tlb
> field of an io_pgtable_cfg structure. The tlb field is of type
> const struct iommu_gather_ops *, so iommu_gather_ops structures
> having this property can be declared as const.
> Done using Coccinelle:
>
> @r1 disable optional_qualifier @
> identifier i;
> position p;
> @@
> static struct iommu_gather_ops i@p = {...};
>
> @ok1@
> identifier r1.i;
> position p;
> struct io_pgtable_cfg q;
> @@
> q.tlb=&i@p;
>
> @bad@
> position p!={r1.p,ok1.p};
> identifier r1.i;
> @@
> i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> static
> +const
> struct iommu_gather_ops i={...};
>
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct iommu_gather_ops i;
>
> Signed-off-by: Bhumika Goyal <bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>

> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
>  drivers/iommu/ipmmu-vmsa.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index f50e51c..1465bbc 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -741,7 +741,7 @@ static void dummy_tlb_sync(void *cookie)
>  	WARN_ON(cookie != cfg_cookie);
>  }
>
> -static struct iommu_gather_ops dummy_tlb_ops = {
> +static const struct iommu_gather_ops dummy_tlb_ops = {
>  	.tlb_flush_all	= dummy_tlb_flush_all,
>  	.tlb_add_flush	= dummy_tlb_add_flush,
>  	.tlb_sync	= dummy_tlb_sync,
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index ace331d..b8bcf18 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -283,7 +283,7 @@ static void ipmmu_tlb_add_flush(unsigned long iova, size_t size,
>  	/* The hardware doesn't support selective TLB flush. */
>  }
>
> -static struct iommu_gather_ops ipmmu_gather_ops = {
> +static const struct iommu_gather_ops ipmmu_gather_ops = {
>  	.tlb_flush_all = ipmmu_tlb_flush_all,
>  	.tlb_add_flush = ipmmu_tlb_add_flush,
>  	.tlb_sync = ipmmu_tlb_flush_all,
> --
> 1.9.1
>
>
