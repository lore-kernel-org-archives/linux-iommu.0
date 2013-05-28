From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/2] vfio: Provide module option to disable
	vfio_iommu_type1 hugepage support
Date: Tue, 28 May 2013 12:42:14 -0400
Message-ID: <20130528164214.GC6073@phenom.dumpdata.com>
References: <20130524171613.14229.84050.stgit@bling.home>
	<20130528162637.28848.76733.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130528162637.28848.76733.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, chegu_vinod-VXdhtT5mjnY@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 28, 2013 at 10:27:52AM -0600, Alex Williamson wrote:
> Add a module option to vfio_iommu_type1 to disable IOMMU hugepage
> support.  This causes iommu_map to only be called with single page
> mappings, disabling the IOMMU driver's ability to use hugepages.
> This option can be enabled by loading vfio_iommu_type1 with
> disable_hugepages=1 or dynamically through sysfs.  If enabled
> dynamically, only new mappings are restricted.
> 
> Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> ---

> 
> As suggested by Konrad.  This is cleaner to add as a follow-on
> 
>  drivers/vfio/vfio_iommu_type1.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 6654a7e..8a2be4e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -48,6 +48,12 @@ module_param_named(allow_unsafe_interrupts,
>  MODULE_PARM_DESC(allow_unsafe_interrupts,
>  		 "Enable VFIO IOMMU support for on platforms without interrupt remapping support.");
>  
> +static bool disable_hugepages;
> +module_param_named(disable_hugepages,
> +		   disable_hugepages, bool, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(disable_hugepages,
> +		 "Disable VFIO IOMMU support for IOMMU hugepages.");
> +
>  struct vfio_iommu {
>  	struct iommu_domain	*domain;
>  	struct mutex		lock;
> @@ -270,6 +276,11 @@ static long vfio_pin_pages(unsigned long vaddr, long npage,
>  		return -ENOMEM;
>  	}
>  
> +	if (unlikely(disable_hugepages)) {
> +		vfio_lock_acct(1);
> +		return 1;
> +	}
> +
>  	/* Lock all the consecutive pages from pfn_base */
>  	for (i = 1, vaddr += PAGE_SIZE; i < npage; i++, vaddr += PAGE_SIZE) {
>  		unsigned long pfn = 0;
> 
