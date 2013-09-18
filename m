From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] intel-iommu: Quiesce devices before disabling IOMMU
Date: Wed, 18 Sep 2013 17:03:36 +0800
Message-ID: <20130918090336.GB8846@dhcp-16-252.nay.redhat.com>
References: <1379484541-4496-1-git-send-email-indou.takao@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379484541-4496-1-git-send-email-indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 09/18/13 at 03:09pm, Takao Indoh wrote:
> This patch quiesces devices before disabling IOMMU on boot to stop
> ongoing DMA. In intel_iommu_init(), check context entries and if there
> is entry whose present bit is set then reset corresponding device.
> 
> When IOMMU is already enabled on boot, it is disabled and new DMAR table
> is created and then re-enabled in intel_iommu_init(). This causes DMAR
> faults if there are in-flight DMAs.
> 
> This causes problem on kdump. Devices are working in first kernel, and
> after switching to second kernel and initializing IOMMU, many DMAR
> faults occur and it causes problems like driver error or PCI SERR, at
> last kdump fails. This patch fixes this problem.
> 
> Changelog:
> v2:
> - Add CONTEXT_ENTRY_NR
> 
> v1:
> https://lkml.org/lkml/2013/8/21/71
> 
> Signed-off-by: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c |   56 ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 55 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index eec0d3e..d0e8aff 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -224,6 +224,7 @@ struct context_entry {
>  	u64 lo;
>  	u64 hi;
>  };
> +#define CONTEXT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct context_entry))
>  
>  static inline bool context_present(struct context_entry *context)
>  {
> @@ -3663,6 +3664,56 @@ static struct notifier_block device_nb = {
>  	.notifier_call = device_notifier,
>  };
>  
> +/* Reset PCI devices if its entry exists in DMAR table */
> +static void __init iommu_reset_devices(struct intel_iommu *iommu, u16 segment)
> +{
> +	u64 addr;
> +	struct root_entry *root;
> +	struct context_entry *context;
> +	int bus, devfn;
> +	struct pci_dev *dev;
> +
> +	addr = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
> +	if (!addr)
> +		return;
> +
> +	/*
> +	 *  In the case of kdump, ioremap is needed because root-entry table
> +	 *  exists in first kernel's memory area which is not mapped in second
> +	 *  kernel
> +	 */
> +	root = (struct root_entry *)ioremap(addr, PAGE_SIZE);
> +	if (!root)
> +		return;
> +
> +	for (bus = 0; bus < ROOT_ENTRY_NR; bus++) {
> +		if (!root_present(&root[bus]))
> +			continue;
> +
> +		context = (struct context_entry *)ioremap(
> +			root[bus].val & VTD_PAGE_MASK, PAGE_SIZE);
> +		if (!context)
> +			continue;
> +
> +		for (devfn = 0; devfn < CONTEXT_ENTRY_NR; devfn++) {
> +			if (!context_present(&context[devfn]))
> +				continue;
> +
> +			dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
> +			if (!dev)
> +				continue;
> +
> +			if (!pci_reset_bus(dev->bus)) /* go to next bus */
> +				break;
> +			else /* Try per-function reset */
> +				pci_reset_function(dev);
> +
> +		}
> +		iounmap(context);
> +	}
> +	iounmap(root);
> +}
> +
>  int __init intel_iommu_init(void)
>  {
>  	int ret = 0;
> @@ -3687,8 +3738,11 @@ int __init intel_iommu_init(void)
>  			continue;
>  
>  		iommu = drhd->iommu;
> -		if (iommu->gcmd & DMA_GCMD_TE)
> +		if (iommu->gcmd & DMA_GCMD_TE) {
> +			if (reset_devices)
> +				iommu_reset_devices(iommu, drhd->segment);
>  			iommu_disable_translation(iommu);
> +		}
>  	}
>  
>  	if (dmar_dev_scope_init() < 0) {


Looks good to me, thanks!
Acked-by: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

> -- 
> 1.7.1
> 
> 
