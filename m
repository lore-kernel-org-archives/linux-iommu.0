From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/1] iommu/vtd: Cleanup dma_remapping.h header
Date: Mon, 12 Nov 2018 14:23:27 +0100
Message-ID: <20181112132327.mo5vpunwzsgv6vkm@8bytes.org>
References: <20181112064008.2102-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20181112064008.2102-1-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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

On Mon, Nov 12, 2018 at 02:40:08PM +0800, Lu Baolu wrote:
>  arch/x86/kernel/tboot.c                    |  2 +-
>  drivers/gpu/drm/i915/i915_gem_execbuffer.c |  2 +-
>  drivers/gpu/drm/i915/intel_display.c       |  2 +-
>  drivers/gpu/drm/vmwgfx/vmwgfx_drv.c        |  2 +-
>  drivers/misc/mic/scif/scif_rma.c           |  2 +-
>  drivers/misc/mic/scif/scif_rma.h           |  2 +-
>  include/linux/dma_remapping.h              | 58 ----------------------
>  include/linux/intel-iommu.h                | 49 +++++++++++++++++-
>  8 files changed, 53 insertions(+), 66 deletions(-)
>  delete mode 100644 include/linux/dma_remapping.h

Applied, thanks.
