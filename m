From: Chegu Vinod <chegu_vinod@hp.com>
Subject: Re: [PATCH 3/2] vfio: Provide module option to disable
 vfio_iommu_type1 hugepage support
Date: Thu, 30 May 2013 19:33:21 -0700
Message-ID: <51A80BF1.4040408@hp.com>
References: <20130524171613.14229.84050.stgit@bling.home>
	<20130528162637.28848.76733.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <20130528162637.28848.76733.stgit@bling.home>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, konrad.wilk@oracle.com
List-Id: iommu@lists.linux-foundation.org

On 5/28/2013 9:27 AM, Alex Williamson wrote:
> Add a module option to vfio_iommu_type1 to disable IOMMU hugepage
> support.  This causes iommu_map to only be called with single page
> mappings, disabling the IOMMU driver's ability to use hugepages.
> This option can be enabled by loading vfio_iommu_type1 with
> disable_hugepages=1 or dynamically through sysfs.  If enabled
> dynamically, only new mappings are restricted.
>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>
> As suggested by Konrad.  This is cleaner to add as a follow-on
>
>   drivers/vfio/vfio_iommu_type1.c |   11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 6654a7e..8a2be4e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -48,6 +48,12 @@ module_param_named(allow_unsafe_interrupts,
>   MODULE_PARM_DESC(allow_unsafe_interrupts,
>   		 "Enable VFIO IOMMU support for on platforms without interrupt remapping support.");
>   
> +static bool disable_hugepages;
> +module_param_named(disable_hugepages,
> +		   disable_hugepages, bool, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(disable_hugepages,
> +		 "Disable VFIO IOMMU support for IOMMU hugepages.");
> +
>   struct vfio_iommu {
>   	struct iommu_domain	*domain;
>   	struct mutex		lock;
> @@ -270,6 +276,11 @@ static long vfio_pin_pages(unsigned long vaddr, long npage,
>   		return -ENOMEM;
>   	}
>   
> +	if (unlikely(disable_hugepages)) {
> +		vfio_lock_acct(1);
> +		return 1;
> +	}
> +
>   	/* Lock all the consecutive pages from pfn_base */
>   	for (i = 1, vaddr += PAGE_SIZE; i < npage; i++, vaddr += PAGE_SIZE) {
>   		unsigned long pfn = 0;
>
> .
>

Tested-by: Chegu Vinod <chegu_vinod@hp.com>

I was able to verify your changes on a 2 Sandybridge-EP socket platform 
and observed about ~7-8% improvement in the netperf's TCP_RR 
performance.  The guest size was small (16vcpu/32GB).

Hopefully these changes also have an indirect benefit of avoiding soft 
lockups on the host side when larger guests (> 256GB ) are rebooted. 
Someone who has ready access to a larger Sandybridge-EP/EX platform can 
verify this.

FYI
Vinod
