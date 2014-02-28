From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/arm-smmu: Return 0 on unmap failure
Date: Fri, 28 Feb 2014 16:39:28 +0000
Message-ID: <20140228163927.GD30996@mudshark.cambridge.arm.com>
References: <1393601830-4677-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1393601830-4677-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393601830-4677-3-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 28, 2014 at 03:37:10PM +0000, Laurent Pinchart wrote:
> The IOMMU core expects the unmap operation to return the number of bytes
> that have been unmapped or 0 on failure, a negative return value being
> treated like a number of bytes.

Makes sense, thanks. It's a pity we can't propagate the error code.

Will

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index c33a310..e7528f0 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1464,7 +1464,7 @@ static size_t arm_smmu_unmap(struct iommu_domain *domain, unsigned long iova,
>  
>  	ret = arm_smmu_handle_mapping(smmu_domain, iova, 0, size, 0);
>  	arm_smmu_tlb_inv_context(&smmu_domain->root_cfg);
> -	return ret ? ret : size;
> +	return ret ? 0 : size;
>  }
>  
>  static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
