From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 4/5] iommu/io-pgtable: Make io_pgtable_ops_to_pgtable()
	macro common
Date: Sun, 13 Dec 2015 23:52:25 +0200
Message-ID: <2226267.jznMrI8GVh@avalon>
References: <cover.1449246988.git.robin.murphy@arm.com>
	<ef5954ba727840a020b62b0135a1ce9f4a10fb2c.1449246988.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ef5954ba727840a020b62b0135a1ce9f4a10fb2c.1449246988.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, brian.starkey-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thank you for the patch.

On Friday 04 December 2015 17:53:01 Robin Murphy wrote:
> There is no need to keep a useful accessor for a public structure hidden
> away in a private implementation. Move it out alongside the structure
> definition so that other implementations may reuse it.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

> ---
>  drivers/iommu/io-pgtable-arm.c | 3 ---
>  drivers/iommu/io-pgtable.h     | 2 ++
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 9088d27..1619681 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -38,9 +38,6 @@
>  #define io_pgtable_to_data(x)						\
>  	container_of((x), struct arm_lpae_io_pgtable, iop)
> 
> -#define io_pgtable_ops_to_pgtable(x)					\
> -	container_of((x), struct io_pgtable, ops)
> -
>  #define io_pgtable_ops_to_data(x)					\
>  	io_pgtable_to_data(io_pgtable_ops_to_pgtable(x))
> 
> diff --git a/drivers/iommu/io-pgtable.h b/drivers/iommu/io-pgtable.h
> index 2e18469..36673c8 100644
> --- a/drivers/iommu/io-pgtable.h
> +++ b/drivers/iommu/io-pgtable.h
> @@ -131,6 +131,8 @@ struct io_pgtable {
>  	struct io_pgtable_ops	ops;
>  };
> 
> +#define io_pgtable_ops_to_pgtable(x) container_of((x), struct io_pgtable,
> ops) +
>  /**
>   * struct io_pgtable_init_fns - Alloc/free a set of page tables for a
>   *                              particular format.

-- 
Regards,

Laurent Pinchart
