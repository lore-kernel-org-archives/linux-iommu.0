From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] vfio, iommu: Fixed interaction of VFIO_IOMMU_MAP_DMA
	with IOMMU address limits
Date: Wed, 28 Aug 2013 09:44:32 -0600
Message-ID: <1377704672.10408.81.camel@ul30vt.home>
References: <1377597428-21480-1-git-send-email-jsteckli@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1377597428-21480-1-git-send-email-jsteckli-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Julian Stecklina <jsteckli-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 2013-08-27 at 11:57 +0200, Julian Stecklina wrote:
> The BUG_ON in drivers/iommu/intel-iommu.c:785 can be triggered from userspace via
> VFIO by calling the VFIO_IOMMU_MAP_DMA ioctl on a vfio device with any address
> beyond the addressing capabilities of the IOMMU. The problem is that the ioctl code
> calls iommu_iova_to_phys before it calls iommu_map. iommu_map handles the case that
> it gets addresses beyond the addressing capabilities of its IOMMU.
> intel_iommu_iova_to_phys does not.
> 
> This patch fixes iommu_iova_to_phys to return NULL for addresses beyond what the
> IOMMU can handle. This in turn causes the ioctl call to fail in iommu_map and
> (correctly) return EFAULT to the user with a helpful warning message in the kernel
> log.
> 
> Signed-off-by: Julian Stecklina <jsteckli-IG//nw+yl+iQIjdd1DhZXWfrygkm6VTR@public.gmane.org>

Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

> ---
>  drivers/iommu/intel-iommu.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index eec0d3e..61303db 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -782,7 +782,11 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>  	int offset;
>  
>  	BUG_ON(!domain->pgd);
> -	BUG_ON(addr_width < BITS_PER_LONG && pfn >> addr_width);
> +
> +	if (addr_width < BITS_PER_LONG && pfn >> addr_width)
> +		/* Address beyond IOMMU's addressing capabilities. */
> +		return NULL;
> +
>  	parent = domain->pgd;
>  
>  	while (level > 0) {
