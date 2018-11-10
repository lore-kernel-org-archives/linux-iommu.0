From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH 1/1] iommu/vtd: Cleanup dma_remapping.h header
Date: Sat, 10 Nov 2018 00:35:06 -0800
Message-ID: <20181110083506.GB28614@infradead.org>
References: <20181110070844.28353-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181110070844.28353-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Nov 10, 2018 at 03:08:44PM +0800, Lu Baolu wrote:
> Commit e61d98d8dad00 ("x64, x2apic/intr-remap: Intel vt-d, IOMMU
> code reorganization") moved dma_remapping.h from drivers/pci/ to
> current place. It is entirely VT-d specific, but uses a generic
> name. This merges dma_remapping.h with include/linux/intel-iommu.h
> and removes dma_remapping.h as the result.

This looks fine to me, thanks for doing the work.

Reviewed-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>

> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
> @@ -34,7 +34,7 @@
>  #include <drm/ttm/ttm_placement.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/ttm/ttm_module.h>
> -#include <linux/dma_remapping.h>
> +#include <linux/intel-iommu.h>

Btw, I don't think this driver has any business looking at Intel
IOMMU driver internals, and the code doing so is more than gross.

Not really your job, but vmw_dma_select_mode really needs a rewrite with
someone that has at least half a clue, and some taste.

Eventually we should also drop the intel_iommu_enabled export.
