From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu: Add void declarations in zero-arg functions.
Date: Fri, 4 Jul 2014 13:23:56 +0200
Message-ID: <20140704112355.GH13434@8bytes.org>
References: <1404392581-14507-1-git-send-email-fempsci@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404392581-14507-1-git-send-email-fempsci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Chi Pham <fempsci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 03, 2014 at 03:03:01PM +0200, Chi Pham wrote:
> Added explicit void declarations to zero-argument function headers.
> The following coccinelle script was used:
> @addvoid@
> identifier f;
> @@
> 
> f(
> + void
>  ) { ... }
> 
> Signed-off-by: Chi Pham <fempsci-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>a

Applied, thanks.

> ---
>  drivers/iommu/fsl_pamu.c        |    2 +-
>  drivers/iommu/fsl_pamu_domain.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index b99dd88..5c9b424 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -92,7 +92,7 @@ struct gen_pool *spaace_pool;
>   * subwindow count per liodn.
>   *
>   */
> -u32 pamu_get_max_subwin_cnt()
> +u32 pamu_get_max_subwin_cnt(void)
>  {
>  	return max_subwindow_count;
>  }
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 93072ba..0ead81c 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -1157,7 +1157,7 @@ static struct iommu_ops fsl_pamu_ops = {
>  	.remove_device	= fsl_pamu_remove_device,
>  };
>  
> -int pamu_domain_init()
> +int pamu_domain_init(void)
>  {
>  	int ret = 0;
>  
> -- 
> 1.7.10.4
> 
