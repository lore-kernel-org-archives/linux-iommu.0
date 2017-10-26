From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu: Limit the IOVA page range to the specified
	addresses
Date: Thu, 26 Oct 2017 10:32:01 +0200
Message-ID: <20171026103201.6ac9f21c@t450s.home>
References: <150827532101.76237.2380796046683480798.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <150827532101.76237.2380796046683480798.stgit-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 17 Oct 2017 16:22:01 -0500
Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org> wrote:

> From: amd <amd-tq90VzyE+wXkLsZ8J5Uweg@public.gmane.org>
> 
> The extent of pages specified when applying a reserved region should
> include up to the last page of the range, but not the page following
> the range.
> 
> Signed-off-by: Gary R Hook <gary.hook-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 27eb0d6fcdc2..bb3ef33e3784 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -3271,7 +3271,7 @@ static void amd_iommu_apply_resv_region(struct device *dev,
>  	unsigned long start, end;
>  
>  	start = IOVA_PFN(region->start);
> -	end   = IOVA_PFN(region->start + region->length);
> +	end   = IOVA_PFN(region->start + region->length - 1);
>  
>  	WARN_ON_ONCE(reserve_iova(&dma_dom->iovad, start, end) == NULL);
>  }

This looks like a fix, should we include:

Fixes: 8d54d6c8b8f3 ('iommu/amd: Implement apply_dm_region call-back')


Thanks,
Alex
