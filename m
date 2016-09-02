From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/8] arm: dma-mapping: Don't override dma_ops in
	arch_setup_dma_ops()
Date: Fri, 02 Sep 2016 10:16:22 +0200
Message-ID: <16c9743e-e531-25aa-76f1-8746a6b8ef11@samsung.com>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
	<1470696550-3416-2-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <1470696550-3416-2-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Sricharan and Laurent,


On 2016-08-09 00:49, Sricharan R wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>
> The arch_setup_dma_ops() function is in charge of setting dma_ops with a
> call to set_dma_ops(). set_dma_ops() is also called from
>
> - highbank and mvebu bus notifiers
> - dmabounce (to be replaced with swiotlb)
> - arm_iommu_attach_device
>
> (arm_iommu_attach_device is itself called from IOMMU and bus master
> device drivers)
>
> To allow the arch_setup_dma_ops() call to be moved from device add time
> to device probe time we must ensure that dma_ops already setup by any of
> the above callers will not be overridden.
>
> Aftering replacing dmabounce with swiotlb, converting IOMMU drivers to
> of_xlate and taking care of highbank and mvebu, the workaround should be
> removed.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>   arch/arm/mm/dma-mapping.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index ff7ed56..4686d66 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2259,6 +2259,15 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>   	struct dma_map_ops *dma_ops;
>   
>   	dev->archdata.dma_coherent = coherent;
> +
> +	/*
> +	 * Don't override the dma_ops if they have already been set. Ideally
> +	 * this should be the only location where dma_ops are set, remove this
> +	 * check when all other callers of set_dma_ops will have disappeared.
> +	 */
> +	if (dev->archdata.dma_ops)
> +		return;
> +
>   	if (arm_setup_iommu_dma_ops(dev, dma_base, size, iommu))
>   		dma_ops = arm_get_iommu_dma_map_ops(coherent);
>   	else

Please add also set_dma_ops(dev, NULL) to arm_teardown_iommu_dma_ops() 
function
to this patch, because otherwise dma_ops won't be configured properly if 
deferred
probe of the given device happens: iommu dma ops will be set for the 
first probe
try, then iommu structures will be teared down after EPROBEDEFER error, 
and then
before next probe ties dma_ops will be already set, but no iommu 
structures are
available.

For a convenience, this a fixup patch:
https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/commitdiff/55adefd43cee9d4beb15cb1bbd805c5059b56b4f

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
