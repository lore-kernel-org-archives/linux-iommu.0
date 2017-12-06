From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: clean up pr_irq if request_threaded_irq fails
Date: Wed, 6 Dec 2017 10:23:11 -0800
Message-ID: <20171206182311.GA124624@otc-nc-03>
References: <20171206164959.23794-1-jsnitsel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171206164959.23794-1-jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 06, 2017 at 09:49:59AM -0700, Jerry Snitselaar wrote:
> It is unlikely request_threaded_irq will fail, but if it does for some
> reason we should clear iommu->pr_irq in the error path. Also
> intel_svm_finish_prq shouldn't try to clean up the page request
> interrupt if pr_irq is 0. Without these, if request_threaded_irq were
> to fail the following occurs:

Looks good.

Reviewed-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Cheers,
Ashok

> 
> Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/intel-svm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index ed1cf7c5a43b..6643277e321e 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -129,6 +129,7 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
>  		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
>  		       iommu->name);
>  		dmar_free_hwirq(irq);
> +		iommu->pr_irq = 0;
>  		goto err;
>  	}
>  	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
> @@ -144,9 +145,11 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
>  	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
>  	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
>  
> -	free_irq(iommu->pr_irq, iommu);
> -	dmar_free_hwirq(iommu->pr_irq);
> -	iommu->pr_irq = 0;
> +	if (iommu->pr_irq) {
> +		free_irq(iommu->pr_irq, iommu);
> +		dmar_free_hwirq(iommu->pr_irq);
> +		iommu->pr_irq = 0;
> +	}
>  
>  	free_pages((unsigned long)iommu->prq, PRQ_ORDER);
>  	iommu->prq = NULL;
> -- 
> 2.14.3
> 
